-- Ondeya Waitlist Table
-- Ausführen im Supabase Dashboard → SQL Editor

CREATE TABLE IF NOT EXISTS waitlist (
  id               uuid        DEFAULT gen_random_uuid() PRIMARY KEY,
  email            text        NOT NULL UNIQUE,
  created_at       timestamptz DEFAULT now(),
  is_founding_member boolean   DEFAULT true
);

-- Row Level Security aktivieren
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;

-- Anonyme Nutzer dürfen INSERTen
CREATE POLICY "anon_insert_only" ON waitlist
  FOR INSERT
  TO anon
  WITH CHECK (true);

-- Anonyme Nutzer dürfen COUNT abfragen (nur id wird übertragen, kein email)
CREATE POLICY "anon_count" ON waitlist
  FOR SELECT
  TO anon
  USING (true);

-- Authentifizierte Nutzer (Admin) dürfen alles lesen
CREATE POLICY "auth_read_all" ON waitlist
  FOR SELECT
  TO authenticated
  USING (true);
