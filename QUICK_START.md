# Quick Start Guide

Get the Flutter Note Taking App up and running in minutes!

## 5-Minute Setup

### 1. Install Flutter (if not already installed)

**macOS/Linux**:
```bash
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:$(pwd)/flutter/bin"
flutter doctor
```

**Windows** (PowerShell):
```powershell
git clone https://github.com/flutter/flutter.git -b stable
$env:Path += ";$(pwd)\flutter\bin"
flutter doctor
```

### 2. Clone & Setup Project

```bash
git clone <repository-url>
cd note_taking_app
flutter pub get
```

### 3. Run the App

```bash
flutter run
```

That's it! The app should launch on your connected device or emulator.

## Keyboard Shortcuts (Development)

| Key | Action |
|-----|--------|
| `r` | Hot reload |
| `R` | Hot restart |
| `d` | Detach |
| `q` | Quit |
| `w` | Toggle widget inspector |
| `p` | Toggle performance overlay |

## First Steps

### Create Your First Note

1. **Tap the + button** at the bottom right
2. **Enter a title** in the title field
3. **Add content** in the content field
4. **Format text** using the toolbar (Bold, Italic, etc.)
5. **Add tags** by tapping the "Add Tag" button
6. **Auto-saves** as you type

### Organize Notes

- **Pin a note**: Long-press the note card and select "Pin"
- **Archive a note**: Use the menu to archive instead of delete
- **Add to favorites**: Tap the heart icon
- **Create a notebook**: Go to Notebooks tab and tap +

### Search & Filter

- **Search**: Tap the search icon and type
- **Filter by tag**: Go to Tags and select a tag
- **Sort**: Use the filter menu to change sort order

### Customize

- **Change theme**: Settings → Appearance → Theme
- **Change language**: Settings → Language
- **Choose accent color**: Settings → Appearance → Accent Color

## Project Structure at a Glance

```
lib/
├── main.dart                 # App entry point
├── screens/                  # Full-page screens
├── widgets/                  # Reusable UI components
├── providers/                # State management
├── models/                   # Data models
├── themes/                   # Styling
├── utils/                    # Helper functions
└── l10n/                     # Localization
```

## Important Files

| File | Purpose |
|------|---------|
| `pubspec.yaml` | Dependencies and configuration |
| `lib/main.dart` | App initialization and routing |
| `lib/providers/note_provider.dart` | Note state management |
| `lib/screens/home_screen.dart` | Home screen |
| `lib/themes/app_theme.dart` | Light/Dark themes |

## Common Tasks

### Run on Specific Device

```bash
flutter devices                    # List devices
flutter run -d <device-id>        # Run on device
```

### Build APK

```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Build iOS

```bash
flutter build ios --release
# Output: build/ios/ipa/
```

### Run Tests

```bash
flutter test
```

### Profile Performance

```bash
flutter run --profile
```

## Troubleshooting

### "Flutter not found"
```bash
# Add Flutter to PATH
export PATH="$PATH:~/flutter/bin"
```

### "Device not found"
```bash
flutter devices
# Start an emulator or connect a device
```

### "Build failed"
```bash
flutter clean
flutter pub get
flutter run
```

### "Hot reload not working"
```bash
# Use hot restart instead
# Press 'R' in the terminal
```

## Next Steps

1. **Read the README**: Full feature overview
2. **Check ARCHITECTURE.md**: Understand code structure
3. **Review DEVELOPMENT.md**: Development best practices
4. **Explore ACCESSIBILITY.md**: Accessibility features
5. **See LOCALIZATION.md**: Multi-language support

## Key Features to Try

- ✅ **Rich Text Editing**: Bold, italic, headings, lists
- ✅ **Multiple Languages**: Switch between English & Arabic
- ✅ **Dark Mode**: Toggle in settings
- ✅ **Responsive Design**: Try on phone and tablet
- ✅ **Search**: Find notes by title or content
- ✅ **Organization**: Use notebooks and tags
- ✅ **Reminders**: Set reminders for important notes

## Getting Help

### Documentation
- [README.md](./README.md) - Full feature list
- [INSTALLATION.md](./INSTALLATION.md) - Detailed setup
- [ARCHITECTURE.md](./ARCHITECTURE.md) - Code structure
- [DEVELOPMENT.md](./DEVELOPMENT.md) - Development guide
- [ACCESSIBILITY.md](./ACCESSIBILITY.md) - Accessibility features
- [LOCALIZATION.md](./LOCALIZATION.md) - Multi-language support

### Resources
- [Flutter Docs](https://flutter.dev/docs)
- [Dart Docs](https://dart.dev/guides)
- [Riverpod Docs](https://riverpod.dev/)

## Tips & Tricks

### Speed Up Development
- Use hot reload (press 'r')
- Use VS Code snippets
- Enable code completion in IDE

### Debug Effectively
- Use `debugPrint()` for logging
- Use DevTools for profiling
- Check console for errors

### Write Better Code
- Follow Dart style guide
- Write tests for features
- Use meaningful variable names

## What's Next?

After getting familiar with the app:

1. **Explore the code**: Read through screens and widgets
2. **Make changes**: Try modifying colors or text
3. **Add features**: Implement new functionality
4. **Write tests**: Add unit and widget tests
5. **Build & deploy**: Create release builds

## Useful Commands Reference

```bash
# Development
flutter run                    # Run app
flutter run -d <device>      # Run on specific device
flutter run --debug           # Debug mode
flutter run --release         # Release mode
flutter run --profile         # Profile mode

# Building
flutter build apk             # Build Android APK
flutter build appbundle       # Build Android App Bundle
flutter build ios             # Build iOS
flutter build web             # Build Web

# Maintenance
flutter clean                 # Clean build artifacts
flutter pub get               # Get dependencies
flutter pub upgrade           # Upgrade dependencies
flutter analyze               # Analyze code
flutter test                  # Run tests

# Utilities
flutter doctor                # Check environment
flutter devices               # List devices
flutter logs                  # View logs
flutter pub global activate devtools  # Install DevTools
```

## Quick Checklist

- [ ] Flutter SDK installed
- [ ] Project cloned
- [ ] Dependencies installed (`flutter pub get`)
- [ ] Device/emulator connected
- [ ] App runs (`flutter run`)
- [ ] Can create a note
- [ ] Can search notes
- [ ] Can change theme
- [ ] Can switch language

---

**You're all set! Happy note-taking!** 🎉📝
