# Supabase Setup Guide for Haven App

## Step 1: Create a Supabase Project

1. Go to [supabase.com](https://supabase.com)
2. Click "Start your project"
3. Sign up or log in
4. Create a new project:
   - Give it a name (e.g., "Haven")
   - Choose a region close to you
   - Create a strong database password
5. Wait for the project to initialize

## Step 2: Get Your Credentials

1. In your Supabase dashboard, go to **Settings** → **API**
2. Copy:
   - **Project URL** (looks like: `https://your-project.supabase.co`)
   - **Anon Key** (your public API key)
3. Keep these safe!

## Step 3: Update nurseApp.html

In `nurseApp.html`, find these lines near the top of the script (around line 145):

```javascript
const SUPABASE_URL = 'https://your-project.supabase.co';
const SUPABASE_KEY = 'your-anon-key';
```

Replace with your actual credentials:

```javascript
const SUPABASE_URL = 'https://xyz-abc-123.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

## Step 4: Create Database Tables

In your Supabase dashboard, go to **SQL Editor** and run these queries:

### 1. Profiles table (for user info)
```sql
CREATE TABLE profiles (
  id UUID REFERENCES auth.users(id),
  email TEXT UNIQUE,
  username TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY (id)
);
```

### 2. Patients table
```sql
CREATE TABLE patients (
  id UUID DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id),
  name TEXT NOT NULL,
  age INT,
  allergies TEXT,
  conditions TEXT,
  last_visit DATE,
  created_at TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE
);
```

### 3. Medications table
```sql
CREATE TABLE medications (
  id UUID DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id),
  patient TEXT NOT NULL,
  drug TEXT NOT NULL,
  dosage TEXT,
  frequency TEXT,
  status TEXT DEFAULT 'on-time',
  created_at TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE
);
```

### 4. Notes table
```sql
CREATE TABLE notes (
  id UUID DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id),
  patient TEXT NOT NULL,
  title TEXT NOT NULL,
  content TEXT,
  category TEXT DEFAULT 'general',
  timestamp TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE
);
```

### 5. Appointments table
```sql
CREATE TABLE appointments (
  id UUID DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id),
  patient TEXT NOT NULL,
  date DATE,
  time TEXT,
  type TEXT,
  address TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE
);
```

### 6. Messages table
```sql
CREATE TABLE messages (
  id UUID DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id),
  sender TEXT,
  recipient TEXT NOT NULL,
  subject TEXT,
  body TEXT,
  read BOOLEAN DEFAULT FALSE,
  timestamp TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE
);
```

### 7. Mileage Trips table
```sql
CREATE TABLE mileage_trips (
  id UUID DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id),
  date DATE,
  miles DECIMAL(10, 2),
  destination TEXT,
  purpose TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE
);
```

### 8. Voice Notes table
```sql
CREATE TABLE voice_notes (
  id UUID DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id),
  title TEXT,
  audio_url TEXT,
  duration INT,
  created_at TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE
);
```

### 9. Alerts table
```sql
CREATE TABLE alerts (
  id UUID DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id),
  priority TEXT DEFAULT 'normal',
  message TEXT NOT NULL,
  acknowledged BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE
);
```

## Step 5: Enable Row-Level Security (RLS)

For each table, enable RLS and add a policy:

1. Select the table (e.g., `patients`)
2. Click **RLS** button to enable it
3. Click **+ Add Policy** and choose **Enable read access for own rows**
4. Set the condition to `user_id = auth.uid()`
5. Click **Save policy**
6. Repeat for write access

Or run this SQL for all tables:

```sql
-- Enable RLS on all tables
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE patients ENABLE ROW LEVEL SECURITY;
ALTER TABLE medications ENABLE ROW LEVEL SECURITY;
ALTER TABLE notes ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE mileage_trips ENABLE ROW LEVEL SECURITY;
ALTER TABLE voice_notes ENABLE ROW LEVEL SECURITY;
ALTER TABLE alerts ENABLE ROW LEVEL SECURITY;

-- Create policies for all tables (example for patients)
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

-- Repeat similar policies for other tables
```

## Step 6: Test the App

1. Visit your deployed app (Vercel)
2. Click **Create Account**
3. Use a test email (e.g., `test@example.com`) and password
4. You should now be able to log in and see your data persisted in Supabase!

## Troubleshooting

- **"Invalid login credentials"**: Check your email/password match what you signed up with
- **"CORS error"**: Make sure you've enabled the Anon Key in Supabase settings
- **"Rows not saving"**: Check that RLS policies are set up correctly - they should allow `user_id = auth.uid()`
- **Data not loading**: Verify the table names in the code match your Supabase tables exactly

## Demo Credentials

The app is currently set to suggest `test@example.com / password123` as demo credentials. You can change this in the login form, or create this user through Supabase Auth.

## Need Help?

- Supabase Docs: https://supabase.com/docs
- Check the SQL Editor for any errors
- Enable RLS carefully - it restricts access, so policies must be correct
