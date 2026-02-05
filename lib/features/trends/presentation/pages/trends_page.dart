import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/themes/app_theme.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../core/database/daos/drift_diet_entry_dao.dart';
import '../../../../core/providers/user_provider.dart';
import '../../../dashboard/presentation/widgets/weekly_molecules_widget.dart';
import '../../../dashboard/presentation/widgets/weekly_nutrition_widget.dart';
import '../../../food_diary/presentation/widgets/macro_bars_widget.dart';
import '../../../dashboard/presentation/widgets/molecule_bars_widget.dart';
import '../../utils/weekly_nutrition_utils.dart';

@RoutePage()
class TrendsPage extends ConsumerStatefulWidget {
  const TrendsPage({super.key});

  @override
  ConsumerState<TrendsPage> createState() => _TrendsPageState();
}

class _TrendsPageState extends ConsumerState<TrendsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DriftDietEntryDao _dietEntryDao = DriftDietEntryDao();
  
  double _todayCarbs = 0.0;
  double _todayProtein = 0.0;
  double _todayFat = 0.0;
  bool _isLoadingNutrition = true;
  
  double _weeklyAvgCarbs = 0.0;
  double _weeklyAvgProtein = 0.0;
  double _weeklyAvgFat = 0.0;
  Map<String, Map<String, double>> _weeklyData = {};
  
  bool _showDailyView = true;
  
  String? _selectedDay;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadTodaysNutrition();
    _loadWeeklyNutrition();
  }

  Future<void> _loadTodaysNutrition() async {
    final user = ref.read(userProvider).currentUser;
    if (user?.userId == null) return;
    
    setState(() {
      _isLoadingNutrition = true;
    });
    
    try {
      final now = DateTime.now();
      final dateStr = now.toIso8601String().split('T')[0];
      final entries = await _dietEntryDao.getDietEntriesByDate(user!.userId!, dateStr);
      
      double carbs = 0.0;
      double protein = 0.0;
      double fat = 0.0;
      
      for (final entry in entries) {
        carbs += entry.totalCarbohydrateG;
        protein += entry.totalProteinG;
        fat += entry.totalFatG;
      }
      
      setState(() {
        _todayCarbs = carbs;
        _todayProtein = protein;
        _todayFat = fat;
        _isLoadingNutrition = false;
      });
    } catch (e) {
      debugPrint('Error loading nutrition data: $e');
      setState(() {
        _isLoadingNutrition = false;
      });
    }
  }

  Future<void> _loadWeeklyNutrition() async {
    final user = ref.read(userProvider).currentUser;
    if (user?.userId == null) return;
    
    try {
      final weekRange = WeeklyNutritionUtils.getCurrentWeekRange();
      final weekStart = weekRange['start']!;
      final weekEnd = weekRange['end']!;
      
      final startDate = WeeklyNutritionUtils.toDateString(weekStart);
      final endDate = WeeklyNutritionUtils.toDateString(weekEnd);
      
      final entries = await _dietEntryDao.getDietEntriesByDateRange(
        user!.userId!,
        startDate,
        endDate,
      );
      
      //populate all 7 days, even those with no entries
      final dailyData = WeeklyNutritionUtils.initializeWeekData(weekStart);
      
      double totalCarbs = 0.0;
      double totalProtein = 0.0;
      double totalFat = 0.0;
      
      for (final entry in entries) {
        final date = entry.date;
        if (dailyData.containsKey(date)) {
          dailyData[date]!['carbs'] = (dailyData[date]!['carbs'] ?? 0.0) + entry.totalCarbohydrateG;
          dailyData[date]!['protein'] = (dailyData[date]!['protein'] ?? 0.0) + entry.totalProteinG;
          dailyData[date]!['fat'] = (dailyData[date]!['fat'] ?? 0.0) + entry.totalFatG;
          
          final calories = (entry.totalProteinG * 4) + (entry.totalCarbohydrateG * 4) + (entry.totalFatG * 9);
          dailyData[date]!['calories'] = (dailyData[date]!['calories'] ?? 0.0) + calories;
        }
        
        totalCarbs += entry.totalCarbohydrateG;
        totalProtein += entry.totalProteinG;
        totalFat += entry.totalFatG;
      }
      
      final daysWithData = dailyData.length > 0 ? dailyData.length : 1;
      
      setState(() {
        _weeklyData = dailyData;
        _weeklyAvgCarbs = totalCarbs / daysWithData;
        _weeklyAvgProtein = totalProtein / daysWithData;
        _weeklyAvgFat = totalFat / daysWithData;
      });
    } catch (e) {
      debugPrint('Error loading weekly nutrition data: $e');
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
        title: const Text('Trends & Analytics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Show filter dialog
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.6),
          tabs: const [
            Tab(icon: Icon(Icons.biotech), text: 'Biomarkers'),
            Tab(icon: Icon(Icons.restaurant), text: 'Nutrition'),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBiomarkersTab(),
          _buildNutritionTab(),
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
            'Weekly Biomarkers Overview',
            'Track your glucose, ketones, and GKI trends',
            Icons.trending_up,
          ),
          const SizedBox(height: 16),
          _buildSwipeableCard(
            title: 'Biomarkers',
            dailyWidget: MoleculeBarsWidget(
              glucoseMgDl: 85.0,
              bhbMmol: 1.2,
              gki: 4.1,
              glucoseTarget: 100.0,
              bhbTarget: 1.5,
              gkiTarget: 1.0,
              maxBarHeight: 120.0,
              showTargetLines: true,
              showValues: true,
            ),
            weeklyWidget: const WeeklyMoleculesWidget(),
            actionText: 'Log Data',
            onActionTap: () => context.router.pushNamed('/data-entry'),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(
            'GKI Trend',
            'Glucose-Ketone Index over time',
            Icons.show_chart,
          ),
          const SizedBox(height: 16),
          _buildGkiTrendCard(),
          const SizedBox(height: 24),
          _buildSectionHeader(
            'Health Insights',
            'Key metrics and recommendations',
            Icons.insights,
          ),
          const SizedBox(height: 16),
          _buildInsightsCard(),
        ],
      ),
    );
  }

  Widget _buildNutritionTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _isLoadingNutrition
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              : _buildSwipeableCard(
                  title: 'Nutrition',
                  dailyWidget: _buildDailyNutritionView(),
                  weeklyWidget: _buildWeeklyNutritionView(),
                  actionText: 'Food Diary',
                  onActionTap: () => context.router.pushNamed('/food-diary'),
                ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 24,
          ),
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
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSwipeableCard({
    required String title,
    required Widget dailyWidget,
    required Widget weeklyWidget,
    required String actionText,
    required VoidCallback onActionTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: onActionTap,
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  ),
                  child: Text(
                    actionText,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(child: _buildTab('Daily', _showDailyView)),
                Expanded(child: _buildTab('Weekly', !_showDailyView)),
              ],
            ),
          ),
          Container(
            height: 1000,
            padding: const EdgeInsets.all(16),
            child: _showDailyView ? dailyWidget : weeklyWidget,
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showDailyView = text == 'Daily';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildGkiTrendCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GKI Trend (Last 7 Days)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Chart visualization coming soon',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Key Insights',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInsightItem(
            'Your GKI is in the optimal range',
            'Keep maintaining your current diet and lifestyle',
            Icons.check_circle,
            Colors.green,
          ),
          const SizedBox(height: 12),
          _buildInsightItem(
            'Consistent ketone levels',
            'Your body is adapting well to ketosis',
            Icons.trending_up,
            Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String title, String subtitle, IconData icon, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDailyNutritionView() {
    final totalCalories = ((_todayProtein * 4) + (_todayCarbs * 4) + (_todayFat * 9));
    
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MacroBarsWidget(
            carbsGrams: _todayCarbs,
            proteinGrams: _todayProtein,
            fatGrams: _todayFat,
            carbsLimit: 20.0,
            proteinGoal: 100.0,
            fatGoal: 150.0,
            maxBarHeight: 120.0,
            showTargetLines: true,
            showValues: true,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Analytics',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildAnalyticsStat(
                  'Total Calories',
                  '${totalCalories.toStringAsFixed(0)} kcal',
                  Icons.local_fire_department,
                  const Color(0xFFD84315),
                ),
                const SizedBox(height: 10),
                _buildAnalyticsStat(
                  'Net Carbs',
                  '${_todayCarbs.toStringAsFixed(1)}g',
                  Icons.grain,
                  const Color(0xFFE65100),
                ),
                const SizedBox(height: 10),
                _buildAnalyticsStat(
                  'Protein',
                  '${_todayProtein.toStringAsFixed(1)}g',
                  Icons.fitness_center,
                  const Color(0xFF1565C0),
                ),
                const SizedBox(height: 10),
                _buildAnalyticsStat(
                  'Fat',
                  '${_todayFat.toStringAsFixed(1)}g',
                  Icons.water_drop,
                  const Color(0xFF6A1B9A),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsStat(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.4), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyNutritionView() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Total Calories Per Day',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              'Tap any day to see detailed breakdown',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildSimpleBarChart(),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Weekly Averages',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildAnalyticsStat(
                  'Avg Carbs',
                  '${_weeklyAvgCarbs.toStringAsFixed(1)}g',
                  Icons.grain,
                  const Color(0xFFE65100),
                ),
                const SizedBox(height: 10),
                _buildAnalyticsStat(
                  'Avg Protein',
                  '${_weeklyAvgProtein.toStringAsFixed(1)}g',
                  Icons.fitness_center,
                  const Color(0xFF1565C0),
                ),
                const SizedBox(height: 10),
                _buildAnalyticsStat(
                  'Avg Fat',
                  '${_weeklyAvgFat.toStringAsFixed(1)}g',
                  Icons.water_drop,
                  const Color(0xFF6A1B9A),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          if (_selectedDay != null && _weeklyData.containsKey(_selectedDay))
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: _buildDayDetails(_selectedDay!),
            ),
        ],
      ),
    );
  }

  Widget _buildSimpleBarChart() {
    final sortedDates = _weeklyData.keys.toList()..sort();
    
    if (sortedDates.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'No data available for this week',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ),
      );
    }

    //scale bars based on highest calorie day
    double maxValue = 0;
    for (final date in sortedDates) {
      final data = _weeklyData[date]!;
      final calories = data['calories'] ?? 0;
      if (calories > maxValue) maxValue = calories;
    }
    
    if (maxValue < 100) maxValue = 2000;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 220,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: sortedDates.map((date) {
            final data = _weeklyData[date]!;
            final dayName = WeeklyNutritionUtils.getDayName(date);
            final calories = data['calories'] ?? 0;
            final isSelected = _selectedDay == date;
            return _buildDayBar(
              date,
              dayName,
              calories,
              maxValue,
              isSelected,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDayDetails(String date) {
    final data = _weeklyData[date]!;
    final carbs = data['carbs'] ?? 0;
    final protein = data['protein'] ?? 0;
    final fat = data['fat'] ?? 0;
    final dayName = WeeklyNutritionUtils.getDayName(date);
    final formattedDate = DateFormat('MMM d').format(DateTime.parse(date));
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.calendar_today, size: 18, color: const Color(0xFFD84315)),
            const SizedBox(width: 8),
            Text(
              '$dayName, $formattedDate',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: () {
                setState(() {
                  _selectedDay = null;
                });
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildAnalyticsStat(
          'Carbs',
          '${carbs.toStringAsFixed(1)}g',
          Icons.grain,
          const Color(0xFFE65100),
        ),
        const SizedBox(height: 10),
        _buildAnalyticsStat(
          'Protein',
          '${protein.toStringAsFixed(1)}g',
          Icons.fitness_center,
          const Color(0xFF1565C0),
        ),
        const SizedBox(height: 10),
        _buildAnalyticsStat(
          'Fat',
          '${fat.toStringAsFixed(1)}g',
          Icons.water_drop,
          const Color(0xFF6A1B9A),
        ),
      ],
    );
  }

  Widget _buildDayBar(String date, String day, double calories, double maxValue, bool isSelected) {
    final barHeight = 160.0;
    final height = maxValue > 0 ? (calories / maxValue) * barHeight : 0.0;
    
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedDay = _selectedDay == date ? null : date;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                calories > 0 ? calories.toStringAsFixed(0) : '0',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  color: isSelected ? const Color(0xFFD84315) : Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                height: height.clamp(4.0, barHeight),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFD84315) : const Color(0xFFD84315).withOpacity(0.75),
                  borderRadius: BorderRadius.circular(6),
                  border: isSelected ? Border.all(color: const Color(0xFFBF360C), width: 2.5) : null,
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: const Color(0xFFD84315).withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ] : null,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                day,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  color: isSelected ? const Color(0xFFD84315) : Theme.of(context).textTheme.bodySmall?.color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

