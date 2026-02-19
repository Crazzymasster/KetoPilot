-- Diet entries table for cross-device sync
-- Run this in your Supabase SQL Editor

CREATE TABLE IF NOT EXISTS diet_entries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  
  -- Local reference for sync tracking
  local_entry_id INT,
  
  -- Food reference (stored as food description since foods are local)
  food_id INT NOT NULL,
  food_description TEXT,
  
  -- Timing
  recorded_at TIMESTAMPTZ NOT NULL,
  date TEXT NOT NULL,
  
  -- Portion info
  portion_id INT,
  custom_portion_grams REAL,
  serving_size_multiplier REAL DEFAULT 1.0,
  
  -- Calculated nutrition values
  total_energy_kcal REAL NOT NULL,
  total_protein_g REAL NOT NULL,
  total_fat_g REAL NOT NULL,
  total_carbohydrate_g REAL NOT NULL,
  total_net_carbs_g REAL NOT NULL,
  total_fiber_g REAL,
  total_sodium_mg REAL,
  
  -- Context
  meal_context TEXT,
  location TEXT,
  notes TEXT,
  food_photo_url TEXT,
  
  -- Sync metadata
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  deleted_at TIMESTAMPTZ,  -- Soft delete for sync
  
  -- Prevent duplicate syncs from same device
  UNIQUE(user_id, local_entry_id)
);

-- Index for efficient queries
CREATE INDEX IF NOT EXISTS idx_diet_entries_user_date ON diet_entries(user_id, date);
CREATE INDEX IF NOT EXISTS idx_diet_entries_user_updated ON diet_entries(user_id, updated_at);

-- Row Level Security
ALTER TABLE diet_entries ENABLE ROW LEVEL SECURITY;

-- Users can only access their own entries
CREATE POLICY "Users can view own diet entries"
  ON diet_entries FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own diet entries"
  ON diet_entries FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own diet entries"
  ON diet_entries FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own diet entries"
  ON diet_entries FOR DELETE
  USING (auth.uid() = user_id);

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_diet_entries_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for auto-updating updated_at
DROP TRIGGER IF EXISTS diet_entries_updated_at ON diet_entries;
CREATE TRIGGER diet_entries_updated_at
  BEFORE UPDATE ON diet_entries
  FOR EACH ROW
  EXECUTE FUNCTION update_diet_entries_updated_at();
