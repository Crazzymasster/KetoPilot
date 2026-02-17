import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../core/database/daos/drift_diet_entry_dao.dart';
import '../../../../core/providers/user_provider.dart';
import '../../../food_diary/presentation/widgets/macro_bars_widget.dart';
import '../widgets/molecule_bars_widget.dart';
import '../widgets/swipeable_section_widget.dart';
import '../widgets/weekly_nutrition_widget.dart';
import '../widgets/weekly_molecules_widget.dart';

@RoutePage()
class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  int _selectedIndex = 0;
  final DriftDietEntryDao _dietEntryDao = DriftDietEntryDao();
  bool _profileSetupShown = false;

  bool _isLoadingNutrition = true;
  double _todayCarbs = 0.0;
  double _todayProtein = 0.0;
  double _todayFat = 0.0;

  double _carbsLimit = 20.0;
  double _proteinGoal = 100.0;
  double _fatGoal = 150.0;

  @override
  void initState() {
    super.initState();
    _loadUserTargets();
    _loadTodaysNutrition();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _maybeShowProfileSetup();
    });
  }

  Future<void> _maybeShowProfileSetup() async {
    if (_profileSetupShown) return;

    final user = ref.read(userProvider).currentUser;
    if (user == null) return;

    // Check if this specific user has already completed profile setup
    if (user.profileSetupCompleted == 1) return;

    _profileSetupShown = true;

    if (!mounted) return;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ProfileSetupDialog(
        onCompleted: () async {
          // Mark profile setup as completed for this user in the database
          final currentUser = ref.read(userProvider).currentUser;
          if (currentUser != null) {
            final updatedUser = currentUser.copyWith(
              profileSetupCompleted: 1,
              updatedAt: DateTime.now().toIso8601String(),
            );
            await ref.read(userProvider.notifier).updateProfile(updatedUser);
          }
        },
      ),
    );
  }

  void _loadUserTargets() {
    final user = ref.read(userProvider).currentUser;
    if (user != null) {
      setState(() {
        _carbsLimit = user.targetNetCarbs;
        _proteinGoal = user.targetProtein ?? 100.0;
        _fatGoal = user.targetFat ?? 150.0;
      });
    }
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
      final entries = await _dietEntryDao.getDietEntriesByDate(
        user!.userId!,
        dateStr,
      );

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Show notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Show more options
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await _loadTodaysNutrition();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _buildWelcomeSection(),
              _buildGkiCard(),
              _buildQuickActionsGrid(),
              _buildMacroPreviewSection(),
              _buildQuickMetricsSection(),
              _buildRecentReadingsSection(),
              _buildEducationSection(),
              const SizedBox(height: 100), // Space for FAB
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
              _navigateToIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(
              context,
            ).colorScheme.onSurface.withOpacity(0.6),
            selectedLabelStyle: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.dashboard_outlined, size: 22),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.dashboard, size: 22),
                ),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.restaurant_outlined, size: 22),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.restaurant, size: 22),
                ),
                label: 'Diary',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.analytics_outlined, size: 22),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.analytics, size: 22),
                ),
                label: 'Trends',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.more_horiz, size: 22),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.more_horiz, size: 22),
                ),
                label: 'More',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.pushNamed('/data-entry');
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 28,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.onPrimary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  Icons.waving_hand,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning, John!',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'How are you feeling today?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onPrimary.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildWelcomeMetric(
                  icon: Icons.local_fire_department,
                  title: 'Streak',
                  value: '12 days',
                  subtitle: 'In ketosis',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildWelcomeMetric(
                  icon: Icons.trending_up,
                  title: 'Progress',
                  value: '85%',
                  subtitle: 'Goal achieved',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeMetric({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.onPrimary, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGkiCard() {
    // Mock data - in real app this would come from state management
    const double glucose = 85.0;
    const double ketones = 1.2;
    const double gki = glucose / (ketones * 18.0);

    Color getGkiColor() {
      if (gki <= 3.0) return AppTheme.optimalColor;
      if (gki <= 6.0) return AppTheme.therapeuticColor;
      if (gki <= 9.0) return AppTheme.cautionColor;
      return AppTheme.criticalColor;
    }

    String getGkiStatus() {
      if (gki <= 3.0) return 'Optimal';
      if (gki <= 6.0) return 'Therapeutic';
      if (gki <= 9.0) return 'Moderate';
      return 'High';
    }

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Glucose-Ketone Index',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: () {
                    // TODO: Show GKI information
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: getGkiColor(), width: 8),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      gki.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: getGkiColor(),
                          ),
                    ),
                    Text(
                      getGkiStatus(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: getGkiColor(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildGkiMetric(
                    icon: Icons.water_drop,
                    label: 'Glucose',
                    value: '${glucose.toStringAsFixed(0)} mg/dL',
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildGkiMetric(
                    icon: Icons.science,
                    label: 'Ketones',
                    value: '${ketones.toStringAsFixed(1)} mmol/L',
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGkiMetric({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.4,
            children: [
              _buildQuickActionCard(
                icon: Icons.add_circle,
                title: 'Log Data',
                subtitle: 'Add glucose & ketones',
                color: Theme.of(context).colorScheme.primary,
                onTap: () => context.router.pushNamed('/data-entry'),
              ),
              _buildQuickActionCard(
                icon: Icons.restaurant,
                title: 'Food Diary',
                subtitle: 'Track your meals',
                color: Colors.orange,
                onTap: () => context.router.pushNamed('/food-diary'),
              ),
              _buildQuickActionCard(
                icon: Icons.favorite,
                title: 'Health Log',
                subtitle: 'Log symptoms & wellness',
                color: Colors.red,
                onTap: () => context.router.pushNamed('/health-logging'),
              ),
              _buildQuickActionCard(
                icon: Icons.analytics,
                title: 'Analytics',
                subtitle: 'View trends & insights',
                color: Colors.blue,
                onTap: () {
                  // TODO: Navigate to analytics
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      color: color.withOpacity(0.1),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 11,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMacroPreviewSection() {
    return Column(
      children: [
        // Swipeable Nutrition Section (Daily/Weekly)
        SwipeableSectionWidget(
          title: 'Nutrition',
          dailyWidget: _isLoadingNutrition
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              : MacroBarsWidget(
                  carbsGrams: _todayCarbs,
                  proteinGrams: _todayProtein,
                  fatGrams: _todayFat,
                  carbsLimit: _carbsLimit,
                  proteinGoal: _proteinGoal,
                  fatGoal: _fatGoal,
                  maxBarHeight: 120.0,
                  showTargetLines: true,
                  showValues: true,
                ),
          weeklyWidget: const WeeklyNutritionWidget(),
          actionText: 'Food Diary',
          onActionTap: () => context.router.pushNamed('/food-diary'),
        ),

        const SizedBox(height: 8),

        // Swipeable Molecules Section (Daily/Weekly)
        SwipeableSectionWidget(
          title: 'Biomarkers',
          dailyWidget: MoleculeBarsWidget(
            glucoseMgDl: 85.0, // Example values
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
      ],
    );
  }

  Widget _buildQuickMetricsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Today\'s Metrics',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to full metrics
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  icon: Icons.scale,
                  title: 'Weight',
                  value: '70.5 kg',
                  change: '-0.2 kg',
                  isPositive: false,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  icon: Icons.favorite,
                  title: 'Heart Rate',
                  value: '72 bpm',
                  change: '+3 bpm',
                  isPositive: true,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required String title,
    required String value,
    required String change,
    required bool isPositive,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const Spacer(),
                Icon(
                  isPositive ? Icons.trending_up : Icons.trending_down,
                  color: isPositive ? Colors.green : Colors.red,
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              change,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isPositive ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentReadingsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Recent Readings',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to history
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildRecentReadingItem(
                time: 'Today, ${8 + index * 2}:00 AM',
                glucose: 85 + (index * 5),
                ketones: 1.2 - (index * 0.1),
                gki: (85 + (index * 5)) / ((1.2 - (index * 0.1)) * 18.0),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecentReadingItem({
    required String time,
    required double glucose,
    required double ketones,
    required double gki,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: gki <= 3.0
                ? AppTheme.optimalColor
                : AppTheme.therapeuticColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              gki.toStringAsFixed(1),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        title: Text(
          time,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          'Glucose: ${glucose.toStringAsFixed(0)} mg/dL • Ketones: ${ketones.toStringAsFixed(1)} mmol/L',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        trailing: Icon(
          gki <= 3.0 ? Icons.check_circle : Icons.info,
          color: gki <= 3.0 ? AppTheme.optimalColor : AppTheme.therapeuticColor,
        ),
      ),
    );
  }

  Widget _buildEducationSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Learn More',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(
                      Icons.school,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Understanding Your GKI',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Learn how to interpret your glucose-ketone index for optimal health.',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.7),
                              ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.5),
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToIndex(int index) {
    switch (index) {
      case 0:
        // Already on dashboard
        break;
      case 1:
        context.router.pushNamed('/food-diary');
        break;
      case 2:
        context.router.pushNamed('/trends');
        break;
      case 3:
        context.router.pushNamed('/settings');
        break;
    }
  }
}

class ProfileSetupDialog extends ConsumerStatefulWidget {
  const ProfileSetupDialog({super.key, required this.onCompleted});

  final Future<void> Function() onCompleted;

  @override
  ConsumerState<ProfileSetupDialog> createState() => _ProfileSetupDialogState();
}

class _ProfileSetupDialogState extends ConsumerState<ProfileSetupDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;
  String? _selectedGender;
  DateTime? _selectedDateOfBirth;
  DateTime? _ketoStartDate;
  String? _dobError;
  String? _genderError;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late TextEditingController _targetCarbsController;
  late TextEditingController _targetProteinController;
  late TextEditingController _targetFatController;
  late TextEditingController _targetCaloriesController;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider).currentUser;
    _selectedGender = user?.gender;
    if (user?.dateOfBirth != null) {
      _selectedDateOfBirth = DateTime.tryParse(user!.dateOfBirth!);
    }
    if (user?.ketoStartDate != null) {
      _ketoStartDate = DateTime.tryParse(user!.ketoStartDate!);
    }

    _heightController = TextEditingController(
      text: user?.heightCm?.toString() ?? '',
    );
    _weightController = TextEditingController(
      text: user?.initialWeightKg?.toString() ?? '',
    );
    _targetCarbsController = TextEditingController(
      text: user?.targetNetCarbs.toString() ?? '20',
    );
    _targetProteinController = TextEditingController(
      text: user?.targetProtein?.toString() ?? '',
    );
    _targetFatController = TextEditingController(
      text: user?.targetFat?.toString() ?? '',
    );
    _targetCaloriesController = TextEditingController(
      text: user?.targetCalories?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _targetCarbsController.dispose();
    _targetProteinController.dispose();
    _targetFatController.dispose();
    _targetCaloriesController.dispose();
    super.dispose();
  }

  Future<void> _selectDateOfBirth() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateOfBirth ?? DateTime(1990),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDateOfBirth = picked;
        _dobError = null;
      });
    }
  }

  Future<void> _selectKetoStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _ketoStartDate ?? DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => _ketoStartDate = picked);
    }
  }

  String? _validateNonNegativeNumber(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) return null;
    final parsed = double.tryParse(value.trim());
    if (parsed == null) {
      return 'Invalid $fieldName';
    }
    if (parsed < 0) {
      return 'Cannot be negative';
    }
    return null;
  }

  double? _parseOptionalDouble(String value) {
    if (value.trim().isEmpty) return null;
    return double.tryParse(value.trim());
  }

  Future<void> _completeSetup() async {
    setState(() {
      _dobError = _selectedDateOfBirth == null ? 'Required' : null;
      _genderError = (_selectedGender == null || _selectedGender!.isEmpty) ? 'Required' : null;
    });

    if (_dobError != null || _genderError != null) return;
    if (_formKey.currentState?.validate() != true) return;

    final user = ref.read(userProvider).currentUser;
    if (user == null) return;

    setState(() => _isSaving = true);

    final updatedUser = user.copyWith(
      gender: _selectedGender,
      dateOfBirth: _selectedDateOfBirth?.toIso8601String().split('T')[0],
      heightCm: _parseOptionalDouble(_heightController.text),
      initialWeightKg: _parseOptionalDouble(_weightController.text),
      targetNetCarbs: _parseOptionalDouble(_targetCarbsController.text) ?? 20.0,
      targetProtein: _parseOptionalDouble(_targetProteinController.text),
      targetFat: _parseOptionalDouble(_targetFatController.text),
      targetCalories: _parseOptionalDouble(_targetCaloriesController.text),
      ketoStartDate: _ketoStartDate?.toIso8601String().split('T')[0],
      updatedAt: DateTime.now().toIso8601String(),
    );

    final success = await ref
        .read(userProvider.notifier)
        .updateProfile(updatedUser);

    if (!mounted) return;

    if (success) {
      await widget.onCompleted();
      if (mounted) {
        Navigator.of(context).pop();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to save profile. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }

    if (mounted) {
      setState(() => _isSaving = false);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header with close button
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Column(
                          children: [
                            Text(
                              'Complete Profile',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Quick setup to personalize your experience.',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: -8,
                        top: -8,
                        child: IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () => Navigator.of(context).pop(),
                          splashRadius: 18,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                        ),
                      ),
                    ],
                  ),
                  
                  const Divider(height: 20),
                  
                  // Birthday section
                  _buildSectionLabel('Birthday', required: true),
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: _selectDateOfBirth,
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _dobError != null ? colorScheme.error : colorScheme.outline,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.cake_outlined, size: 18, color: colorScheme.onSurfaceVariant),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _selectedDateOfBirth != null
                                  ? _formatDate(_selectedDateOfBirth!)
                                  : 'Select date',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: _selectedDateOfBirth != null
                                    ? colorScheme.onSurface
                                    : colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_drop_down, color: colorScheme.onSurfaceVariant),
                        ],
                      ),
                    ),
                  ),
                  if (_dobError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 12),
                      child: Text(_dobError!, style: TextStyle(color: colorScheme.error, fontSize: 12)),
                    ),
                  
                  const SizedBox(height: 12),
                  
                  // Gender section (radio buttons like Facebook)
                  _buildSectionLabel('Gender', required: true),
                  const SizedBox(height: 6),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _genderError != null ? colorScheme.error : colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        _buildGenderOption('Female'),
                        _buildGenderOption('Male'),
                        _buildGenderOption('Other'),
                      ],
                    ),
                  ),
                  if (_genderError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 12),
                      child: Text(_genderError!, style: TextStyle(color: colorScheme.error, fontSize: 12)),
                    ),
                  
                  const Divider(height: 24),
                  
                  // Physical info (side by side)
                  _buildSectionLabel('Physical Info', required: false),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCompactTextField(
                          controller: _heightController,
                          hint: 'Height (cm)',
                          icon: Icons.height,
                          validator: (v) => _validateNonNegativeNumber(v, 'height'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildCompactTextField(
                          controller: _weightController,
                          hint: 'Weight (kg)',
                          icon: Icons.monitor_weight_outlined,
                          validator: (v) => _validateNonNegativeNumber(v, 'weight'),
                        ),
                      ),
                    ],
                  ),
                  
                  const Divider(height: 24),
                  
                  // Keto Goals section
                  _buildSectionLabel('Keto Goals', required: false),
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: _selectKetoStartDate,
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: colorScheme.outline),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today_outlined, size: 18, color: colorScheme.onSurfaceVariant),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _ketoStartDate != null
                                  ? 'Started: ${_formatDate(_ketoStartDate!)}'
                                  : 'Keto start date',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: _ketoStartDate != null
                                    ? colorScheme.onSurface
                                    : colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_drop_down, color: colorScheme.onSurfaceVariant),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCompactTextField(
                          controller: _targetCarbsController,
                          hint: 'Carbs (g)',
                          icon: Icons.grain,
                          validator: (v) => _validateNonNegativeNumber(v, 'carbs'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildCompactTextField(
                          controller: _targetProteinController,
                          hint: 'Protein (g)',
                          icon: Icons.egg_outlined,
                          validator: (v) => _validateNonNegativeNumber(v, 'protein'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCompactTextField(
                          controller: _targetFatController,
                          hint: 'Fat (g)',
                          icon: Icons.opacity,
                          validator: (v) => _validateNonNegativeNumber(v, 'fat'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildCompactTextField(
                          controller: _targetCaloriesController,
                          hint: 'Calories',
                          icon: Icons.local_fire_department_outlined,
                          validator: (v) => _validateNonNegativeNumber(v, 'calories'),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Submit button
                  SizedBox(
                    height: 40,
                    child: FilledButton(
                      onPressed: _isSaving ? null : _completeSetup,
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: _isSaving
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('Save Profile', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label, {required bool required}) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        if (required)
          Text(
            ' *',
            style: TextStyle(color: theme.colorScheme.error, fontSize: 12),
          ),
      ],
    );
  }

  Widget _buildGenderOption(String gender) {
    final theme = Theme.of(context);
    final isSelected = _selectedGender == gender;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() {
          _selectedGender = gender;
          _genderError = null;
        }),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline,
                    width: 1.5,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 6),
              Text(
                gender,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      validator: validator,
      style: theme.textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
        prefixIcon: Icon(icon, size: 18),
        prefixIconConstraints: const BoxConstraints(minWidth: 36),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
      ),
    );
  }
}
