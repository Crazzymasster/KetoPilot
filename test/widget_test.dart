// Widget tests for KetoPilot app
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:metabolicapp/main.dart';

void main() {
  setUpAll(() {
    // Initialize FFI for testing (required for sqflite in tests)
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  testWidgets('App launches and shows initial route', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MetabolicHealthApp()));
    await tester.pumpAndSettle();

    // The app should load (initial route is onboarding)
    // Verify the app structure is present
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('App has correct title', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MetabolicHealthApp()));
    await tester.pumpAndSettle();

    // Verify app title is set correctly
    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    expect(app.title, equals('Metabolic Health Companion'));
  });
}
