# Restaurant Finder

A Flutter application for finding restaurants with Google Maps integration.

## Getting Started

### Prerequisites

- Flutter SDK
- Android Studio / VS Code
- Google Maps API Key

### Setup

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd restaurant-finder
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Setup Environment Variables**

   - Copy `.env.example` to `.env`

   ```bash
   cp .env.example .env
   ```

   - Edit `.env` file and add your Google Maps API Key:

   ```
   GOOGLE_MAPS_API_KEY=your_actual_api_key_here
   ```

4. **Get Google Maps API Key**

   - Go to [Google Cloud Console](https://console.cloud.google.com/google/maps-apis)
   - Create a new project or select existing one
   - Enable Maps SDK for Android/iOS
   - Create credentials (API Key)
   - Add the API key to your `.env` file

5. **Run the app**
   ```bash
   flutter run
   ```

This project follows the
[simple app state management
tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).
