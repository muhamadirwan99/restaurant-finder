#!/bin/bash
# Load environment variables from .env file and run Flutter
export $(grep -v '^#' .env | xargs)
flutter run --dart-define=DIRECTION_API_KEY=$DIRECTION_API_KEY
