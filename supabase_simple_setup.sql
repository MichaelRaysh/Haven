-- Haven App - Simple Supabase Setup (No Auth Required)
-- Copy and paste this entire script into your Supabase SQL Editor

-- 1. PATIENTS TABLE
CREATE TABLE IF NOT EXISTS patients (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id TEXT NOT NULL,
  name TEXT NOT NULL,
  age INT,
  allergies TEXT,
  conditions TEXT,
  last_visit DATE,
  created_at TIMESTAMP DEFAULT NOW()
);

-- 2. MEDICATIONS TABLE
CREATE TABLE IF NOT EXISTS medications (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id TEXT NOT NULL,
  patient TEXT NOT NULL,
  drug TEXT NOT NULL,
  dosage TEXT,
  frequency TEXT,
  status TEXT DEFAULT 'on-time',
  created_at TIMESTAMP DEFAULT NOW()
);

-- 3. NOTES TABLE
CREATE TABLE IF NOT EXISTS notes (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id TEXT NOT NULL,
  patient TEXT NOT NULL,
  title TEXT NOT NULL,
  content TEXT,
  category TEXT DEFAULT 'general',
  timestamp TIMESTAMP DEFAULT NOW()
);

-- 4. APPOINTMENTS TABLE
CREATE TABLE IF NOT EXISTS appointments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id TEXT NOT NULL,
  patient TEXT NOT NULL,
  date DATE,
  time TEXT,
  type TEXT,
  address TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- 5. MESSAGES TABLE
CREATE TABLE IF NOT EXISTS messages (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id TEXT NOT NULL,
  sender TEXT,
  recipient TEXT NOT NULL,
  subject TEXT,
  body TEXT,
  read BOOLEAN DEFAULT FALSE,
  timestamp TIMESTAMP DEFAULT NOW()
);

-- 6. MILEAGE_TRIPS TABLE
CREATE TABLE IF NOT EXISTS mileage_trips (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id TEXT NOT NULL,
  date DATE,
  miles DECIMAL(10, 2),
  destination TEXT,
  purpose TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Enable public access (for demo purposes - adjust for production)
ALTER TABLE patients ENABLE ROW LEVEL SECURITY;
ALTER TABLE medications ENABLE ROW LEVEL SECURITY;
ALTER TABLE notes ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE mileage_trips ENABLE ROW LEVEL SECURITY;

-- Allow all operations for now (adjust policies for production)
CREATE POLICY "Enable all for patients" ON patients FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Enable all for medications" ON medications FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Enable all for notes" ON notes FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Enable all for appointments" ON appointments FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Enable all for messages" ON messages FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Enable all for mileage_trips" ON mileage_trips FOR ALL USING (true) WITH CHECK (true);
