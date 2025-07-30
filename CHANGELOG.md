# Restaurant Finder - Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-07-30

### Added

- **Core Features**

  - Restaurant search functionality with name and city filtering
  - Featured restaurants carousel on home screen
  - Detailed restaurant information pages
  - Google Maps integration for location viewing
  - Turn-by-turn navigation to restaurants

- **Authentication System**

  - Email/password authentication via Firebase
  - Google Sign-In integration
  - User profile management
  - Secure session handling

- **User Personalization**

  - Favorites system for saving restaurants
  - Local storage for offline favorites access
  - User review submission and viewing
  - Personalized restaurant recommendations

- **UI/UX Improvements**

  - Material Design 3 implementation
  - Dark and light theme support
  - Responsive design for all screen sizes
  - Smooth animations and transitions
  - Skeleton loading states

- **Technical Implementation**
  - Modular architecture with separate packages
  - BLoC pattern for state management
  - Hive for local data persistence
  - Dio for network requests
  - GoRouter for navigation
  - Firebase Analytics and Crashlytics

### Technical Details

- **Flutter Version**: 3.3.4+
- **Dart Version**: 3.3.4+
- **Target Platforms**: Android, iOS
- **Minimum SDK**: Android 21, iOS 12.0

### Dependencies

- `firebase_core: ^2.31.0`
- `firebase_auth: ^4.19.5`
- `google_maps_flutter: ^2.6.1`
- `dio: ^5.6.0`
- `hive: ^2.2.3`
- `go_router: ^14.2.7`
- `flutter_bloc: ^8.1.6`

## [Unreleased]

### Planned Features

- [ ] Restaurant booking integration
- [ ] Advanced filtering (cuisine type, price range, ratings)
- [ ] Social features (share restaurants, follow friends)
- [ ] Offline maps support
- [ ] Push notifications for favorite restaurants
- [ ] Restaurant menu viewing
- [ ] Photo upload for reviews
- [ ] Voice search functionality
