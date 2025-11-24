import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/repositories/food_repository.dart';
import '../../../../core/database/models/food_model.dart';
import '../../../../core/database/models/diet_entry_model.dart';
import '../../../../core/database/daos/drift_diet_entry_dao.dart';
import '../../../../core/database/daos/diet_entry_dao.dart';
import '../../../../core/database/daos/drift_food_dao.dart';
import '../../../../core/database/daos/food_dao.dart';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import '../widgets/macro_bars_widget.dart';

@RoutePage()
class FoodDiaryPage extends StatefulWidget {
  const FoodDiaryPage({super.key});

  @override
  State<FoodDiaryPage> createState() => _FoodDiaryPageState();
}

class _FoodDiaryPageState extends State<FoodDiaryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime.now();

  // Database DAOs
        final DriftDietEntryDao _dietEntryDao = DriftDietEntryDao();
        final DriftFoodDao _foodDao = DriftFoodDao();
  
  // Data from database
  List<_FoodEntryData> _todaysEntries = [];
  bool _isLoading = true;
  
  // Macro totals (calculated from entries)
  double _carbsConsumed = 0.0;
  double _proteinConsumed = 0.0;
  double _fatConsumed = 0.0;
  final double _carbsLimit = 20.0;
  final double _proteinGoal = 100.0;
  final double _fatGoal = 150.0;
  
  static const int _userId = 1; // TODO: Get from auth provider

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadDietEntries();
  }
  
  /// Load diet entries from database for selected date
  Future<void> _loadDietEntries() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final dateStr = _selectedDate.toIso8601String().split('T')[0];
      final entries = kIsWeb
          ? await _driftDietEntryDao.getDietEntriesByDate(_userId, dateStr)
          : await _dietEntryDao!.getDietEntriesByDate(_userId, dateStr);
      
      // Convert DietEntryModel to _FoodEntryData
      final foodEntries = <_FoodEntryData>[];
      
      for (final entry in entries) {
        // Get food details
        final food = kIsWeb
            ? await _driftFoodDao.getFoodById(entry.foodId)
            : await _foodDao!.getFoodById(entry.foodId);
        
        if (food != null) {
          foodEntries.add(_FoodEntryData(
            name: food.foodDescription,
            carbs: entry.totalCarbohydrateG,
            protein: entry.totalProteinG,
            fat: entry.totalFatG,
            calories: entry.totalEnergyKcal,
            timestamp: DateTime.parse(entry.recordedAt),
            servingSize: '${entry.servingSizeMultiplier}x',
            entryId: entry.entryId,
          ));
        }
      }
      
      // Calculate totals
      double carbs = 0.0;
      double protein = 0.0;
      double fat = 0.0;
      
      for (final entry in foodEntries) {
        carbs += entry.carbs;
        protein += entry.protein;
        fat += entry.fat;
      }
      
      setState(() {
        _todaysEntries = foodEntries;
        _carbsConsumed = carbs;
        _proteinConsumed = protein;
        _fatConsumed = fat;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading diet entries: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Diary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _searchFood(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).colorScheme.primary,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          tabs: const [
            Tab(
              text: 'Today',
              icon: Icon(Icons.today),
            ),
            Tab(
              text: 'History',
              icon: Icon(Icons.history),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildTodayTab(), _buildHistoryTab()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addFood(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodayTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    // Sort entries chronologically
    final sortedEntries = [..._todaysEntries]
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildDateSelector(),
          MacroBarsWidget(
            carbsGrams: _carbsConsumed,
            proteinGrams: _proteinConsumed,
            fatGrams: _fatConsumed,
            carbsLimit: _carbsLimit,
            proteinGoal: _proteinGoal,
            fatGoal: _fatGoal,
          ),
          _buildMacroSummary(),
          _buildQuickAddSection(),
          _buildTimelineHeader(),
          _buildFoodTimeline(sortedEntries),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return _WeeklyHistoryView(
      driftDietEntryDao: _driftDietEntryDao,
      dietEntryDao: _dietEntryDao,
      userId: _userId,
    );
  }

  Widget _buildDateSelector() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Text(
            _formatDate(_selectedDate),
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          if (_isToday(_selectedDate))
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Today',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMacroSummary() {
    double totalCalories = _todaysEntries.fold(
      0,
      (sum, entry) => sum + entry.calories,
    );
    double netCarbs = _carbsConsumed - 8.0; // Assuming 8g fiber

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMacroSummaryItem(
            'Calories',
            totalCalories.toStringAsFixed(0),
            'kcal',
          ),
          _buildMacroSummaryItem('Net Carbs', netCarbs.toStringAsFixed(1), 'g'),
          _buildMacroSummaryItem('Fiber', '8.0', 'g'),
        ],
      ),
    );
  }

  Widget _buildMacroSummaryItem(String label, String value, String unit) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          unit,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildQuickAddSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _addFoodAtTime(DateTime.now()),
              icon: const Icon(Icons.add),
              label: const Text('Add Now'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _addFoodAtCustomTime(),
              icon: const Icon(Icons.schedule),
              label: const Text('Custom Time'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.timeline,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'Food Timeline',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Spacer(),
          Text(
            '${_todaysEntries.length} entries',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodTimeline(List<_FoodEntryData> sortedEntries) {
    if (sortedEntries.isEmpty) {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 48,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
            const SizedBox(height: 12),
            Text(
              'No food logged today',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap "Add Now" to log your first meal',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: sortedEntries.asMap().entries.map((entry) {
        final index = entry.key;
        final foodEntry = entry.value;
        final isLast = index == sortedEntries.length - 1;

        return _buildTimelineEntry(foodEntry, isLast);
      }).toList(),
    );
  }

  Widget _buildTimelineEntry(_FoodEntryData entry, bool isLast) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 80,
                  color: Theme.of(context).dividerColor,
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Food entry content
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 16 : 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _buildTimelineEntryContent(entry),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineEntryContent(_FoodEntryData entry) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Time and food name
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                DateFormat('h:mm a').format(entry.timestamp),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  if (entry.servingSize.isNotEmpty)
                    Text(
                      entry.servingSize,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 20),
              onPressed: () => _editFoodEntry(entry),
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(4),
                  tooltip: 'Edit entry',
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: () => _confirmDeleteEntry(entry),
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(4),
                  tooltip: 'Delete entry',
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Macro information
        Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMacroChip('C', entry.carbs, Colors.orange),
                  _buildMacroChip('P', entry.protein, Colors.blue),
                  _buildMacroChip('F', entry.fat, Colors.green),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${entry.calories.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  'cal',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMacroChip(String label, double value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            '${value.toStringAsFixed(0)}g',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '${difference} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
      _loadDietEntries(); // Reload entries for new date
    }
  }

  void _searchFood() {
    // TODO: Implement food search
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Food search coming soon!'),
        backgroundColor: AppTheme.infoColor,
      ),
    );
  }

  Future<void> _addFood() async {
    // Database now works on web with Drift!
    // Removed web blocking - Drift supports IndexedDB on web
    
    final foodRepository = FoodRepository();
    const userId = 1; // TODO: Get from auth provider
    
    // Check if user can create food
    try {
      final canCreate = await foodRepository.canCreateFood(userId);
      if (!canCreate.canCreate) {
        if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Food creation limit reached. Reset date: ${canCreate.resetDate}',
            ),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 4),
          ),
        );
        return;
      }
    } catch (e) {
      // If check fails, continue anyway (might be first time user)
      debugPrint('Could not check food creation limit: $e');
    }

    // Show add food dialog
    if (!mounted) return;
    final result = await showDialog<FoodModel>(
      context: context,
      builder: (context) => _AddFoodDialog(),
    );

    if (result != null) {
      try {
        // Show loading indicator
        if (!mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );

        // Create the food
        final foodId = await foodRepository.createFood(
          food: result,
          userId: userId,
        );

        // Create diet entry for today
        final now = DateTime.now();
        final dateStr = now.toIso8601String().split('T')[0];
        final netCarbs = result.netCarbsG ?? (result.totalCarbohydrateG - (result.dietaryFiberG ?? 0.0));
        
        final dietEntry = DietEntryModel(
          userId: userId,
          foodId: foodId,
          recordedAt: now.toIso8601String(),
          date: dateStr,
          servingSizeMultiplier: 1.0,
          totalEnergyKcal: result.energyKcal,
          totalProteinG: result.totalProteinG,
          totalFatG: result.totalFatG,
          totalCarbohydrateG: result.totalCarbohydrateG,
          totalNetCarbsG: netCarbs,
          totalFiberG: result.dietaryFiberG,
        );
        
        // Insert diet entry
        if (kIsWeb) {
          await _driftDietEntryDao.insertDietEntry(dietEntry);
        } else {
          await _dietEntryDao!.insertDietEntry(dietEntry);
        }

        // Close loading indicator
        if (!mounted) return;
        Navigator.of(context).pop();

        // Show success message
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Food added successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Reload entries to show new food in timeline
        await _loadDietEntries();
      } catch (e) {
        // Close loading indicator
        if (!mounted) return;
        Navigator.of(context).pop();

        // Show error message
        if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
            content: Text('Error adding food: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  Future<void> _addFoodAtTime(DateTime time) async {
    // For now, use the same add food dialog
    // In the future, this could pre-fill the time or create a diet entry directly
    await _addFood();
  }

  Future<void> _addFoodAtCustomTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      final DateTime customDateTime = DateTime.now().copyWith(
        hour: time.hour,
        minute: time.minute,
        second: 0,
      );
      _addFoodAtTime(customDateTime);
    }
  }

  Future<void> _editFoodEntry(_FoodEntryData entry) async {
    if (entry.entryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot edit entry: missing entry ID'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Get the full diet entry from database
    try {
      final dietEntry = kIsWeb
          ? await _driftDietEntryDao.getDietEntryById(entry.entryId!)
          : await _dietEntryDao!.getDietEntryById(entry.entryId!);

      if (dietEntry == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Entry not found'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Get food details
      final food = kIsWeb
          ? await _driftFoodDao.getFoodById(dietEntry.foodId)
          : await _foodDao!.getFoodById(dietEntry.foodId);

      if (food == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Food not found'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Show edit dialog
      if (!mounted) return;
      final result = await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (context) => _EditDietEntryDialog(
          entry: dietEntry,
          food: food,
        ),
      );

      if (result != null) {
        // Update or delete
        if (result['action'] == 'delete') {
          await _deleteDietEntry(entry.entryId!);
        } else if (result['action'] == 'update') {
          await _updateDietEntry(
            dietEntry,
            result['multiplier'] as double,
            result['time'] as DateTime,
            result['calories'] as double,
            result['netCarbs'] as double,
            result['protein'] as double,
            result['fat'] as double,
            result['carbs'] as double,
            result['fiber'] as double? ?? 0.0,
          );
        }
      }
    } catch (e) {
      debugPrint('Error editing entry: $e');
      if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _updateDietEntry(
    DietEntryModel entry,
    double multiplier,
    DateTime newTime,
    double calories,
    double netCarbs,
    double protein,
    double fat,
    double carbs,
    double fiber,
  ) async {
    try {
      final dateStr = newTime.toIso8601String().split('T')[0];

      final updatedEntry = DietEntryModel(
        entryId: entry.entryId,
        userId: entry.userId,
        foodId: entry.foodId,
        recordedAt: newTime.toIso8601String(),
        date: dateStr,
        portionId: entry.portionId,
        customPortionGrams: entry.customPortionGrams,
        servingSizeMultiplier: multiplier,
        totalEnergyKcal: calories,
        totalProteinG: protein,
        totalFatG: fat,
        totalCarbohydrateG: carbs,
        totalNetCarbsG: netCarbs,
        totalFiberG: fiber,
        totalSodiumMg: entry.totalSodiumMg,
        mealContext: entry.mealContext,
        location: entry.location,
        notes: entry.notes,
        foodPhotoUrl: entry.foodPhotoUrl,
        synced: 0, // Mark as unsynced after update
      );

      if (kIsWeb) {
        await _driftDietEntryDao.updateDietEntry(updatedEntry);
      } else {
        await _dietEntryDao!.updateDietEntry(updatedEntry);
      }

      // Reload entries
      await _loadDietEntries();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Entry updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      debugPrint('Error updating entry: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating entry: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _confirmDeleteEntry(_FoodEntryData entry) async {
    if (entry.entryId == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Entry'),
        content: Text('Are you sure you want to delete "${entry.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _deleteDietEntry(entry.entryId!);
    }
  }

  Future<void> _deleteDietEntry(int entryId) async {
    try {
      if (kIsWeb) {
        await _driftDietEntryDao.deleteDietEntry(entryId);
      } else {
        await _dietEntryDao!.deleteDietEntry(entryId);
      }

      // Reload entries
      await _loadDietEntries();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Entry deleted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      debugPrint('Error deleting entry: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting entry: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

/// Dialog for adding a new food
class _AddFoodDialog extends StatefulWidget {
  @override
  State<_AddFoodDialog> createState() => _AddFoodDialogState();
}

class _AddFoodDialogState extends State<_AddFoodDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _fatController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fiberController = TextEditingController(text: '0');
  double _netCarbs = 0.0;

  @override
  void initState() {
    super.initState();
    _carbsController.addListener(_updateNetCarbs);
    _fiberController.addListener(_updateNetCarbs);
  }

  void _updateNetCarbs() {
    setState(() {
      _netCarbs = _calculateNetCarbs();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _fatController.dispose();
    _carbsController.removeListener(_updateNetCarbs);
    _carbsController.dispose();
    _fiberController.removeListener(_updateNetCarbs);
    _fiberController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final food = FoodModel(
        foodDescription: _nameController.text.trim(),
        energyKcal: double.parse(_caloriesController.text),
        totalProteinG: double.parse(_proteinController.text),
        totalFatG: double.parse(_fatController.text),
        totalCarbohydrateG: double.parse(_carbsController.text),
        dietaryFiberG: double.tryParse(_fiberController.text) ?? 0.0,
        source: 'user',
        isKetoFriendly: _calculateNetCarbs() <= 20 ? 1 : 0,
      );

      Navigator.of(context).pop(food);
    }
  }

  double _calculateNetCarbs() {
    final carbs = double.tryParse(_carbsController.text) ?? 0.0;
    final fiber = double.tryParse(_fiberController.text) ?? 0.0;
    return carbs - fiber;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Food'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Food Name *',
                  hintText: 'e.g., Grilled Chicken Breast',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a food name';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _caloriesController,
                      decoration: const InputDecoration(
                        labelText: 'Calories *',
                        hintText: 'kcal',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Invalid number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _proteinController,
                      decoration: const InputDecoration(
                        labelText: 'Protein (g) *',
                        hintText: '0.0',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Invalid';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _fatController,
                      decoration: const InputDecoration(
                        labelText: 'Fat (g) *',
                        hintText: '0.0',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Invalid';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _carbsController,
                      decoration: const InputDecoration(
                        labelText: 'Carbs (g) *',
                        hintText: '0.0',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Invalid';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _fiberController,
                      decoration: const InputDecoration(
                        labelText: 'Fiber (g)',
                        hintText: '0.0',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _netCarbs <= 20
                      ? Colors.green.shade50
                      : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _netCarbs <= 20
                        ? Colors.green.shade200
                        : Colors.orange.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _netCarbs <= 20 ? Icons.check_circle : Icons.info,
                      color: _netCarbs <= 20 ? Colors.green : Colors.orange,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Net Carbs: ${_netCarbs.toStringAsFixed(1)}g',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _netCarbs <= 20 ? Colors.green.shade700 : Colors.orange.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Add Food'),
        ),
      ],
    );
  }
}

/// Dialog for editing a diet entry
class _EditDietEntryDialog extends StatefulWidget {
  final DietEntryModel entry;
  final FoodModel food;

  const _EditDietEntryDialog({
    required this.entry,
    required this.food,
  });

  @override
  State<_EditDietEntryDialog> createState() => _EditDietEntryDialogState();
}

class _EditDietEntryDialogState extends State<_EditDietEntryDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _quantityController;
  late TextEditingController _caloriesController;
  late TextEditingController _netCarbsController;
  late TextEditingController _proteinController;
  late TextEditingController _fatController;
  late TextEditingController _carbsController;
  late TextEditingController _fiberController;
  late DateTime _selectedTime;
  late TimeOfDay _selectedTimeOfDay;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(
      text: widget.entry.servingSizeMultiplier.toStringAsFixed(2),
    );
    _caloriesController = TextEditingController(
      text: widget.entry.totalEnergyKcal.toStringAsFixed(1),
    );
    _netCarbsController = TextEditingController(
      text: widget.entry.totalNetCarbsG.toStringAsFixed(1),
    );
    _proteinController = TextEditingController(
      text: widget.entry.totalProteinG.toStringAsFixed(1),
    );
    _fatController = TextEditingController(
      text: widget.entry.totalFatG.toStringAsFixed(1),
    );
    _carbsController = TextEditingController(
      text: widget.entry.totalCarbohydrateG.toStringAsFixed(1),
    );
    _fiberController = TextEditingController(
      text: (widget.entry.totalFiberG ?? 0.0).toStringAsFixed(1),
    );
    _selectedTime = DateTime.parse(widget.entry.recordedAt);
    _selectedTimeOfDay = TimeOfDay.fromDateTime(_selectedTime);
    
    // Add listeners to update net carbs when carbs or fiber change
    _carbsController.addListener(_updateNetCarbs);
    _fiberController.addListener(_updateNetCarbs);
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _caloriesController.dispose();
    _netCarbsController.dispose();
    _proteinController.dispose();
    _fatController.dispose();
    _carbsController.removeListener(_updateNetCarbs);
    _carbsController.dispose();
    _fiberController.removeListener(_updateNetCarbs);
    _fiberController.dispose();
    super.dispose();
  }

  void _updateNetCarbs() {
    final carbs = double.tryParse(_carbsController.text) ?? 0.0;
    final fiber = double.tryParse(_fiberController.text) ?? 0.0;
    final netCarbs = carbs - fiber;
    final currentNetCarbs = double.tryParse(_netCarbsController.text) ?? 0.0;
    if ((netCarbs - currentNetCarbs).abs() > 0.01) {
      _netCarbsController.text = netCarbs.toStringAsFixed(1);
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final multiplier = double.tryParse(_quantityController.text) ?? widget.entry.servingSizeMultiplier;
      final calories = double.tryParse(_caloriesController.text);
      final netCarbs = double.tryParse(_netCarbsController.text);
      final protein = double.tryParse(_proteinController.text);
      final fat = double.tryParse(_fatController.text);
      final carbs = double.tryParse(_carbsController.text);
      final fiber = double.tryParse(_fiberController.text) ?? 0.0;

      if (calories == null || netCarbs == null || protein == null || fat == null || carbs == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter valid numbers for all fields'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (multiplier <= 0 || calories < 0 || protein < 0 || fat < 0 || carbs < 0 || netCarbs < 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Values must be positive numbers'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Update the time
      final updatedTime = _selectedTime.copyWith(
        hour: _selectedTimeOfDay.hour,
        minute: _selectedTimeOfDay.minute,
        second: 0,
      );

      Navigator.of(context).pop({
        'action': 'update',
        'multiplier': multiplier,
        'calories': calories,
        'netCarbs': netCarbs,
        'protein': protein,
        'fat': fat,
        'carbs': carbs,
        'fiber': fiber,
        'time': updatedTime,
      });
    }
  }

  void _delete() {
    Navigator.of(context).pop({'action': 'delete'});
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTimeOfDay,
    );
    if (picked != null) {
      setState(() {
        _selectedTimeOfDay = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit ${widget.food.foodDescription}'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Food name (read-only)
              Text(
                widget.food.foodDescription,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              // Quantity input
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity (servings) *',
                  hintText: 'e.g., 1.5',
                  border: OutlineInputBorder(),
                  helperText: 'Enter the number of servings',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  final num = double.tryParse(value);
                  if (num == null || num <= 0) {
                    return 'Please enter a valid positive number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Time picker
              InkWell(
                onTap: _selectTime,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Time *',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.access_time),
                  ),
                  child: Text(
                    _selectedTimeOfDay.format(context),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Calories
              TextFormField(
                controller: _caloriesController,
                decoration: const InputDecoration(
                  labelText: 'Calories (kcal) *',
                  hintText: '0.0',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  final num = double.tryParse(value);
                  if (num == null || num < 0) {
                    return 'Invalid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              // Net Carbs
              TextFormField(
                controller: _netCarbsController,
                decoration: const InputDecoration(
                  labelText: 'Net Carbs (g) *',
                  hintText: '0.0',
                  border: OutlineInputBorder(),
                  helperText: 'Auto-calculated from Carbs - Fiber',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  final num = double.tryParse(value);
                  if (num == null || num < 0) {
                    return 'Invalid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              // Protein and Fat
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _proteinController,
                      decoration: const InputDecoration(
                        labelText: 'Protein (g) *',
                        hintText: '0.0',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        final num = double.tryParse(value);
                        if (num == null || num < 0) {
                          return 'Invalid';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _fatController,
                      decoration: const InputDecoration(
                        labelText: 'Fat (g) *',
                        hintText: '0.0',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        final num = double.tryParse(value);
                        if (num == null || num < 0) {
                          return 'Invalid';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Carbs and Fiber
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _carbsController,
                      decoration: const InputDecoration(
                        labelText: 'Carbs (g) *',
                        hintText: '0.0',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        final num = double.tryParse(value);
                        if (num == null || num < 0) {
                          return 'Invalid';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _fiberController,
                      decoration: const InputDecoration(
                        labelText: 'Fiber (g)',
                        hintText: '0.0',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        // Delete button
        TextButton(
          onPressed: _delete,
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text('Delete'),
        ),
        const Spacer(),
        // Cancel button
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        // Save button
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class _FoodEntryData {
  final String name;
  final double carbs;
  final double protein;
  final double fat;
  final double calories;
  final DateTime timestamp;
  final String servingSize;
  final int? entryId; // For editing/deleting

  _FoodEntryData({
    required this.name,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.calories,
    required this.timestamp,
    required this.servingSize,
    this.entryId,
  });
}

/// Weekly History View Widget
class _WeeklyHistoryView extends StatefulWidget {
  final DriftDietEntryDao driftDietEntryDao;
  final DietEntryDao? dietEntryDao;
  final int userId;

  const _WeeklyHistoryView({
    required this.driftDietEntryDao,
    required this.dietEntryDao,
    required this.userId,
  });

  @override
  State<_WeeklyHistoryView> createState() => _WeeklyHistoryViewState();
}

class _WeeklyHistoryViewState extends State<_WeeklyHistoryView> {
  DateTime _selectedWeekStart = _getWeekStart(DateTime.now());
  bool _isLoading = true;
  Map<String, _DailyMacros> _weeklyData = {};

  static DateTime _getWeekStart(DateTime date) {
    final weekday = date.weekday;
    return date.subtract(Duration(days: weekday - 1));
  }

  @override
  void initState() {
    super.initState();
    _loadWeeklyData();
  }

  Future<void> _loadWeeklyData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final weekEnd = _selectedWeekStart.add(const Duration(days: 6));
      final startDate = _selectedWeekStart.toIso8601String().split('T')[0];
      final endDate = weekEnd.toIso8601String().split('T')[0];

      final entries = kIsWeb
          ? await widget.driftDietEntryDao.getDietEntriesByDateRange(
              widget.userId, startDate, endDate)
          : await widget.dietEntryDao!.getDietEntriesByDateRange(
              widget.userId, startDate, endDate);

      // Group entries by date and calculate daily totals
      final dailyTotals = <String, _DailyMacros>{};
      
      for (int i = 0; i < 7; i++) {
        final date = _selectedWeekStart.add(Duration(days: i));
        final dateStr = date.toIso8601String().split('T')[0];
        dailyTotals[dateStr] = _DailyMacros(
          date: date,
          carbs: 0.0,
          protein: 0.0,
          fat: 0.0,
        );
      }

      for (final entry in entries) {
        final dateStr = entry.date;
        if (dailyTotals.containsKey(dateStr)) {
          dailyTotals[dateStr]!.carbs += entry.totalCarbohydrateG;
          dailyTotals[dateStr]!.protein += entry.totalProteinG;
          dailyTotals[dateStr]!.fat += entry.totalFatG;
        }
      }

      setState(() {
        _weeklyData = dailyTotals;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading weekly data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _previousWeek() {
    setState(() {
      _selectedWeekStart = _selectedWeekStart.subtract(const Duration(days: 7));
    });
    _loadWeeklyData();
  }

  void _nextWeek() {
    setState(() {
      _selectedWeekStart = _selectedWeekStart.add(const Duration(days: 7));
    });
    _loadWeeklyData();
  }

  void _selectWeek() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedWeekStart,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        _selectedWeekStart = _getWeekStart(date);
      });
      _loadWeeklyData();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final weekEnd = _selectedWeekStart.add(const Duration(days: 6));
    final weekRange = '${DateFormat('MMM d').format(_selectedWeekStart)} - ${DateFormat('MMM d, yyyy').format(weekEnd)}';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Week selector
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _previousWeek,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: _selectWeek,
                    child: Column(
                      children: [
                        Text(
                          weekRange,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tap to select week',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: _nextWeek,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Weekly summary
          _buildWeeklySummary(),
          const SizedBox(height: 24),
          
          // Daily breakdown
          Text(
            'Daily Breakdown',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Daily cards
          ...List.generate(7, (index) {
            final date = _selectedWeekStart.add(Duration(days: index));
            final dateStr = date.toIso8601String().split('T')[0];
            final macros = _weeklyData[dateStr] ?? _DailyMacros(
              date: date,
              carbs: 0.0,
              protein: 0.0,
              fat: 0.0,
            );
            return _buildDailyCard(macros);
          }),
        ],
      ),
    );
  }

  Widget _buildWeeklySummary() {
    double totalCarbs = 0.0;
    double totalProtein = 0.0;
    double totalFat = 0.0;

    for (final macros in _weeklyData.values) {
      totalCarbs += macros.carbs;
      totalProtein += macros.protein;
      totalFat += macros.fat;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Totals',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMacroSummaryItem(
                  'Carbs',
                  totalCarbs.toStringAsFixed(1),
                  'g',
                  Colors.orange,
                ),
              ),
              Expanded(
                child: _buildMacroSummaryItem(
                  'Protein',
                  totalProtein.toStringAsFixed(1),
                  'g',
                  Colors.blue,
                ),
              ),
              Expanded(
                child: _buildMacroSummaryItem(
                  'Fat',
                  totalFat.toStringAsFixed(1),
                  'g',
                  Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroSummaryItem(String label, String value, String unit, Color color) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.circle, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          unit,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDailyCard(_DailyMacros macros) {
    final isToday = macros.date.year == DateTime.now().year &&
        macros.date.month == DateTime.now().month &&
        macros.date.day == DateTime.now().day;
    
    final dayName = DateFormat('EEE').format(macros.date);
    final dayNumber = macros.date.day;
    final monthName = DateFormat('MMM').format(macros.date);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isToday
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).dividerColor,
          width: isToday ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isToday
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      dayName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isToday
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      '$dayNumber',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isToday
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      monthName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isToday
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              if (isToday) ...[
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Today',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
          
          // Macro bars
          _buildMacroBar('Carbs', macros.carbs, Colors.orange, 20.0),
          const SizedBox(height: 8),
          _buildMacroBar('Protein', macros.protein, Colors.blue, 100.0),
          const SizedBox(height: 8),
          _buildMacroBar('Fat', macros.fat, Colors.green, 150.0),
        ],
      ),
    );
  }

  Widget _buildMacroBar(String label, double value, Color color, double maxValue) {
    final percentage = (value / maxValue).clamp(0.0, 1.0);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text(
              '${value.toStringAsFixed(1)}g',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: color.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}

class _DailyMacros {
  final DateTime date;
  double carbs;
  double protein;
  double fat;

  _DailyMacros({
    required this.date,
    required this.carbs,
    required this.protein,
    required this.fat,
  });
}
