import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:intl/intl.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../core/database/models/diet_entry_model.dart';
import '../../../../core/database/daos/drift_diet_entry_dao.dart';
import '../../../../core/database/daos/diet_entry_dao.dart';
import '../../../../core/database/daos/drift_food_dao.dart';
import '../../../../core/database/daos/food_dao.dart';
import '../../../../core/database/models/food_model.dart';

@RoutePage()
class DataEntryPage extends StatefulWidget {
  const DataEntryPage({super.key});

  @override
  State<DataEntryPage> createState() => _DataEntryPageState();
}

class _DataEntryPageState extends State<DataEntryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Date and time
  DateTime _selectedDateTime = DateTime.now();

  // Nutrition controllers
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();

  // Biomarker controllers
  final TextEditingController _glucoseController = TextEditingController();
  final TextEditingController _bhbController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  // Database DAOs
  final DriftDietEntryDao _driftDietEntryDao = DriftDietEntryDao();
  final DietEntryDao? _dietEntryDao = kIsWeb ? null : DietEntryDao();
  final DriftFoodDao _driftFoodDao = DriftFoodDao();
  final FoodDao? _foodDao = kIsWeb ? null : FoodDao();

  static const int _userId = 1; // TODO: Get from auth provider

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _carbsController.dispose();
    _proteinController.dispose();
    _fatController.dispose();
    _glucoseController.dispose();
    _bhbController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.router.pushNamed('/dashboard'),
          tooltip: 'Cancel and return to dashboard',
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).colorScheme.onPrimary,
          labelColor: Theme.of(context).colorScheme.onPrimary,
          unselectedLabelColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
          tabs: [
            Tab(
              icon: Icon(
                Icons.restaurant,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              text: 'Nutrition',
            ),
            Tab(
              icon: Icon(
                Icons.biotech,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              text: 'Biomarkers',
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [_buildNutritionTab(), _buildBiomarkersTab()],
      ),
    );
  }

  Widget _buildNutritionTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'Daily Macronutrients',
            'Enter your daily macro totals',
            Icons.bar_chart,
          ),
          const SizedBox(height: 16),
          _buildDateTimeSelector(),
          const SizedBox(height: 16),
          _buildMacroInputSection(),
          const SizedBox(height: 24),
          _buildActionButtons(isNutrition: true),
        ],
      ),
    );
  }

  Widget _buildBiomarkersTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'Daily Biomarkers',
            'Log your metabolic measurements',
            Icons.science,
          ),
          const SizedBox(height: 16),
          _buildDateTimeSelector(),
          const SizedBox(height: 16),
          _buildBiomarkerInputSection(),
          const SizedBox(height: 24),
          _buildActionButtons(isNutrition: false),
        ],
      ),
    );
  }

  Widget _buildDateTimeSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Date & Time',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('MMM dd, yyyy').format(_selectedDateTime),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  onTap: () => _selectTime(),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('h:mm a').format(_selectedDateTime),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (date != null) {
      setState(() {
        _selectedDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          _selectedDateTime.hour,
          _selectedDateTime.minute,
        );
      });
    }
  }

  Future<void> _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
    );
    if (time != null) {
      setState(() {
        _selectedDateTime = DateTime(
          _selectedDateTime.year,
          _selectedDateTime.month,
          _selectedDateTime.day,
          time.hour,
          time.minute,
        );
      });
    }
  }

  Widget _buildSectionHeader(String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroInputSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMacroInputCard(
                'Carbs',
                'grams',
                _carbsController,
                Colors.orange,
                'Limit: 20g',
                Icons.grain,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMacroInputCard(
                'Protein',
                'grams',
                _proteinController,
                Colors.blue,
                'Goal: 80g',
                Icons.fitness_center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMacroInputCard(
                'Fat',
                'grams',
                _fatController,
                Colors.green,
                'Goal: 45g',
                Icons.opacity,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.info_outline, color: Colors.grey.shade600),
                    const SizedBox(height: 8),
                    Text(
                      'Gram-focused tracking for optimal ketosis',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBiomarkerInputSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildBiomarkerInputCard(
                'Glucose',
                'mg/dL',
                _glucoseController,
                Colors.orange.shade600,
                'Target: <100',
                Icons.water_drop,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildBiomarkerInputCard(
                'BHB',
                'mmol/L',
                _bhbController,
                Colors.yellow.shade700,
                'Target: >0.5',
                Icons.science,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildBiomarkerInputCard(
                'Weight',
                'kg',
                _weightController,
                Colors.blue.shade600,
                'Optional',
                Icons.scale,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.calculate,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'GKI auto-calculated from glucose & BHB',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMacroInputCard(
    String label,
    String unit,
    TextEditingController controller,
    Color color,
    String target,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
            decoration: InputDecoration(
              hintText: '0',
              suffixText: unit,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: color.withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: color, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            target,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiomarkerInputCard(
    String label,
    String unit,
    TextEditingController controller,
    Color color,
    String target,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
            decoration: InputDecoration(
              hintText: '0.0',
              suffixText: unit,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: color.withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: color, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            target,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons({required bool isNutrition}) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _saveData(isNutrition),
            icon: const Icon(Icons.save),
            label: Text(
              isNutrition ? 'Save Nutrition Data' : 'Save Biomarker Data',
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _clearData(isNutrition),
                icon: const Icon(Icons.clear),
                label: const Text('Clear All'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => context.router.pushNamed('/dashboard'),
                icon: const Icon(Icons.close),
                label: const Text('Cancel'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _saveData(bool isNutrition) async {
    try {
      if (isNutrition) {
        await _saveNutritionData();
      } else {
        await _saveBiomarkerData();
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isNutrition
                ? 'Nutrition data saved successfully!'
                : 'Biomarker data saved successfully!',
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          action: SnackBarAction(
            label: 'View Dashboard',
            textColor: Theme.of(context).colorScheme.onPrimary,
            onPressed: () => context.router.pushNamed('/dashboard'),
          ),
        ),
      );

      // Clear fields after successful save
      if (isNutrition) {
        _carbsController.clear();
        _proteinController.clear();
        _fatController.clear();
      } else {
        _glucoseController.clear();
        _bhbController.clear();
        _weightController.clear();
      }

      // Navigate to dashboard after a short delay
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          context.router.pushNamed('/dashboard');
        }
      });
    } catch (e) {
      debugPrint('Error saving data: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving data: ${e.toString()}'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  Future<void> _saveNutritionData() async {
    final carbs = double.tryParse(_carbsController.text) ?? 0.0;
    final protein = double.tryParse(_proteinController.text) ?? 0.0;
    final fat = double.tryParse(_fatController.text) ?? 0.0;

    if (carbs == 0.0 && protein == 0.0 && fat == 0.0) {
      throw Exception('Please enter at least one macro value');
    }

    // Calculate calories (approximate: 4 cal/g for carbs and protein, 9 cal/g for fat)
    final calories = (carbs * 4) + (protein * 4) + (fat * 9);
    final netCarbs = carbs; // Assuming no fiber for manual entry

    // Create a temporary food entry for "Daily Totals"
    final food = FoodModel(
      foodDescription: 'Daily Totals - ${DateFormat('MMM dd').format(_selectedDateTime)}',
      energyKcal: calories,
      totalProteinG: protein,
      totalFatG: fat,
      totalCarbohydrateG: carbs,
      dietaryFiberG: 0.0,
      netCarbsG: netCarbs,
      source: 'manual_entry',
      isKetoFriendly: netCarbs <= 20 ? 1 : 0,
    );

    // Insert food first
    final foodId = kIsWeb
        ? await _driftFoodDao.insertFood(food)
        : await _foodDao!.insertFood(food);

    // Create diet entry
    final dateStr = _selectedDateTime.toIso8601String().split('T')[0];
    final dietEntry = DietEntryModel(
      userId: _userId,
      foodId: foodId,
      recordedAt: _selectedDateTime.toIso8601String(),
      date: dateStr,
      servingSizeMultiplier: 1.0,
      totalEnergyKcal: calories,
      totalProteinG: protein,
      totalFatG: fat,
      totalCarbohydrateG: carbs,
      totalNetCarbsG: netCarbs,
      totalFiberG: 0.0,
      notes: 'Manual entry from Data Entry page',
    );

    // Insert diet entry
    if (kIsWeb) {
      await _driftDietEntryDao.insertDietEntry(dietEntry);
    } else {
      await _dietEntryDao!.insertDietEntry(dietEntry);
    }
  }

  Future<void> _saveBiomarkerData() async {
    // TODO: Implement biomarker saving to health_logs table
    // For now, just show a message
    final glucose = double.tryParse(_glucoseController.text);
    final bhb = double.tryParse(_bhbController.text);
    final weight = double.tryParse(_weightController.text);

    if (glucose == null && bhb == null && weight == null) {
      throw Exception('Please enter at least one biomarker value');
    }

    // TODO: Save to health_logs table
    // This requires implementing HealthLogDao with Drift support
    debugPrint('Biomarker data: Glucose=$glucose, BHB=$bhb, Weight=$weight');
  }

  void _clearData(bool isNutrition) {
    if (isNutrition) {
      _carbsController.clear();
      _proteinController.clear();
      _fatController.clear();
    } else {
      _glucoseController.clear();
      _bhbController.clear();
      _weightController.clear();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All fields cleared'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
