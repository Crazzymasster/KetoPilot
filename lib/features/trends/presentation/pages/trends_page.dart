import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../dashboard/presentation/widgets/weekly_molecules_widget.dart';
import '../../../dashboard/presentation/widgets/weekly_nutrition_widget.dart';
import '../../../dashboard/presentation/widgets/macro_bars_widget.dart';
import '../../../dashboard/presentation/widgets/molecule_bars_widget.dart';

@RoutePage()
class TrendsPage extends StatefulWidget {
  const TrendsPage({super.key});

  @override
  State<TrendsPage> createState() => _TrendsPageState();
}

class _TrendsPageState extends State<TrendsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          indicatorColor: Theme.of(context).colorScheme.primary,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
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
          _buildSectionHeader(
            'Weekly Nutrition Overview',
            'Track your macronutrient intake trends',
            Icons.bar_chart,
          ),
          const SizedBox(height: 16),
          _buildSwipeableCard(
            title: 'Nutrition',
            dailyWidget: MacroBarsWidget(
              carbsGrams: 11.0,
              proteinGrams: 75.0,
              fatGrams: 50.0,
              carbsLimit: 20.0,
              proteinGoal: 80.0,
              fatGoal: 45.0,
              maxBarHeight: 120.0,
              showTargetLines: true,
              showValues: true,
            ),
            weeklyWidget: const WeeklyNutritionWidget(),
            actionText: 'Food Diary',
            onActionTap: () => context.router.pushNamed('/food-diary'),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(
            'Macro Trends',
            'Weekly averages and patterns',
            Icons.timeline,
          ),
          const SizedBox(height: 16),
          _buildMacroTrendsCard(),
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
                Expanded(child: _buildTab('Daily', true)),
                Expanded(child: _buildTab('Weekly', false)),
              ],
            ),
          ),
          Container(
            height: 320,
            padding: const EdgeInsets.all(16),
            child: dailyWidget, // For now, show daily. Can be made swipeable later
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement tab switching
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

  Widget _buildMacroTrendsCard() {
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
            'Macro Trends (Last 7 Days)',
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
}

