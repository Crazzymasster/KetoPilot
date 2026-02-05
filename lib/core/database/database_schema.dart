import 'package:sqflite/sqflite.dart';

/// Database schema definitions for Keto Pilot
/// Implements the complete SQLite schema as per the database blueprint
class DatabaseSchema {
  /// Create all database tables
  static Future<void> createTables(Database db) async {
    await _createUserTable(db);
    await _createFoodTable(db);
    await _createFoodPortionsTable(db);
    await _createDietEntriesTable(db);
    await _createHealthLogTable(db);
    await _createVitalsTable(db);
    await _createSymptomsTable(db);
    await _createDailySummaryTable(db);
    await _createResearchDataTable(db);
    // Supporting tables
    await _createMedicationsTable(db);
    await _createMedicationLogsTable(db);
    await _createUserFoodHistoryTable(db);
    await _createFoodCreationAuditTable(db);
    await _createPhotoUploadsTable(db);
  }

  /// Create indexes for performance
  static Future<void> createIndexes(Database db) async {
    // User table indexes
    await db.execute('CREATE INDEX IF NOT EXISTS idx_user_email ON tb_user(email)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_user_anonymous_id ON tb_user(anonymous_id)');

    // Food table indexes
    await db.execute('CREATE INDEX IF NOT EXISTS idx_food_keylist ON tb_food(keylist)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_food_source ON tb_food(source)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_food_keto_friendly ON tb_food(is_keto_friendly)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_food_barcode ON tb_food(barcode)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_food_net_carbs ON tb_food(net_carbs_g)');

    // Food portions indexes
    await db.execute('CREATE INDEX IF NOT EXISTS idx_food_portions_food_id ON tb_food_portions(food_id)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_food_portions_default ON tb_food_portions(food_id, is_default)');

    // Diet entries indexes
    await db.execute('CREATE INDEX IF NOT EXISTS idx_diet_entries_user_date ON tb_diet_entries(user_id, date)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_diet_entries_user_timestamp ON tb_diet_entries(user_id, recorded_at)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_diet_entries_food_id ON tb_diet_entries(food_id)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_diet_entries_sync ON tb_diet_entries(synced)');

    // Health log indexes
    await db.execute('CREATE INDEX IF NOT EXISTS idx_health_log_user_date ON tb_health_log(user_id, date)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_health_log_user_timestamp ON tb_health_log(user_id, recorded_at)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_health_log_gki ON tb_health_log(user_id, gki_score)');

    // Vitals indexes
    await db.execute('CREATE INDEX IF NOT EXISTS idx_vitals_user_date ON tb_vitals(user_id, date)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_vitals_source ON tb_vitals(source)');

    // Symptoms indexes
    await db.execute('CREATE INDEX IF NOT EXISTS idx_symptoms_user_date ON tb_symptoms(user_id, date)');

    // Daily summary indexes
    await db.execute('CREATE INDEX IF NOT EXISTS idx_daily_summary_user_date ON tb_daily_summary(user_id, date)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_daily_summary_ketosis ON tb_daily_summary(user_id, in_ketosis)');

    // Research data indexes
    await db.execute('CREATE INDEX IF NOT EXISTS idx_research_anonymous_id ON tb_research_data(anonymous_id)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_research_condition ON tb_research_data(primary_condition)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_research_study_day ON tb_research_data(study_day)');

    // Supporting tables indexes
    await db.execute('CREATE INDEX IF NOT EXISTS idx_medications_user ON tb_medications(user_id)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_medication_logs_user_date ON tb_medication_logs(user_id, scheduled_at)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_user_food_history_user ON tb_user_food_history(user_id)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_user_food_history_score ON tb_user_food_history(user_id, preference_score DESC)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_food_audit_user_date ON tb_food_creation_audit(user_id, created_at)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_photo_user ON tb_photo_uploads(user_id)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_photo_entry ON tb_photo_uploads(linked_entry_id)');
  }

  /// Create triggers for automatic calculations
  static Future<void> createTriggers(Database db) async {
    // GKI calculation trigger (with division by zero protection)
    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS calculate_gki AFTER INSERT ON tb_health_log
      WHEN NEW.blood_glucose_mg_dl IS NOT NULL 
        AND NEW.blood_ketones_mmol_l IS NOT NULL
        AND NEW.blood_ketones_mmol_l > 0
      BEGIN
        UPDATE tb_health_log
        SET gki_score = (NEW.blood_glucose_mg_dl / 18.0) / NEW.blood_ketones_mmol_l
        WHERE log_id = NEW.log_id;
      END;
    ''');

    // FTS triggers for food search
    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS tb_food_fts_insert AFTER INSERT ON tb_food BEGIN
        INSERT INTO tb_food_fts(rowid, food_description, keylist)
        VALUES (NEW.food_id, NEW.food_description, NEW.keylist);
      END;
    ''');

    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS tb_food_fts_delete AFTER DELETE ON tb_food BEGIN
        DELETE FROM tb_food_fts WHERE rowid = OLD.food_id;
      END;
    ''');

    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS tb_food_fts_update AFTER UPDATE ON tb_food BEGIN
        UPDATE tb_food_fts SET 
          food_description = NEW.food_description,
          keylist = NEW.keylist
        WHERE rowid = NEW.food_id;
      END;
    ''');

    // Food creation counter increment trigger
    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS increment_food_counter
      AFTER INSERT ON tb_food
      WHEN NEW.created_by_user_id IS NOT NULL
      BEGIN
        UPDATE tb_user
        SET 
          food_creation_count = CASE
            WHEN julianday('now') - julianday(food_creation_window_start) > window_duration_days
            THEN 1
            ELSE food_creation_count + 1
          END,
          food_creation_window_start = CASE
            WHEN julianday('now') - julianday(food_creation_window_start) > window_duration_days
            THEN datetime('now')
            ELSE food_creation_window_start
          END
        WHERE user_id = NEW.created_by_user_id;
        
        -- Audit trail
        INSERT INTO tb_food_creation_audit (user_id, food_id)
        VALUES (NEW.created_by_user_id, NEW.food_id);
      END;
    ''');

    // Research data anonymization trigger
    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS populate_research_data
      AFTER INSERT ON tb_daily_summary
      WHEN (SELECT research_consent FROM tb_user WHERE user_id = NEW.user_id) = 1
      BEGIN
        INSERT INTO tb_research_data (
          anonymous_id,
          study_day,
          date,
          age_group,
          gender_category,
          bmi_category,
          primary_condition,
          daily_net_carbs_g,
          daily_protein_g,
          daily_fat_g,
          daily_calories_kcal,
          carb_adherence_rate,
          avg_glucose_mg_dl,
          avg_ketones_mmol_l,
          avg_gki_score,
          ketosis_percentage,
          weight_change_kg,
          avg_energy_level,
          avg_mental_clarity,
          avg_mood_rating
        )
        SELECT 
          u.anonymous_id,
          CAST(julianday(NEW.date) - julianday(u.keto_start_date) AS INTEGER) as study_day,
          NEW.date,
          CASE 
            WHEN (julianday('now') - julianday(u.date_of_birth))/365.25 < 25 THEN '18-25'
            WHEN (julianday('now') - julianday(u.date_of_birth))/365.25 < 35 THEN '26-35'
            WHEN (julianday('now') - julianday(u.date_of_birth))/365.25 < 45 THEN '36-45'
            WHEN (julianday('now') - julianday(u.date_of_birth))/365.25 < 55 THEN '46-55'
            ELSE '55+'
          END,
          u.gender,
          CASE 
            WHEN (u.initial_weight_kg / ((u.height_cm/100.0) * (u.height_cm/100.0))) < 18.5 THEN 'underweight'
            WHEN (u.initial_weight_kg / ((u.height_cm/100.0) * (u.height_cm/100.0))) < 25 THEN 'normal'
            WHEN (u.initial_weight_kg / ((u.height_cm/100.0) * (u.height_cm/100.0))) < 30 THEN 'overweight'
            ELSE 'obese'
          END,
          u.medical_conditions,
          NEW.total_net_carbs_g,
          NEW.total_protein_g,
          NEW.total_fat_g,
          NEW.total_energy_kcal,
          CASE WHEN NEW.carb_goal_met = 1 THEN 1.0 ELSE 0.0 END,
          NEW.avg_glucose_mg_dl,
          NEW.avg_ketones_mmol_l,
          NEW.avg_gki_score,
          CASE WHEN NEW.in_ketosis = 1 THEN 1.0 ELSE 0.0 END,
          NEW.weight_kg - u.initial_weight_kg,
          NEW.avg_energy_level,
          NEW.avg_mental_clarity,
          NEW.avg_mood_rating
        FROM tb_user u
        WHERE u.user_id = NEW.user_id;
      END;
    ''');
  }

  /// Create Full-Text Search tables
  static Future<void> createFtsTables(Database db) async {
    // Note: FTS5 is not directly supported in sqflite, but we can create a regular table
    // and implement search using LIKE queries or use a separate search index
    // For now, we'll create a simple table that mimics FTS structure for triggers to work
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_food_fts (
        rowid INTEGER PRIMARY KEY,
        food_description TEXT,
        keylist TEXT
      )
    ''');
  }

  /// Create tb_user table
  static Future<void> _createUserTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_user (
        user_id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL UNIQUE,
        password_hash TEXT NOT NULL,
        email_verified INTEGER DEFAULT 0,
        
        full_name TEXT,
        date_of_birth TEXT,
        gender TEXT CHECK(gender IN ('male', 'female', 'other', 'prefer_not_to_say')),
        
        height_cm REAL,
        initial_weight_kg REAL,
        
        target_net_carbs REAL DEFAULT 20.0,
        target_protein REAL,
        target_fat REAL,
        target_calories REAL,
        keto_start_date TEXT,
        
        medical_conditions TEXT,
        goals TEXT,
        iot_devices TEXT,
        
        food_creation_count INTEGER DEFAULT 0,
        food_creation_window_start TEXT,
        max_foods_per_window INTEGER DEFAULT 50,
        window_duration_days INTEGER DEFAULT 21,
        
        research_consent INTEGER DEFAULT 0,
        data_sharing_consent INTEGER DEFAULT 0,
        anonymous_id TEXT UNIQUE,
        
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
        last_login TEXT,
        
        CONSTRAINT valid_email CHECK (email LIKE '%@%')
      )
    ''');
  }

  /// Create tb_food table
  static Future<void> _createFoodTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_food (
        food_id INTEGER PRIMARY KEY AUTOINCREMENT,
        keylist TEXT UNIQUE,
        food_description TEXT NOT NULL,
        
        source TEXT DEFAULT 'ncc',
        created_by_user_id INTEGER,
        is_verified INTEGER DEFAULT 0,
        is_keto_friendly INTEGER,
        
        energy_kcal REAL NOT NULL,
        total_protein_g REAL NOT NULL,
        total_fat_g REAL NOT NULL,
        total_carbohydrate_g REAL NOT NULL,
        
        dietary_fiber_g REAL DEFAULT 0,
        sugar_g REAL DEFAULT 0,
        added_sugar_g REAL DEFAULT 0,
        net_carbs_g REAL,
        
        saturated_fat_g REAL,
        monounsaturated_fat_g REAL,
        polyunsaturated_fat_g REAL,
        trans_fat_g REAL,
        cholesterol_mg REAL,
        
        sodium_mg REAL,
        potassium_mg REAL,
        magnesium_mg REAL,
        calcium_mg REAL,
        
        glycemic_index INTEGER,
        glycemic_load REAL,
        
        vitamins TEXT,
        minerals TEXT,
        
        food_photo_url TEXT,
        barcode TEXT,
        
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
        
        FOREIGN KEY (created_by_user_id) REFERENCES tb_user(user_id) ON DELETE SET NULL
      )
    ''');
  }

  /// Create tb_food_portions table
  static Future<void> _createFoodPortionsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_food_portions (
        portion_id INTEGER PRIMARY KEY AUTOINCREMENT,
        food_id INTEGER NOT NULL,
        
        portion_amount REAL NOT NULL,
        portion_unit TEXT NOT NULL,
        portion_description TEXT,
        portion_gram_weight REAL NOT NULL,
        
        energy_kcal REAL,
        protein_g REAL,
        fat_g REAL,
        carbohydrate_g REAL,
        net_carbs_g REAL,
        
        is_default INTEGER DEFAULT 0,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        
        FOREIGN KEY (food_id) REFERENCES tb_food(food_id) ON DELETE CASCADE
      )
    ''');
  }

  /// Create tb_diet_entries table
  static Future<void> _createDietEntriesTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_diet_entries (
        entry_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        food_id INTEGER NOT NULL,
        
        recorded_at TEXT NOT NULL,
        date TEXT NOT NULL,
        
        portion_id INTEGER,
        custom_portion_grams REAL,
        serving_size_multiplier REAL DEFAULT 1.0,
        
        total_energy_kcal REAL NOT NULL,
        total_protein_g REAL NOT NULL,
        total_fat_g REAL NOT NULL,
        total_carbohydrate_g REAL NOT NULL,
        total_net_carbs_g REAL NOT NULL,
        total_fiber_g REAL,
        total_sodium_mg REAL,
        
        meal_context TEXT,
        location TEXT,
        notes TEXT,
        food_photo_url TEXT,
        
        synced INTEGER DEFAULT 0,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
        
        FOREIGN KEY (user_id) REFERENCES tb_user(user_id) ON DELETE CASCADE,
        FOREIGN KEY (food_id) REFERENCES tb_food(food_id),
        FOREIGN KEY (portion_id) REFERENCES tb_food_portions(portion_id)
      )
    ''');
  }

  /// Create tb_health_log table
  static Future<void> _createHealthLogTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_health_log (
        log_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        
        recorded_at TEXT NOT NULL,
        date TEXT NOT NULL,
        
        blood_glucose_mg_dl REAL,
        blood_ketones_mmol_l REAL,
        gki_score REAL,
        
        lactate_mmol_l REAL,
        sodium_mmol_l REAL,
        
        blood_pressure_systolic INTEGER,
        blood_pressure_diastolic INTEGER,
        
        weight_kg REAL,
        body_fat_percentage REAL,
        muscle_mass_kg REAL,
        
        source TEXT DEFAULT 'manual',
        device_id TEXT,
        
        notes TEXT,
        synced INTEGER DEFAULT 0,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        
        FOREIGN KEY (user_id) REFERENCES tb_user(user_id) ON DELETE CASCADE
      )
    ''');
  }

  /// Create tb_vitals table
  static Future<void> _createVitalsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_vitals (
        vital_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        
        recorded_at TEXT NOT NULL,
        date TEXT NOT NULL,
        
        heart_rate_bpm INTEGER,
        hrv_ms REAL,
        resting_heart_rate_bpm INTEGER,
        
        body_temperature_celsius REAL,
        skin_temperature_celsius REAL,
        
        sleep_duration_hours REAL,
        deep_sleep_hours REAL,
        rem_sleep_hours REAL,
        light_sleep_hours REAL,
        sleep_score INTEGER,
        
        steps_count INTEGER,
        active_calories_kcal REAL,
        total_calories_kcal REAL,
        distance_km REAL,
        
        respiratory_rate_bpm INTEGER,
        spo2_percentage REAL,
        
        source TEXT DEFAULT 'manual',
        device_id TEXT,
        
        synced INTEGER DEFAULT 0,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        
        FOREIGN KEY (user_id) REFERENCES tb_user(user_id) ON DELETE CASCADE
      )
    ''');
  }

  /// Create tb_symptoms table
  static Future<void> _createSymptomsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_symptoms (
        symptom_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        
        recorded_at TEXT NOT NULL,
        date TEXT NOT NULL,
        
        headache_severity INTEGER CHECK(headache_severity BETWEEN 0 AND 10),
        fatigue_severity INTEGER CHECK(fatigue_severity BETWEEN 0 AND 10),
        nausea_severity INTEGER CHECK(nausea_severity BETWEEN 0 AND 10),
        dizziness_severity INTEGER CHECK(dizziness_severity BETWEEN 0 AND 10),
        brain_fog_severity INTEGER CHECK(brain_fog_severity BETWEEN 0 AND 10),
        irritability_severity INTEGER CHECK(irritability_severity BETWEEN 0 AND 10),
        muscle_cramps_severity INTEGER CHECK(muscle_cramps_severity BETWEEN 0 AND 10),
        
        energy_level INTEGER CHECK(energy_level BETWEEN 0 AND 10),
        mental_clarity INTEGER CHECK(mental_clarity BETWEEN 0 AND 10),
        mood_rating INTEGER CHECK(mood_rating BETWEEN 0 AND 10),
        hunger_level INTEGER CHECK(hunger_level BETWEEN 0 AND 10),
        satiety_level INTEGER CHECK(satiety_level BETWEEN 0 AND 10),
        
        bloating_severity INTEGER CHECK(bloating_severity BETWEEN 0 AND 10),
        digestion_quality INTEGER CHECK(digestion_quality BETWEEN 0 AND 10),
        
        custom_symptoms TEXT,
        additional_notes TEXT,
        
        synced INTEGER DEFAULT 0,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        
        FOREIGN KEY (user_id) REFERENCES tb_user(user_id) ON DELETE CASCADE
      )
    ''');
  }

  /// Create tb_daily_summary table
  static Future<void> _createDailySummaryTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_daily_summary (
        summary_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        
        total_energy_kcal REAL DEFAULT 0,
        total_protein_g REAL DEFAULT 0,
        total_fat_g REAL DEFAULT 0,
        total_carbohydrate_g REAL DEFAULT 0,
        total_net_carbs_g REAL DEFAULT 0,
        total_fiber_g REAL DEFAULT 0,
        
        total_sodium_mg REAL DEFAULT 0,
        total_potassium_mg REAL DEFAULT 0,
        total_magnesium_mg REAL DEFAULT 0,
        
        carb_goal_met INTEGER DEFAULT 0,
        protein_goal_met INTEGER DEFAULT 0,
        fat_goal_met INTEGER DEFAULT 0,
        
        avg_glucose_mg_dl REAL,
        avg_ketones_mmol_l REAL,
        avg_gki_score REAL,
        min_gki_score REAL,
        max_gki_score REAL,
        
        in_ketosis INTEGER DEFAULT 0,
        in_therapeutic_ketosis INTEGER DEFAULT 0,
        
        avg_heart_rate_bpm INTEGER,
        avg_hrv_ms REAL,
        total_steps INTEGER,
        
        weight_kg REAL,
        weight_change_from_start_kg REAL,
        
        avg_energy_level REAL,
        avg_mental_clarity REAL,
        avg_mood_rating REAL,
        
        diet_entries_count INTEGER DEFAULT 0,
        health_logs_count INTEGER DEFAULT 0,
        
        last_calculated_at TEXT DEFAULT CURRENT_TIMESTAMP,
        synced INTEGER DEFAULT 0,
        
        FOREIGN KEY (user_id) REFERENCES tb_user(user_id) ON DELETE CASCADE,
        UNIQUE(user_id, date)
      )
    ''');
  }

  /// Create tb_research_data table
  static Future<void> _createResearchDataTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_research_data (
        research_id INTEGER PRIMARY KEY AUTOINCREMENT,
        anonymous_id TEXT NOT NULL,
        
        study_day INTEGER NOT NULL,
        date TEXT NOT NULL,
        
        age_group TEXT,
        gender_category TEXT,
        bmi_category TEXT,
        
        primary_condition TEXT,
        
        daily_net_carbs_g REAL,
        daily_protein_g REAL,
        daily_fat_g REAL,
        daily_calories_kcal REAL,
        carb_adherence_rate REAL,
        
        avg_glucose_mg_dl REAL,
        avg_ketones_mmol_l REAL,
        avg_gki_score REAL,
        ketosis_percentage REAL,
        
        weight_change_kg REAL,
        body_fat_change_percentage REAL,
        
        avg_energy_level REAL,
        avg_mental_clarity REAL,
        avg_mood_rating REAL,
        keto_flu_severity_score REAL,
        
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        
        FOREIGN KEY (anonymous_id) REFERENCES tb_user(anonymous_id)
      )
    ''');
  }

  /// Create tb_medications table
  static Future<void> _createMedicationsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_medications (
        medication_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        
        medication_name TEXT NOT NULL,
        dosage TEXT,
        frequency TEXT,
        
        start_date TEXT NOT NULL,
        end_date TEXT,
        
        purpose TEXT,
        side_effects TEXT,
        
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
        
        FOREIGN KEY (user_id) REFERENCES tb_user(user_id) ON DELETE CASCADE
      )
    ''');
  }

  /// Create tb_medication_logs table
  static Future<void> _createMedicationLogsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_medication_logs (
        log_id INTEGER PRIMARY KEY AUTOINCREMENT,
        medication_id INTEGER NOT NULL,
        user_id INTEGER NOT NULL,
        
        scheduled_at TEXT NOT NULL,
        taken_at TEXT,
        
        taken INTEGER DEFAULT 0,
        skipped_reason TEXT,
        
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        
        FOREIGN KEY (medication_id) REFERENCES tb_medications(medication_id) ON DELETE CASCADE,
        FOREIGN KEY (user_id) REFERENCES tb_user(user_id) ON DELETE CASCADE
      )
    ''');
  }

  /// Create tb_user_food_history table
  static Future<void> _createUserFoodHistoryTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_user_food_history (
        history_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        food_id INTEGER NOT NULL,
        
        total_consumption_count INTEGER DEFAULT 1,
        last_consumed_at TEXT NOT NULL,
        
        morning_count INTEGER DEFAULT 0,
        afternoon_count INTEGER DEFAULT 0,
        evening_count INTEGER DEFAULT 0,
        night_count INTEGER DEFAULT 0,
        
        preference_score REAL DEFAULT 1.0,
        
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
        
        FOREIGN KEY (user_id) REFERENCES tb_user(user_id) ON DELETE CASCADE,
        FOREIGN KEY (food_id) REFERENCES tb_food(food_id) ON DELETE CASCADE,
        UNIQUE(user_id, food_id)
      )
    ''');
  }

  /// Create tb_food_creation_audit table
  static Future<void> _createFoodCreationAuditTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_food_creation_audit (
        audit_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        food_id INTEGER NOT NULL,
        
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        is_flagged INTEGER DEFAULT 0,
        flag_reason TEXT,
        
        FOREIGN KEY (user_id) REFERENCES tb_user(user_id) ON DELETE CASCADE,
        FOREIGN KEY (food_id) REFERENCES tb_food(food_id) ON DELETE CASCADE
      )
    ''');
  }

  /// Create tb_photo_uploads table
  static Future<void> _createPhotoUploadsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tb_photo_uploads (
        photo_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        
        file_path TEXT NOT NULL,
        file_size_bytes INTEGER,
        mime_type TEXT,
        
        detected_food_ids TEXT,
        recognition_confidence REAL,
        
        linked_entry_id INTEGER,
        
        uploaded_at TEXT DEFAULT CURRENT_TIMESTAMP,
        synced INTEGER DEFAULT 0,
        
        FOREIGN KEY (user_id) REFERENCES tb_user(user_id) ON DELETE CASCADE,
        FOREIGN KEY (linked_entry_id) REFERENCES tb_diet_entries(entry_id) ON DELETE SET NULL
      )
    ''');
  }
}

