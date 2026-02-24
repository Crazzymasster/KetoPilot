/// Lightweight in-memory cache with TTL (Time To Live)
/// Use for frequently accessed data that doesn't change often
class MemoryCache<T> {
  final Map<String, _CacheEntry<T>> _cache = {};
  final Duration defaultTtl;

  MemoryCache({this.defaultTtl = const Duration(minutes: 5)});

  /// Get cached value or null if expired/missing
  T? get(String key) {
    final entry = _cache[key];
    if (entry == null) return null;
    
    if (entry.isExpired) {
      _cache.remove(key);
      return null;
    }
    
    return entry.value;
  }

  /// Set value with optional custom TTL
  void set(String key, T value, {Duration? ttl}) {
    _cache[key] = _CacheEntry(
      value: value,
      expiresAt: DateTime.now().add(ttl ?? defaultTtl),
    );
  }

  /// Get or compute value if not cached
  Future<T> getOrCompute(
    String key,
    Future<T> Function() compute, {
    Duration? ttl,
  }) async {
    final cached = get(key);
    if (cached != null) return cached;
    
    final value = await compute();
    set(key, value, ttl: ttl);
    return value;
  }

  /// Invalidate specific key
  void invalidate(String key) {
    _cache.remove(key);
  }

  /// Invalidate all keys matching prefix
  void invalidatePrefix(String prefix) {
    _cache.removeWhere((key, _) => key.startsWith(prefix));
  }

  /// Clear all cached data
  void clear() {
    _cache.clear();
  }

  /// Remove expired entries (call periodically for cleanup)
  void cleanup() {
    _cache.removeWhere((_, entry) => entry.isExpired);
  }
  
  /// Get cache stats for debugging
  Map<String, dynamic> get stats => {
    'entries': _cache.length,
    'keys': _cache.keys.toList(),
  };
}

class _CacheEntry<T> {
  final T value;
  final DateTime expiresAt;

  _CacheEntry({required this.value, required this.expiresAt});

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

/// Global caches for common data
/// Usage: DailySummaryCache.instance.get('user_1_2026-02-23')
class AppCaches {
  static final dailyTotals = MemoryCache<Map<String, double>>(
    defaultTtl: const Duration(minutes: 10),
  );
  
  static final foodSearch = MemoryCache<List<dynamic>>(
    defaultTtl: const Duration(minutes: 30),
  );
  
  static final userProfile = MemoryCache<dynamic>(
    defaultTtl: const Duration(hours: 1),
  );
  
  /// Clear all caches (call on logout or data reset)
  static void clearAll() {
    dailyTotals.clear();
    foodSearch.clear();
    userProfile.clear();
  }
  
  /// Invalidate user-specific data
  static void invalidateUser(int userId) {
    dailyTotals.invalidatePrefix('user_$userId');
    userProfile.invalidate('user_$userId');
  }
}
