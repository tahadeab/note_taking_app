# Flutter Note Taking App

A professional, feature-rich note-taking application built with Flutter and Dart. This app provides a complete solution for organizing, managing, and editing notes with support for rich text formatting, multiple languages (English & Arabic with RTL support), and responsive design for phones and tablets.

## Features

### Core Features
- **Rich Text Editor**: Bold, italic, underline, strikethrough, headings, lists, blockquotes, and inline code formatting
- **Note Management**: Create, edit, delete, pin, archive, and favorite notes
- **Responsive Design**: Optimized layouts for phones (portrait/landscape) and tablets
- **Material 3 Design**: Modern, clean UI following Material Design 3 principles
- **Dark & Light Modes**: Automatic theme detection with manual override options

### Organization
- **Notebooks**: Organize notes into multiple notebooks/folders
- **Tags**: Categorize notes with custom tags for easy filtering
- **Search**: Real-time search across note titles and content
- **Filters & Sort**: Filter by tags, notebooks, and date ranges; sort by newest, last edited, or alphabetical

### Accessibility & Internationalization
- **Dual Language Support**: Full English and Arabic support
- **RTL Layout**: Automatic right-to-left layout for Arabic language
- **Accessibility Features**: Screen reader labels, semantic widgets, large font support
- **Proper Semantics**: Semantic labels for all interactive elements

### Additional Features
- **Reminders**: Set reminders for important notes
- **Attachments**: Support for images, audio, and file attachments
- **Autosave**: Automatic saving of note changes
- **Customizable Colors**: Choose accent colors and note background colors
- **Responsive Grid/List View**: Toggle between grid and list view layouts

## Project Structure

```
lib/
├── main.dart                          # Application entry point
├── models/
│   └── note.dart                      # Data models (Note, Notebook, Tag, Reminder)
├── providers/
│   ├── note_provider.dart             # Riverpod state management for notes
│   └── theme_provider.dart            # Theme state management
├── screens/
│   ├── home_screen.dart               # Home screen with recent/pinned notes
│   ├── note_list_screen.dart          # All notes with filtering
│   ├── note_editor_screen.dart        # Rich text editor
│   ├── search_screen.dart             # Search interface
│   ├── reminders_screen.dart          # Reminders management
│   ├── notebooks_screen.dart          # Notebooks/folders view
│   ├── tags_screen.dart               # Tags management
│   └── settings_screen.dart           # App settings
├── widgets/
│   ├── note_card.dart                 # Note card and list item widgets
│   ├── rich_text_toolbar.dart         # Text formatting toolbar
│   ├── filter_and_sort_widget.dart    # Filter and sort UI
│   └── app_drawer.dart                # Navigation drawer
├── themes/
│   └── app_theme.dart                 # Light and dark theme definitions
├── utils/
│   ├── app_constants.dart             # Application constants
│   └── responsive_helper.dart         # Responsive design utilities
├── l10n/
│   └── app_localizations.dart         # Localization strings (EN & AR)
└── assets/
    ├── images/                        # Image assets
    ├── icons/                         # Icon assets
    ├── fonts/                         # Custom fonts
    └── animations/                    # Animation assets
```

## Technology Stack

### Core
- **Flutter**: 3.38.3 (Stable Channel)
- **Dart**: 3.10.1
- **Null Safety**: Enabled

### State Management
- **flutter_riverpod**: ^2.4.0 - Reactive state management

### UI & Design
- **Material 3**: Built-in Material Design 3 support
- **google_fonts**: ^6.1.0 - Beautiful typography
- **flutter_quill**: ^11.5.0 - Rich text editor
- **animations**: ^2.0.11 - Smooth transitions

### Localization & Internationalization
- **intl**: ^0.20.2 - Date/time formatting
- **flutter_localizations**: Built-in localization support

### File & Media Handling
- **image_picker**: ^1.0.4 - Image selection
- **file_picker**: ^6.1.0 - File selection
- **path_provider**: ^2.1.0 - File paths

### Data & Storage
- **sqflite**: ^2.3.0 - Local SQLite database
- **uuid**: ^4.0.0 - Unique ID generation

### Notifications
- **flutter_local_notifications**: ^16.1.0 - Local notifications

## Getting Started

### Prerequisites
- Flutter SDK (3.38.3 or higher)
- Dart SDK (3.10.1 or higher)
- Android SDK (for Android development)
- Xcode (for iOS development)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd note_taking_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Different Platforms

**Android**
```bash
flutter build apk --release
# or for App Bundle
flutter build appbundle --release
```

**iOS**
```bash
flutter build ios --release
```

**Web**
```bash
flutter build web --release
```

## Usage Guide

### Creating a Note
1. Tap the floating action button (+ icon) on any screen
2. Enter a title and content
3. Use the toolbar to format your text
4. Add tags, attachments, or set reminders as needed
5. The note auto-saves as you type

### Organizing Notes
- **Pin Important Notes**: Long-press or use the menu to pin notes to the top
- **Create Notebooks**: Organize notes into different notebooks
- **Add Tags**: Categorize notes with custom tags
- **Archive Old Notes**: Archive notes instead of deleting them

### Searching & Filtering
- Use the search icon to find notes by title or content
- Filter by tags, notebooks, or date ranges
- Sort by newest, last edited, or alphabetically

### Customization
- **Theme**: Switch between light, dark, or system theme
- **Language**: Change between English and Arabic
- **Accent Color**: Choose your preferred accent color
- **Font Size**: Adjust text size for better readability

## Accessibility Features

- **Screen Reader Support**: All elements have proper semantic labels
- **Large Font Support**: Adjustable font sizes for better readability
- **High Contrast**: Dark mode for reduced eye strain
- **Keyboard Navigation**: Full keyboard support for navigation
- **RTL Support**: Full right-to-left layout for Arabic

## Localization

The app supports English and Arabic with automatic RTL layout for Arabic. To add more languages:

1. Add new locale to `supportedLocales` in `main.dart`
2. Add translation strings to `AppLocalizations` class
3. Update `pubspec.yaml` with new language assets

## State Management with Riverpod

The app uses Riverpod for reactive state management:

```dart
// Watch a provider
final notes = ref.watch(notesProvider);

// Read a provider (one-time access)
final notifier = ref.read(notesProvider.notifier);

// Perform actions
notifier.addNote(note);
notifier.deleteNote(noteId);
notifier.togglePin(noteId);
```

## Responsive Design

The app uses `ResponsiveHelper` utility for responsive layouts:

```dart
// Check screen size
if (ResponsiveHelper.isMobile(context)) {
  // Mobile layout
} else if (ResponsiveHelper.isTablet(context)) {
  // Tablet layout
}

// Get responsive values
final columns = ResponsiveHelper.getGridColumns(context);
final padding = ResponsiveHelper.getResponsivePadding(context);
```

## Testing

To run tests:
```bash
flutter test
```

## Performance Optimization

- **Lazy Loading**: Notes are loaded on demand
- **Efficient Filtering**: Optimized search and filter algorithms
- **Image Optimization**: Automatic image compression
- **Memory Management**: Proper resource cleanup

## Troubleshooting

### App Won't Build
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

### Performance Issues
- Clear app cache: `flutter clean`
- Reduce number of notes loaded at once
- Optimize image sizes

### Localization Not Working
- Ensure `flutter_localizations` is properly configured
- Check locale is supported in `supportedLocales`
- Rebuild app after changing language

## Future Enhancements

- [ ] Cloud synchronization (Firebase)
- [ ] Collaborative editing
- [ ] Voice-to-text transcription
- [ ] Advanced rich text formatting
- [ ] Note templates
- [ ] Export to PDF/Word
- [ ] Offline-first sync
- [ ] Widget integration for Android home screen

## Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Code Style

This project follows:
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- [Flutter Best Practices](https://flutter.dev/docs/testing/best-practices)
- [Material Design 3](https://m3.material.io/)

## License

This project is licensed under the MIT License - see the LICENSE file for details.


