# Environment Variables Setup

This project uses `flutter_dotenv` to load environment variables from a `.env` file.

## Configuration

1. **Environment File**: The `.env` file contains:

   ```
   GOOGLE_MAPS_API_KEY=your_google_maps_api_key_here
   DIRECTION_API_KEY=your_direction_api_key_here
   ```

2. **Usage in Code**: Environment variables are accessed using:

   ```dart
   dotenv.env['DIRECTION_API_KEY']
   ```

3. **Initialization**: Environment variables are loaded in `lib/setup.dart` during app initialization:
   ```dart
   await dotenv.load(fileName: ".env");
   ```

## Direction API Key

The Direction Controller now uses the `DIRECTION_API_KEY` from the `.env` file:

```dart
Future<void> setPolylines(gmaps.LatLng source, gmaps.LatLng destination) async {
  final result = await Direction.getDirections(
    googleMapsApiKey: dotenv.env['DIRECTION_API_KEY'] ?? '',
    origin: source,
    destination: destination,
  );
  // ... rest of the method
}
```

## Security Notes

- The `.env` file is included in `.gitignore` to prevent committing sensitive API keys
- Always use environment variables for API keys in production
- For deployment, ensure environment variables are properly configured in your deployment environment
