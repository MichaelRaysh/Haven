-- Haven App - Complete Supabase Schema Setup
-- Copy and paste this entire script into your Supabase SQL Editor

-- 1. PROFILES TABLE (for user info)
CREATE TABLE profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  email TEXT UNIQUE,
  username TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- 2. PATIENTS TABLE
CREATE TABLE patients (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  name TEXT NOT NULL,
  age INT,
  allergies TEXT,
  conditions TEXT,
  last_visit DATE,
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE
);

-- 3. MEDICATIONS TABLE
CREATE TABLE medications (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  patient TEXT NOT NULL,
  drug TEXT NOT NULL,
  dosage TEXT,
  frequency TEXT,
  status TEXT DEFAULT 'on-time',
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE
);

-- 4. NOTES TABLE
CREATE TABLE notes (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  patient TEXT NOT NULL,
  title TEXT NOT NULL,
  content TEXT,
  category TEXT DEFAULT 'general',
  timestamp TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE
);

-- 5. APPOINTMENTS TABLE
CREATE TABLE appointments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  patient TEXT NOT NULL,
  date DATE,
  time TEXT,
  type TEXT,
  address TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE
);

-- 6. MESSAGES TABLE
CREATE TABLE messages (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  sender TEXT,
  recipient TEXT NOT NULL,
  subject TEXT,
  body TEXT,
  read BOOLEAN DEFAULT FALSE,
  timestamp TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE
);

-- 7. MILEAGE_TRIPS TABLE
CREATE TABLE mileage_trips (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  date DATE,
  miles DECIMAL(10, 2),
  destination TEXT,
  purpose TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE
);

-- 8. VOICE_NOTES TABLE
CREATE TABLE voice_notes (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  title TEXT,
  audio_url TEXT,
  duration INT,
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE
);

-- 9. ALERTS TABLE
CREATE TABLE alerts (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  priority TEXT DEFAULT 'normal',
  message TEXT NOT NULL,
  acknowledged BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE
);

-- ============================================
-- ENABLE ROW LEVEL SECURITY (RLS)
-- ============================================

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE patients ENABLE ROW LEVEL SECURITY;
ALTER TABLE medications ENABLE ROW LEVEL SECURITY;
ALTER TABLE notes ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE mileage_trips ENABLE ROW LEVEL SECURITY;
ALTER TABLE voice_notes ENABLE ROW LEVEL SECURITY;
ALTER TABLE alerts ENABLE ROW LEVEL SECURITY;

-- ============================================
-- RLS POLICIES FOR PROFILES
-- ============================================
CREATE POLICY "Users can view own profile"
  ON profiles FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE
  USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile"
  ON profiles FOR INSERT
  WITH CHECK (auth.uid() = id);

-- ============================================
-- RLS POLICIES FOR PATIENTS
-- ============================================
CREATE POLICY "Users can view own patients"
  ON patients FOR SELECT
  USING (user_id = auth.uid());

CREATE POLICY "Users can insert own patients"
  ON patients FOR INSERT
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update own patients"
  ON patients FOR UPDATE
  USING (user_id = auth.uid());

CREATE POLICY "Users can delete own patients"
  ON patients FOR DELETE
  USING (user_id = auth.uid());

-- ============================================
-- RLS POLICIES FOR MEDICATIONS
-- ============================================
CREATE POLICY "Users can view own medications"
  ON medications FOR SELECT
  USING (user_id = auth.uid());

CREATE POLICY "Users can insert own medications"
  ON medications FOR INSERT
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update own medications"
  ON medications FOR UPDATE
  USING (user_id = auth.uid());

CREATE POLICY "Users can delete own medications"
  ON medications FOR DELETE
  USING (user_id = auth.uid());

-- ============================================
-- RLS POLICIES FOR NOTES
-- ============================================
CREATE POLICY "Users can view own notes"
  ON notes FOR SELECT
  USING (user_id = auth.uid());

CREATE POLICY "Users can insert own notes"
  ON notes FOR INSERT
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update own notes"
  ON notes FOR UPDATE
  USING (user_id = auth.uid());

CREATE POLICY "Users can delete own notes"
  ON notes FOR DELETE
  USING (user_id = auth.uid());

-- ============================================
-- RLS POLICIES FOR APPOINTMENTS
-- ============================================
CREATE POLICY "Users can view own appointments"
  ON appointments FOR SELECT
  USING (user_id = auth.uid());

CREATE POLICY "Users can insert own appointments"
  ON appointments FOR INSERT
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update own appointments"
  ON appointments FOR UPDATE
  USING (user_id = auth.uid());

CREATE POLICY "Users can delete own appointments"
  ON appointments FOR DELETE
  USING (user_id = auth.uid());

-- ============================================
-- RLS POLICIES FOR MESSAGES
-- ============================================
CREATE POLICY "Users can view own messages"
  ON messages FOR SELECT
  USING (user_id = auth.uid());

CREATE POLICY "Users can insert own messages"
  ON messages FOR INSERT
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update own messages"
  ON messages FOR UPDATE
  USING (user_id = auth.uid());

CREATE POLICY "Users can delete own messages"
  ON messages FOR DELETE
  USING (user_id = auth.uid());

-- ============================================
-- RLS POLICIES FOR MILEAGE_TRIPS
-- ============================================
CREATE POLICY "Users can view own mileage trips"
  ON mileage_trips FOR SELECT
  USING (user_id = auth.uid());

CREATE POLICY "Users can insert own mileage trips"
  ON mileage_trips FOR INSERT
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update own mileage trips"
  ON mileage_trips FOR UPDATE
  USING (user_id = auth.uid());

CREATE POLICY "Users can delete own mileage trips"
  ON mileage_trips FOR DELETE
  USING (user_id = auth.uid());

-- ============================================
-- RLS POLICIES FOR VOICE_NOTES
-- ============================================
CREATE POLICY "Users can view own voice notes"
  ON voice_notes FOR SELECT
  USING (user_id = auth.uid());

CREATE POLICY "Users can insert own voice notes"
  ON voice_notes FOR INSERT
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update own voice notes"
  ON voice_notes FOR UPDATE
  USING (user_id = auth.uid());

CREATE POLICY "Users can delete own voice notes"
  ON voice_notes FOR DELETE
  USING (user_id = auth.uid());

-- ============================================
-- RLS POLICIES FOR ALERTS
-- ============================================
CREATE POLICY "Users can view own alerts"
  ON alerts FOR SELECT
  USING (user_id = auth.uid());

CREATE POLICY "Users can insert own alerts"
  ON alerts FOR INSERT
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update own alerts"
  ON alerts FOR UPDATE
  USING (user_id = auth.uid());

CREATE POLICY "Users can delete own alerts"
  ON alerts FOR DELETE
  USING (user_id = auth.uid());
