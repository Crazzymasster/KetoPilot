import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/themes/app_theme.dart';
import 'core/database/drift_database_service.dart';
import 'core/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database in background (non-blocking)
  // This allows the app to start immediately while DB initializes
  _initializeDatabaseAsync();
  
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
