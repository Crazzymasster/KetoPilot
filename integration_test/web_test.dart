import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:metabolicapp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    // Initialize FFI for testing (if needed)
    // Note: sqflite doesn't work on web, so database tests should be skipped
    try {
      sqfliteFfiInit();
    } catch (e) {
      // Ignore if not available (e.g., on web)
    }
  });

  group('Web Integration Tests', () {
    testWidgets('App launches and shows initial route', (WidgetTester tester) async {
      // Build the app
      await tester.pumpWidget(const ProviderScope(child: app.MetabolicHealthApp()));
      await tester.pumpAndSettle();

      // Verify the app structure is present
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('App has correct title', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: app.MetabolicHealthApp()));
      await tester.pumpAndSettle();

      // Verify app title
      final MaterialApp materialApp = tester.widget(find.byType(MaterialApp));
      expect(materialApp.title, equals('Metabolic Health Companion'));
    });

    testWidgets('App is responsive', (WidgetTester tester) async {
      // Test desktop size
      await tester.binding.setSurfaceSize(const Size(1920, 1080));
      await tester.pumpWidget(const ProviderScope(child: app.MetabolicHealthApp()));
      await tester.pumpAndSettle();
      expect(find.byType(MaterialApp), findsOneWidget);

      // Test tablet size
      await tester.binding.setSurfaceSize(const Size(768, 1024));
      await tester.pumpWidget(const ProviderScope(child: app.MetabolicHealthApp()));
      await tester.pumpAndSettle();
      expect(find.byType(MaterialApp), findsOneWidget);

      // Test mobile size
      await tester.binding.setSurfaceSize(const Size(375, 667));
      await tester.pumpWidget(const ProviderScope(child: app.MetabolicHealthApp()));
      await tester.pumpAndSettle();
      expect(find.byType(MaterialApp), findsOneWidget);

      // Reset to default
      await tester.binding.setSurfaceSize(null);
    });
  });
}




