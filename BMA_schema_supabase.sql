-- ================================================================
-- BMA Production — La Rose de Tunis
-- Script SQL Supabase — à exécuter UNE SEULE FOIS
-- Supabase > SQL Editor > New query > coller > Run
-- ================================================================

-- 1. Table principale de stockage des données
CREATE TABLE IF NOT EXISTS bma_data (
  id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id     TEXT NOT NULL,
  key         TEXT NOT NULL,
  value       JSONB NOT NULL DEFAULT '{}',
  updated_at  TIMESTAMPTZ DEFAULT now(),
  UNIQUE (user_id, key)
);

-- 2. Index performance
CREATE INDEX IF NOT EXISTS idx_bma_data_user_id ON bma_data(user_id);
CREATE INDEX IF NOT EXISTS idx_bma_data_key ON bma_data(key);

-- 3. Row Level Security — chaque utilisateur accède uniquement à ses données
ALTER TABLE bma_data ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "select_own" ON bma_data;
DROP POLICY IF EXISTS "insert_own" ON bma_data;
DROP POLICY IF EXISTS "update_own" ON bma_data;
DROP POLICY IF EXISTS "delete_own" ON bma_data;

CREATE POLICY "select_own" ON bma_data
  FOR SELECT USING (user_id = auth.uid()::text);

CREATE POLICY "insert_own" ON bma_data
  FOR INSERT WITH CHECK (user_id = auth.uid()::text);

CREATE POLICY "update_own" ON bma_data
  FOR UPDATE USING (user_id = auth.uid()::text);

CREATE POLICY "delete_own" ON bma_data
  FOR DELETE USING (user_id = auth.uid()::text);

-- 4. Trigger mise à jour automatique du timestamp
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = now(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS bma_data_updated_at ON bma_data;
CREATE TRIGGER bma_data_updated_at
  BEFORE UPDATE ON bma_data
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ================================================================
-- Vérification : doit retourner la table créée
SELECT table_name, row_security
FROM information_schema.tables
WHERE table_name = 'bma_data';
-- ================================================================
