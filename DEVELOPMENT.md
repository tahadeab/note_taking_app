# Development Guide

This guide provides best practices and workflows for developing the Flutter Note Taking App.

## Development Environment Setup

### Required Tools

1. **Flutter SDK** (3.38.3+)
   ```bash
   flutter --version
   ```

2. **Dart SDK** (3.10.1+)
   ```bash
   dart --version
   ```

3. **IDE** (Choose one):
   - Visual Studio Code with Flutter extension
   - Android Studio with Flutter plugin
   - IntelliJ IDEA with Flutter plugin

4. **Git**
   ```bash
   git --version
   ```

### IDE Configuration

#### Visual Studio Code

Install extensions:
- Flutter
- Dart
- Awesome Flutter Snippets
- Error Lens
- Better Comments

Create `.vscode/settings.json`:
```json
{
  "dart.enableSdkFormatter": true,
  "dart.lineLength": 100,
  "[dart]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "Dart-Code.dart-code"
  }
}
```

#### Android Studio

1. Install Flutter plugin
2. Configure Flutter SDK path
3. Enable code analysis
4. Set up emulator

## Code Style & Standards

### Naming Conventions

**Classes**: PascalCase
```dart
class NoteCard { }
class HomeScreen { }
```

**Variables & Functions**: camelCase
```dart
String noteTitle;
void addNewNote() { }
```

**Constants**: camelCase with `const`
```dart
const String appName = 'Note Taking App';
const int maxNoteLength = 5000;
```

**Private Members**: Leading underscore
```dart
String _privateVariable;
void _privateMethod() { }
```

### Code Formatting

Use Dart formatter:
```bash
dart format lib/
```

Configure in IDE for automatic formatting on save.

### Imports Organization

```dart
// Dart imports
import 'dart:async';
import 'dart:convert';

// Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Package imports
import 'package:intl/intl.dart';

// Relative imports
import 'models/note.dart';
import '../providers/note_provider.dart';
```

### Documentation

#### Class Documentation
```dart
/// A widget that displays a single note card.
/// 
/// This widget shows a preview of a note including its title,
/// content snippet, and associated tags.
class NoteCard extends StatelessWidget {
  /// Creates a NoteCard.
  const NoteCard({
    Key? key,
    required this.note,
  }) : super(key: key);
}
```

#### Method Documentation
```dart
/// Adds a new note to the collection.
/// 
/// Returns the ID of the newly created note.
/// Throws [InvalidNoteException] if the note is invalid.
String addNote(Note note) {
  // Implementation
}
```

#### Inline Comments
```dart
// Use inline comments for complex logic
// Explain WHY, not WHAT
final filtered = notes.where((note) {
  // Filter by creation date to show only recent notes
  return note.createdAt.isAfter(
    DateTime.now().subtract(const Duration(days: 30)),
  );
}).toList();
```

## Git Workflow

### Branch Naming

```
feature/add-note-sharing
bugfix/fix-rtl-layout
docs/update-readme
refactor/improve-performance
```

### Commit Messages

```
feat: Add note sharing functionality
fix: Fix RTL layout issue in Arabic
docs: Update installation guide
style: Format code with dartfmt
refactor: Extract NoteCard widget
test: Add unit tests for NoteProvider
```

### Pull Request Process

1. Create feature branch
2. Make changes with meaningful commits
3. Push to remote
4. Create pull request with description
5. Address review comments
6. Merge when approved

## Testing

### Unit Tests

Location: `test/unit/`

```dart
void main() {
  group('NoteProvider', () {
    test('addNote adds a note to the list', () {
      final notifier = NotesNotifier();
      final note = Note(title: 'Test', content: 'Content');
      
      notifier.addNote(note);
      
      expect(notifier.state.notes.length, 1);
    });
  });
}
```

Run tests:
```bash
flutter test
flutter test test/unit/
flutter test --coverage
```

### Widget Tests

Location: `test/widget/`

```dart
void main() {
  testWidgets('NoteCard displays note title', (WidgetTester tester) async {
    final note = Note(title: 'Test Note', content: '');
    
    await tester.pumpWidget(
      MaterialApp(home: NoteCard(note: note)),
    );
    
    expect(find.text('Test Note'), findsOneWidget);
  });
}
```

### Integration Tests

Location: `integration_test/`

```dart
void main() {
  testWidgets('Create and save note', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    // Tap add button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    
    // Enter note
    await tester.enterText(find.byType(TextField), 'Test Note');
    
    // Verify note was created
    expect(find.text('Test Note'), findsOneWidget);
  });
}
```

## Code Quality

### Static Analysis

```bash
flutter analyze
dart analyze
```

Configure in `analysis_options.yaml`:
```yaml
linter:
  rules:
    - avoid_empty_else
    - avoid_print
    - avoid_relative_lib_imports
    - avoid_returning_null_for_future
    - avoid_slow_async_io
    - cancel_subscriptions
    - close_sinks
    - comment_references
    - control_flow_in_finally
    - empty_statements
    - hash_and_equals
    - invariant_booleans
    - iterable_contains_unrelated_type
    - list_remove_unrelated_type
    - no_adjacent_strings_in_list
    - no_duplicate_case_values
    - prefer_void_to_null
    - throw_in_finally
    - unnecessary_statements
    - unrelated_type_equality_checks
```

### Code Coverage

```bash
flutter test --coverage
lcov --list coverage/lcov.info
```

Target: Maintain >80% code coverage

## Performance Optimization

### Profiling

```bash
# Profile mode
flutter run --profile

# Use DevTools
flutter pub global activate devtools
devtools
```

### Common Optimizations

1. **Lazy Loading**
   ```dart
   final lazyProvider = FutureProvider<List<Note>>((ref) async {
     return await loadNotesFromDatabase();
   });
   ```

2. **Memoization**
   ```dart
   final cachedProvider = Provider<List<Note>>((ref) {
     final notes = ref.watch(notesProvider);
     return notes.where((n) => n.isPinned).toList();
   });
   ```

3. **Selective Rebuilds**
   ```dart
   // Only watch what you need
   final title = ref.watch(notesProvider.select((state) => state.title));
   ```

## Debugging

### Debug Mode

```bash
flutter run
# Press 'r' for hot reload
# Press 'R' for hot restart
# Press 'd' to detach
```

### Logging

```dart
import 'dart:developer' as developer;

developer.log('Debug message', name: 'app.notes');
print('Print statement');
debugPrint('Debug print');
```

### DevTools

```bash
flutter pub global activate devtools
devtools

# Or from VS Code
# Run "Flutter: Open DevTools"
```

## Common Tasks

### Adding a New Screen

1. Create screen file in `lib/screens/`
2. Create provider in `lib/providers/` if needed
3. Add route in `main.dart`
4. Add navigation in drawer/bottom nav
5. Write tests

Example:
```dart
// lib/screens/new_screen.dart
class NewScreen extends ConsumerWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Screen')),
      body: Center(child: const Text('Content')),
    );
  }
}
```

### Adding a New Provider

1. Create provider in `lib/providers/`
2. Define state class if needed
3. Create notifier if mutable state
4. Export from provider file

Example:
```dart
// lib/providers/new_provider.dart
final newProvider = StateNotifierProvider<NewNotifier, NewState>((ref) {
  return NewNotifier();
});

class NewNotifier extends StateNotifier<NewState> {
  NewNotifier() : super(const NewState());
}

class NewState {
  final String value;
  const NewState({this.value = ''});
}
```

### Adding a New Widget

1. Create widget file in `lib/widgets/`
2. Make it reusable and configurable
3. Document with comments
4. Add to widget library

Example:
```dart
// lib/widgets/new_widget.dart
/// A reusable widget for displaying content.
class NewWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const NewWidget({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(title),
    );
  }
}
```

## Troubleshooting

### Hot Reload Not Working

```bash
flutter clean
flutter pub get
flutter run
```

### Build Fails

```bash
flutter clean
flutter pub get
flutter pub upgrade
flutter build apk --debug
```

### Dependencies Conflict

```bash
flutter pub upgrade
flutter pub get
```

### Memory Issues

```bash
# Increase heap size
export JAVA_OPTS="-Xmx4096m"
flutter build apk
```

## Useful Commands

```bash
# Check environment
flutter doctor -v

# Clean build
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

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release

# Build web
flutter build web --release

# Generate documentation
dartdoc

# Run specific test
flutter test test/unit/note_provider_test.dart

# Run with verbose output
flutter run -v

# Profile app
flutter run --profile
```

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Riverpod Documentation](https://riverpod.dev/)
- [Material Design](https://material.io/design)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

---

**Happy Coding!** 💻✨
