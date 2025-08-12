# Enigma Voice

Mystery storyteller detective game with Hindi TTS, answer validation using Gemini, offline-first storage with Hive, and Firebase-powered leaderboard.

## Run

```bash
flutter pub get
flutter run --dart-define=GEMINI_API_KEY=YOUR_KEY
```

## Configure Firebase

1. Install FlutterFire CLI and login.
2. In this directory, run:

```bash
flutterfire configure --project YOUR_FIREBASE_PROJECT
```

This will generate `lib/firebase_options.dart`. The app will run without it for offline development, but Firebase features will be disabled.

## Structure (Clean Architecture)

- `lib/core`: router, theme, DI, shared services (TTS, Hive, Gemini)
- `lib/features/stories`: domain/data/presentation for story reading and answering
- `lib/features/leaderboard`: leaderboard UI and data (Firebase)
- `assets/stories`: bundled sample stories for offline

## Gemini

Provide `--dart-define=GEMINI_API_KEY=...` when running to enable real validation and hints.
