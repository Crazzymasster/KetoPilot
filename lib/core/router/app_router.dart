import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/data_entry/presentation/pages/data_entry_page.dart';
import '../../features/food_diary/presentation/pages/food_diary_page.dart';
import '../../features/health_logging/presentation/pages/health_logging_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/database_test/database_test_page.dart';
import '../../features/trends/presentation/pages/trends_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    // Auth routes
    AutoRoute(page: LoginRoute.page, path: '/login', initial: true),
    
    // Onboarding route
    AutoRoute(page: OnboardingRoute.page, path: '/onboarding'),

    // Main app routes
    AutoRoute(page: DashboardRoute.page, path: '/dashboard'),

    AutoRoute(page: DataEntryRoute.page, path: '/data-entry'),

    AutoRoute(page: FoodDiaryRoute.page, path: '/food-diary'),

    AutoRoute(page: HealthLoggingRoute.page, path: '/health-logging'),

    AutoRoute(page: SettingsRoute.page, path: '/settings'),
    
    AutoRoute(page: ProfileRoute.page, path: '/profile'),

    AutoRoute(page: TrendsRoute.page, path: '/trends'),

    // Database test route
    AutoRoute(page: DatabaseTestRoute.page, path: '/database-test'),
  ];
}
