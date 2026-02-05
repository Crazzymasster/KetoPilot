import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/models/daily_summary_model.dart';
import '../repositories/summary_repository.dart';

/// Provider for summary repository
final summaryRepositoryProvider = Provider<SummaryRepository>((ref) {
  return SummaryRepository();
});

/// Provider for daily summary
final dailySummaryProvider = FutureProvider.family<DailySummaryModel, DateTime>(
  (ref, date) async {
    const userId = 1; // TODO: Get from auth provider
    final repository = ref.watch(summaryRepositoryProvider);
    return repository.getDailySummary(userId, date);
  },
);

/// Provider for weekly summaries
final weeklySummaryProvider = FutureProvider.family<List<DailySummaryModel>, DateTime>(
  (ref, weekStart) async {
    const userId = 1; // TODO: Get from auth provider
    final repository = ref.watch(summaryRepositoryProvider);
    return repository.getWeeklySummaries(userId, weekStart);
  },
);

