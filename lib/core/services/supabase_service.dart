import 'package:flutter/foundation.dart' show debugPrint;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  SupabaseClient? _client;

  Future<void> initialize() async {
    await Supabase.initialize(
      url: SupabaseConfig.supabaseUrl,
      anonKey: SupabaseConfig.supabaseAnonKey,
      authOptions: const FlutterAuthClientOptions(
        //use implicit flow so password reset works across platforms
        authFlowType: AuthFlowType.implicit,
        //ensure auth state persists between sessions (default is localStorage on web)
        autoRefreshToken: true,
      ),
    );
    _client = Supabase.instance.client;
    
    //log current auth state for debugging persistence
    final currentUser = _client?.auth.currentUser;
    if (currentUser != null) {
      debugPrint('[SUPABASE] ✅ Restored session for: ${currentUser.email}');
    } else {
      debugPrint('[SUPABASE] ℹ️ No existing session found');
    }
  }

  SupabaseClient get client {
    if (_client == null) {
      throw Exception('Supabase not initialized. Call initialize() first.');
    }
    return _client!;
  }

  bool get isAuthenticated => client.auth.currentUser != null;
}
