import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/themes/app_theme.dart';
import 'core/database/drift_database_service.dart';
import 'core/database/services/food_database_seeder.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/user_provider.dart';
import 'core/config/email_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database in background (non-blocking)
  // This allows the app to start immediately while DB initializes
  _initializeDatabaseAsync();
  
  EmailConfig.configureGmail(
    email: 'ketoapp00@gmail.com',
    appPassword: 'rxvrkjbanthiaeif',  
  );

  // Start app immediately without waiting for database
  runApp(const ProviderScope(child: MetabolicHealthApp()));
}

/// Initialize database asynchronously without blocking app startup
void _initializeDatabaseAsync() {
  // Run in background without blocking - database will be lazy-loaded when first used
  // This allows app to start immediately
  Future.microtask(() async {
    try {
      final driftService = DriftDatabaseService();
      // Pre-initialize in background (non-blocking)
      await driftService.database;
      debugPrint('[MAIN] ✅ Database ready');
      
      // Seed the database with NCC sample foods if empty
      final seeder = FoodDatabaseSeeder();
      await seeder.seedIfNeeded();
    } catch (e) {
      // Log error but don't crash the app
      debugPrint('[MAIN] ⚠️ Database init: $e');
    }
  });
}

class MetabolicHealthApp extends ConsumerStatefulWidget {
  const MetabolicHealthApp({super.key});

  @override
  ConsumerState<MetabolicHealthApp> createState() => _MetabolicHealthAppState();
}

class _MetabolicHealthAppState extends ConsumerState<MetabolicHealthApp> {
  // AppRouter is now stored in state, so it persists across rebuilds
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    // Check auth on startup - will redirect if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuth();
    });
  }

  Future<void> _checkAuth() async {
    final userNotifier = ref.read(userProvider.notifier);
    
    // Wait for user provider to finish loading
    while (userNotifier.isLoading) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    
    // If user is authenticated, navigate to dashboard
    if (userNotifier.isAuthenticated && mounted) {
      _appRouter.replace(const DashboardRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Metabolic Health Companion',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
