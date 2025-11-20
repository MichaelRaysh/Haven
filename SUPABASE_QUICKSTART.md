# Supabase Quick Start Guide for Haven App

## Step 1: Get Your Supabase Credentials

1. Go to [https://supabase.com](https://supabase.com) and sign in
2. Create a new project (or select existing one)
3. Go to **Settings** → **API**
4. Copy these two values:
   - **Project URL** (e.g., `https://xyz.supabase.co`)
   - **Anon key** (the public API key)

## Step 2: Update nurseApp.html

Open `nurseApp.html` and find these lines (around line 275):

```javascript
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_KEY = 'YOUR_SUPABASE_ANON_KEY';
```

Replace with your actual values:

```javascript
const SUPABASE_URL = 'https://your-project-id.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...your-key-here';
```

## Step 3: Create Database Tables

1. In Supabase dashboard, go to **SQL Editor**
2. Click **New query**
3. Copy and paste the contents of `supabase_tables.sql`
4. Click **Run** to create all tables

## Step 4: Create Storage Bucket

1. In Supabase dashboard, go to **Storage**
2. Click **New bucket**
3. Name it: `media`
4. Set to **Public** (so images/audio can be accessed)
5. Click **Create bucket**

## Step 5: Test the App

1. Open your app in the browser
2. Click "Biometric Login"
3. Try adding:
   - A patient record
   - A note
   - A medication
   - Take a photo
   - Record voice note
   - Sign signature

All data will now be saved to Supabase!

## How It Works

- **Local Storage**: The app works without Supabase (stores data in browser memory)
- **With Supabase**: All data persists across sessions and devices
- **Automatic**: When Supabase is configured, data saves automatically on every action
- **Fallback**: If Supabase fails, data still works locally

## Verify Data is Saving

1. In Supabase dashboard, go to **Table Editor**
2. Select a table (e.g., `notes`, `patients`)
3. You should see your data there!

For media files:
1. Go to **Storage** → **media** bucket
2. Browse folders to see uploaded photos, signatures, and voice notes

## Troubleshooting

**Data not saving?**
- Check browser console for error messages
- Verify credentials are correct in `nurseApp.html`
- Make sure tables are created (Step 3)
- Make sure storage bucket exists and is public (Step 4)

**Photos/signatures not showing?**
- Verify storage bucket is set to **Public**
- Check Storage policies allow public read access
