@echo off
REM Load environment variables from .env file and run Flutter
for /f "usebackq tokens=1,2 delims==" %%a in (".env") do (
    set %%a=%%b
)

flutter run --dart-define=DIRECTION_API_KEY=%DIRECTION_API_KEY%
