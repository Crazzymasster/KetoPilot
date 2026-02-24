import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/models/diet_entry_model.dart';
import '../repositories/diet_entry_repository.dart';

/// Provider for diet entry repository
final dietEntryRepositoryProvider = Provider<DietEntryRepository>((ref) {
  return DietEntryRepository();
});

/// Provider for food diary entries by date
final foodDiaryProvider = StateNotifierProvider.family<FoodDiaryNotifier, AsyncValue<List<DietEntryModel>>, DateTime>(
  (ref, date) {
    return FoodDiaryNotifier(ref, date);
  },
);

/// Notifier for food diary
/// OPTIMIZED: Uses optimistic updates to avoid full reloads
class FoodDiaryNotifier extends StateNotifier<AsyncValue<List<DietEntryModel>>> {
  final Ref _ref;
  final DateTime _date;
  late final DietEntryRepository _repository;

  FoodDiaryNotifier(this._ref, this._date) : super(const AsyncValue.loading()) {
    _repository = _ref.read(dietEntryRepositoryProvider);
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    state = const AsyncValue.loading();
    try {
      // Get current user ID (would come from auth provider)
      const userId = 1; // TODO: Get from auth provider
      final entries = await _repository.getEntriesByDate(userId, _date);
      state = AsyncValue.data(entries);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Add diet entry with optimistic update
  Future<void> addEntry(DietEntryModel entry) async {
    final previousState = state;
    
    // Optimistic update: immediately show new entry
    state.whenData((entries) {
      state = AsyncValue.data([...entries, entry]);
    });
    
    try {
      const userId = 1; // TODO: Get from auth provider
      final entryId = await _repository.addEntry(entry: entry, userId: userId);
      
      // Update with real entry ID
      state.whenData((entries) {
        final updated = entries.map((e) {
          if (e == entry) {
            return e.copyWith(entryId: entryId);
          }
          return e;
        }).toList();
        state = AsyncValue.data(updated);
      });
    } catch (error, stackTrace) {
      // Revert on error
      state = previousState;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Delete diet entry with optimistic update
  Future<void> deleteEntry(int entryId) async {
    final previousState = state;
    
    // Optimistic update: immediately remove entry
    state.whenData((entries) {
      state = AsyncValue.data(
        entries.where((e) => e.entryId != entryId).toList(),
      );
    });
    
    try {
      const userId = 1; // TODO: Get from auth provider
      await _repository.deleteEntry(entryId, userId);
      // Success - optimistic update already applied
    } catch (error, stackTrace) {
      // Revert on error
      state = previousState;
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  /// Force refresh entries from database
  Future<void> refresh() async {
    await _loadEntries();
  }
}

