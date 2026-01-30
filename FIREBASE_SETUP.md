# Firebase Setup Guide for Organizer App

## Overview
This project uses Firebase Authentication and Firestore for data storage. You need to configure both in the Firebase Console.

## Step 1: Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name (e.g., "organizer")
4. Follow the setup wizard

## Step 2: Add Android App
1. In Firebase Console, click the Android icon (or "Add app" → Android)
2. **Package name**: `com.kddev.organizer` (from `android/app/build.gradle.kts`)
3. **App nickname**: (optional) "Organizer Android"
4. Download `google-services.json`
5. Place it in: `android/app/google-services.json`

## Step 3: Enable Authentication
1. Go to **Authentication** → **Sign-in method**
2. Enable **Email/Password** provider
3. Click "Save"

## Step 4: Create Firestore Database
1. Go to **Firestore Database**
2. Click **Create database**
3. Choose **Start in test mode** (we'll add security rules)
4. Select a location (choose closest to your users)
5. Click **Enable**

## Step 5: Set Security Rules
1. Go to **Firestore Database** → **Rules** tab
2. Copy the rules from `firestore.rules` file in the project root
3. Paste and click **Publish**

**Important**: The security rules ensure:
- Users can only read/write their own notes and folders
- All operations require authentication
- Users cannot modify the `userId` field of their documents

## Step 6: Create Composite Indexes
Firestore requires composite indexes for queries that filter on multiple fields and order by another field.

### Required Indexes:

#### For `notes` collection:
1. **Collection**: `notes`
   - Fields:
     - `userId` (Ascending)
     - `createdAt` (Descending)
   - Query scope: Collection

2. **Collection**: `notes`
   - Fields:
     - `userId` (Ascending)
     - `folderId` (Ascending)
     - `createdAt` (Descending)
   - Query scope: Collection

#### For `folders` collection:
1. **Collection**: `folders`
   - Fields:
     - `userId` (Ascending)
     - `createdAt` (Descending)
   - Query scope: Collection

2. **Collection**: `folders`
   - Fields:
     - `userId` (Ascending)
     - `parentId` (Ascending)
     - `createdAt` (Descending)
   - Query scope: Collection

### How to Create Indexes:
**Option 1: Automatic (Recommended)**
- When you run the app and perform queries, Firestore will show error messages with direct links to create the missing indexes
- Click the link in the error message to create the index automatically

**Option 2: Manual**
1. Go to **Firestore Database** → **Indexes** tab
2. Click **Create Index**
3. Select the collection
4. Add fields in the order specified above
5. Click **Create**

## Step 7: (Optional) Add iOS App
If you plan to support iOS:
1. In Firebase Console, click "Add app" → iOS
2. **Bundle ID**: (from your iOS project)
3. Download `GoogleService-Info.plist`
4. Place it in: `ios/Runner/GoogleService-Info.plist`

## Data Structure

### Notes Collection
Each document contains:
- `id` (string) - Document ID
- `name` (string) - Note name
- `type` (string) - "text", "todo", or "list"
- `userId` (string) - Owner's user ID
- `folderId` (string, nullable) - Parent folder ID (null for root)
- `createdAt` (timestamp) - Creation date
- `content` (string, for text notes) - Text content
- `tasks` (array, for todo notes) - Todo tasks
- `items` (array, for list notes) - List items

### Folders Collection
Each document contains:
- `id` (string) - Document ID
- `name` (string) - Folder name
- `userId` (string) - Owner's user ID
- `parentId` (string, nullable) - Parent folder ID (null for root)
- `createdAt` (timestamp) - Creation date

## Testing
After setup:
1. Run `flutter pub get`
2. Run `flutter run`
3. Try signing up with a test email
4. The app should create notes and folders in Firestore

## Troubleshooting

### "Failed to load FirebaseOptions" error
- Ensure `google-services.json` is in `android/app/`
- Rebuild the app: `flutter clean && flutter pub get && flutter run`

### "Missing or insufficient permissions" error
- Check that security rules are published
- Verify the user is authenticated
- Ensure `userId` matches `request.auth.uid`

### Query index errors
- Create the missing composite indexes as described above
- Wait a few minutes for indexes to build
