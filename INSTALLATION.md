# Installation & Build Guide

This document provides comprehensive instructions for installing, building, and running the Flutter Note Taking App on different platforms.

## System Requirements

### Minimum Requirements
- **RAM**: 4 GB minimum (8 GB recommended)
- **Disk Space**: 2 GB free space
- **Internet Connection**: Required for downloading dependencies

### Operating System Support
- **Windows**: Windows 10 or later
- **macOS**: macOS 10.15 or later
- **Linux**: Ubuntu 18.04 or later

## Flutter SDK Installation

### Step 1: Download Flutter SDK

Visit [flutter.dev](https://flutter.dev/docs/get-started/install) and download the stable version (3.38.3 or later).

### Step 2: Extract Flutter

**Windows**:
```bash
# Extract to a location without spaces
C:\src\flutter
```

**macOS/Linux**:
```bash
cd ~/development
unzip ~/Downloads/flutter_macos_3.38.3-stable.zip
# or
tar xf ~/Downloads/flutter_linux_3.38.3-stable.tar.xz
```

### Step 3: Add Flutter to PATH

**Windows** (PowerShell):
```powershell
$env:Path += ";C:\src\flutter\bin"
```

**macOS/Linux** (Bash/Zsh):
```bash
export PATH="$PATH:~/development/flutter/bin"
# Add to ~/.bashrc or ~/.zshrc for permanent effect
echo 'export PATH="$PATH:~/development/flutter/bin"' >> ~/.bashrc
```

### Step 4: Verify Installation

```bash
flutter --version
dart --version
flutter doctor
```

## Project Setup

### Clone the Repository

```bash
git clone <repository-url>
cd note_taking_app
```

### Install Dependencies

```bash
flutter pub get
```

### Check Environment

```bash
flutter doctor
```

This command checks for:
- Flutter SDK
- Dart SDK
- Android toolchain
- Xcode (macOS)
- VS Code/Android Studio
- Connected devices

## Running the App

### Run on Connected Device

```bash
flutter run
```

### Run on Specific Device

```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

### Run with Release Build

```bash
flutter run --release
```

### Run with Verbose Output

```bash
flutter run -v
```

## Building for Android

### Prerequisites
- Android SDK (API level 21 or higher)
- Android NDK
- Java Development Kit (JDK) 11 or higher

### Build APK

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release
```

### Build App Bundle (Recommended for Play Store)

```bash
flutter build appbundle --release
```

### Output Location
- APK: `build/app/outputs/flutter-apk/app-release.apk`
- App Bundle: `build/app/outputs/bundle/release/app-release.aab`

### Sign APK

1. **Create keystore** (if not exists):
```bash
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

2. **Create signing config** in `android/key.properties`:
```properties
storeFile=~/key.jks
storePassword=<your-password>
keyPassword=<your-password>
keyAlias=key
```

3. **Build signed APK**:
```bash
flutter build apk --release
```

## Building for iOS

### Prerequisites
- Xcode 12 or later
- CocoaPods
- iOS 11.0 or later

### Build IPA

```bash
# Debug build
flutter build ios --debug

# Release build
flutter build ios --release
```

### Build for App Store

```bash
flutter build ios --release
```

### Output Location
- IPA: `build/ios/ipa/`

### Deploy to App Store

1. Open project in Xcode:
```bash
open ios/Runner.xcworkspace
```

2. Configure signing:
   - Select Runner project
   - Go to Signing & Capabilities
   - Select your team
   - Update bundle identifier

3. Archive and upload:
   - Product → Archive
   - Distribute App
   - Upload to App Store

## Building for Web

### Enable Web Support

```bash
flutter config --enable-web
```

### Build Web

```bash
# Debug build
flutter build web --debug

# Release build
flutter build web --release
```

### Output Location
- Web: `build/web/`

### Serve Locally

```bash
flutter run -d web-server
```

Then open `http://localhost:8080` in your browser.

## Troubleshooting

### Common Issues

#### Issue: "flutter: command not found"
**Solution**: 
1. Verify Flutter is in PATH: `echo $PATH`
2. Re-add Flutter to PATH if needed
3. Restart terminal/IDE

#### Issue: "Gradle build failed"
**Solution**:
```bash
flutter clean
flutter pub get
flutter build apk
```

#### Issue: "CocoaPods error" (iOS)
**Solution**:
```bash
cd ios
rm -rf Pods
rm Podfile.lock
cd ..
flutter pub get
flutter build ios
```

#### Issue: "Android SDK not found"
**Solution**:
1. Install Android Studio
2. Set `ANDROID_SDK_ROOT`:
```bash
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk  # macOS
export ANDROID_SDK_ROOT=$HOME/Android/Sdk  # Linux
```

#### Issue: "Xcode not found" (macOS)
**Solution**:
```bash
sudo xcode-select --install
# or
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

#### Issue: "Insufficient disk space"
**Solution**:
```bash
# Clean build artifacts
flutter clean

# Remove old builds
rm -rf build/
rm -rf .dart_tool/
```

## Development Setup

### IDE Setup

#### Visual Studio Code
1. Install Flutter extension
2. Install Dart extension
3. Create `.vscode/launch.json`:
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter",
      "type": "dart",
      "request": "launch",
      "program": "lib/main.dart"
    }
  ]
}
```

#### Android Studio
1. Install Flutter plugin
2. Install Dart plugin
3. Create new Flutter project or open existing

#### IntelliJ IDEA
1. Install Flutter plugin
2. Install Dart plugin
3. Configure Flutter SDK path

### Debugging

#### Debug Mode
```bash
flutter run
# Press 'r' to hot reload
# Press 'R' to hot restart
```

#### Debug with DevTools
```bash
flutter pub global activate devtools
devtools
```

#### Logging
```dart
import 'dart:developer' as developer;

developer.log('Debug message');
print('Print statement');
debugPrint('Debug print');
```

## Performance Optimization

### Build Size Optimization

```bash
# Analyze APK size
flutter build apk --analyze-size

# Remove unused code
flutter build apk --split-per-abi
```

### Runtime Performance

```bash
# Profile mode (between debug and release)
flutter run --profile

# Release mode (optimized)
flutter run --release
```

## Continuous Integration

### GitHub Actions Example

```yaml
name: Flutter Build

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.38.3'
      - run: flutter pub get
      - run: flutter build apk --release
      - run: flutter build web --release
```

## Release Checklist

- [ ] Update version in `pubspec.yaml`
- [ ] Update `CHANGELOG.md`
- [ ] Test on multiple devices
- [ ] Run `flutter analyze`
- [ ] Run `flutter test`
- [ ] Build release APK/IPA
- [ ] Sign binaries
- [ ] Upload to stores
- [ ] Create release notes
- [ ] Tag release in git

## Version Management

Update version in `pubspec.yaml`:
```yaml
version: 1.0.0+1
# Format: major.minor.patch+buildNumber
```

## Useful Commands

```bash
# Clean build artifacts
flutter clean

# Get dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade

# Analyze code
flutter analyze

# Format code
dart format lib/

# Run tests
flutter test

# Generate documentation
dartdoc

# Check for issues
flutter doctor -v

# Update Flutter
flutter upgrade
```

## Resources

- [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- [Flutter Build Documentation](https://flutter.dev/docs/deployment)
- [Android Build Documentation](https://flutter.dev/docs/deployment/android)
- [iOS Build Documentation](https://flutter.dev/docs/deployment/ios)
- [Web Build Documentation](https://flutter.dev/docs/deployment/web)

---

**Happy Building!** 🚀
