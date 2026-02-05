import 'package:sqflite/sqflite.dart';

/// Future enhancement tables for ML predictions and social features
/// These can be added in future versions
class FutureEnhancementsSchema {
  /// Create ML prediction tables
  static Future<void> createMLTables(Database db) async {
    await _createMLPredictionsTable(db);
    await _createMLFeaturesTable(db);
  }

  /// Create social feature tables
  static Future<void> createSocialTables(Database db) async {
    await _createUserAchievementsTable(db);
    await _createCommunityRecipesTable(db);
    await _createRecipeIngredientsTable(db);
  }

  /// Create indexes for future enhancement tables
  static Future<void> createFutureIndexes(Database db) async {
    await db.execute('CREATE INDEX IF NOT EXISTS idx_ml_predictions_user_date ON tb_ml_predictions(user_id, date)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_ml_predictions_type ON tb_ml_predictions(prediction_type)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_ml_features_user_date ON tb_ml_features(user_id, date)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_achievements_user ON tb_user_achievements(user_id)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_recipes_user ON tb_community_recipes(created_by_user_id)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_recipe_ingredients_recipe ON tb_recipe_ingredients(recipe_id)');
  }

  /// Create tb_ml_predictions table
  static Future<void> _createMLPredictionsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_ml_predictions (
        prediction_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        
        prediction_type TEXT NOT NULL,
        
        predicted_gki REAL,
        predicted_weight_kg REAL,
        optimal_net_carbs_g REAL,
        optimal_protein_g REAL,
        optimal_fat_g REAL,
        
        model_version TEXT,
        confidence_score REAL,
        
        actual_value REAL,
        prediction_error REAL,
        
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        
        FOREIGN KEY (user_id) REFERENCES tb_user(user_id) ON DELETE CASCADE
      )
    ''');
  }

  /// Create tb_ml_features table
  static Future<void> _createMLFeaturesTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_ml_features (
        feature_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        
        rolling_7day_avg_carbs REAL,
        rolling_7day_avg_gki REAL,
        carb_variability REAL,
        days_in_ketosis_last_week INTEGER,
        weight_change_rate_kg_per_week REAL,
        
        carb_protein_ratio REAL,
        fat_protein_ratio REAL,
        
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        
        FOREIGN KEY (user_id) REFERENCES tb_user(user_id) ON DELETE CASCADE
      )
    ''');
  }

  /// Create tb_user_achievements table
  static Future<void> _createUserAchievementsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_user_achievements (
        achievement_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        
        achievement_type TEXT NOT NULL,
        earned_at TEXT DEFAULT CURRENT_TIMESTAMP,
        is_public INTEGER DEFAULT 0,
        
        FOREIGN KEY (user_id) REFERENCES tb_user(user_id) ON DELETE CASCADE
      )
    ''');
  }

  /// Create tb_community_recipes table
  static Future<void> _createCommunityRecipesTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_community_recipes (
        recipe_id INTEGER PRIMARY KEY AUTOINCREMENT,
        created_by_user_id INTEGER NOT NULL,
        
        recipe_name TEXT NOT NULL,
        description TEXT,
        instructions TEXT,
        prep_time_minutes INTEGER,
        servings INTEGER,
        
        total_net_carbs_g REAL,
        total_protein_g REAL,
        total_fat_g REAL,
        
        likes_count INTEGER DEFAULT 0,
        saves_count INTEGER DEFAULT 0,
        
        is_public INTEGER DEFAULT 1,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        
        FOREIGN KEY (created_by_user_id) REFERENCES tb_user(user_id) ON DELETE CASCADE
      )
    ''');
  }

  /// Create tb_recipe_ingredients table
  static Future<void> _createRecipeIngredientsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_recipe_ingredients (
        ingredient_id INTEGER PRIMARY KEY AUTOINCREMENT,
        recipe_id INTEGER NOT NULL,
        food_id INTEGER NOT NULL,
        
        quantity_grams REAL NOT NULL,
        
        FOREIGN KEY (recipe_id) REFERENCES tb_community_recipes(recipe_id) ON DELETE CASCADE,
        FOREIGN KEY (food_id) REFERENCES tb_food(food_id)
      )
    ''');
  }
}

