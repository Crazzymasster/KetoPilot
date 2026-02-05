import 'dart:async';
import '../database/database_service.dart';

/// Service for performance benchmarking and monitoring
class PerformanceBenchmarkService {
  final DatabaseService _dbService = DatabaseService();

  /// Benchmark a query execution time
  Future<QueryBenchmarkResult> benchmarkQuery(
    String queryName,
    Future<void> Function() queryFunction,
  ) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      await queryFunction();
      stopwatch.stop();
      
      return QueryBenchmarkResult(
        queryName: queryName,
        executionTimeMs: stopwatch.elapsedMilliseconds,
        success: true,
      );
    } catch (e) {
      stopwatch.stop();
      return QueryBenchmarkResult(
        queryName: queryName,
        executionTimeMs: stopwatch.elapsedMilliseconds,
        success: false,
        error: e.toString(),
      );
    }
  }

  /// Benchmark dashboard query (should be < 10ms)
  Future<QueryBenchmarkResult> benchmarkDashboardQuery(int userId, String date) async {
    return await benchmarkQuery(
      'Dashboard Query',
      () async {
        final db = await _dbService.database;
        await db.query(
          'tb_daily_summary',
          where: 'user_id = ? AND date = ?',
          whereArgs: [userId, date],
        );
      },
    );
  }

  /// Benchmark food search (should be < 50ms)
  Future<QueryBenchmarkResult> benchmarkFoodSearch(String query) async {
    return await benchmarkQuery(
      'Food Search',
      () async {
        final db = await _dbService.database;
        await db.query(
          'tb_food',
          where: 'food_description LIKE ?',
          whereArgs: ['%$query%'],
          limit: 20,
        );
      },
    );
  }

  /// Benchmark weekly report (should be < 100ms)
  Future<QueryBenchmarkResult> benchmarkWeeklyReport(int userId) async {
    return await benchmarkQuery(
      'Weekly Report',
      () async {
        final db = await _dbService.database;
        await db.rawQuery('''
          SELECT * FROM tb_daily_summary 
          WHERE user_id = ? 
            AND date >= date('now', '-7 days')
          ORDER BY date
        ''', [userId]);
      },
    );
  }

  /// Run all benchmarks
  Future<BenchmarkReport> runAllBenchmarks(int userId) async {
    final results = <QueryBenchmarkResult>[];

    // Dashboard query
    final today = DateTime.now().toIso8601String().split('T')[0];
    results.add(await benchmarkDashboardQuery(userId, today));

    // Food search
    results.add(await benchmarkFoodSearch('avocado'));

    // Weekly report
    results.add(await benchmarkWeeklyReport(userId));

    return BenchmarkReport(results: results);
  }
}

/// Result of a query benchmark
class QueryBenchmarkResult {
  final String queryName;
  final int executionTimeMs;
  final bool success;
  final String? error;

  QueryBenchmarkResult({
    required this.queryName,
    required this.executionTimeMs,
    required this.success,
    this.error,
  });

  bool get isWithinTarget {
    return switch (queryName) {
      'Dashboard Query' => executionTimeMs < 10,
      'Food Search' => executionTimeMs < 50,
      'Weekly Report' => executionTimeMs < 100,
      _ => true,
    };
  }
}

/// Benchmark report
class BenchmarkReport {
  final List<QueryBenchmarkResult> results;

  BenchmarkReport({required this.results});

  String getSummary() {
    final buffer = StringBuffer();
    buffer.writeln('=== Performance Benchmark Report ===\n');

    for (final result in results) {
      final status = result.isWithinTarget ? '✓' : '✗';
      buffer.writeln(
        '$status ${result.queryName}: ${result.executionTimeMs}ms '
        '${result.isWithinTarget ? "(Target met)" : "(Target exceeded)"}',
      );
      if (result.error != null) {
        buffer.writeln('  Error: ${result.error}');
      }
    }

    final allPassed = results.every((r) => r.isWithinTarget && r.success);
    buffer.writeln('\nOverall: ${allPassed ? "✓ ALL BENCHMARKS PASSED" : "✗ SOME BENCHMARKS FAILED"}');

    return buffer.toString();
  }
}

