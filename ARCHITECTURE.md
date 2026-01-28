# Application Architecture

This document describes the architecture and design patterns used in the Flutter Note Taking App.

## Architecture Overview

The application follows a **clean architecture** pattern with clear separation of concerns:

```
┌─────────────────────────────────────────────────────────────┐
│                     Presentation Layer                       │
│  (Screens, Widgets, UI Components)                          │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                  State Management Layer                      │
│  (Riverpod Providers, Notifiers)                            │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                    Domain Layer                              │
│  (Models, Business Logic)                                   │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                    Data Layer                                │
│  (Repositories, Local Storage, API)                         │
└─────────────────────────────────────────────────────────────┘
```

## Layer Breakdown

### 1. Presentation Layer

**Location**: `lib/screens/` and `lib/widgets/`

**Responsibility**: Display UI and handle user interactions

**Components**:
- **Screens**: Full-page widgets (HomeScreen, NoteListScreen, etc.)
- **Widgets**: Reusable UI components (NoteCard, RichTextToolbar, etc.)
- **Theme**: Visual styling (AppTheme)

**Key Principles**:
- Stateless when possible
- Use ConsumerWidget for Riverpod integration
- Delegate business logic to providers

**Example**:
```dart
class NoteListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(filteredNotesProvider);
    
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return NoteCard(note: notes[index]);
      },
    );
  }
}
```

### 2. State Management Layer

**Location**: `lib/providers/`

**Responsibility**: Manage application state and business logic

**Components**:
- **Providers**: Expose state and functions
- **Notifiers**: Manage state changes
- **State Classes**: Immutable state objects

**Key Patterns**:
- **StateNotifierProvider**: For mutable state
- **Provider**: For derived/computed state
- **StateProvider**: For simple state

**Example**:
```dart
class NotesNotifier extends StateNotifier<NotesState> {
  NotesNotifier() : super(const NotesState());
  
  void addNote(Note note) {
    state = state.copyWith(
      notes: [...state.notes, note],
    );
  }
}

final notesProvider = StateNotifierProvider<NotesNotifier, NotesState>((ref) {
  return NotesNotifier();
});
```

### 3. Domain Layer

**Location**: `lib/models/`

**Responsibility**: Define data structures and business entities

**Components**:
- **Models**: Data classes (Note, Notebook, Tag, Reminder)
- **Enums**: Enumerated types
- **Constants**: Domain-specific constants

**Key Principles**:
- Immutable data classes
- Use `copyWith()` for modifications
- Include `toJson()` and `fromJson()` for serialization

**Example**:
```dart
class Note {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final List<String> tags;
  
  Note copyWith({
    String? title,
    String? content,
    List<String>? tags,
  }) {
    return Note(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      tags: tags ?? this.tags,
    );
  }
}
```

### 4. Data Layer

**Location**: `lib/services/` (future implementation)

**Responsibility**: Handle data persistence and retrieval

**Components**:
- **Repositories**: Abstract data access
- **Local Storage**: SQLite database
- **API Clients**: Backend communication

**Key Principles**:
- Single responsibility
- Dependency injection
- Error handling

## Design Patterns Used

### 1. Provider Pattern (Riverpod)

Manages application state reactively:

```dart
// Simple provider
final currentNoteProvider = StateProvider<Note?>((ref) => null);

// Computed provider
final pinnedNotesProvider = Provider<List<Note>>((ref) {
  final notes = ref.watch(notesProvider);
  return notes.where((n) => n.isPinned).toList();
});

// Stateful provider
final notesProvider = StateNotifierProvider<NotesNotifier, NotesState>((ref) {
  return NotesNotifier();
});
```

### 2. Builder Pattern

Constructs complex objects:

```dart
class NoteBuilder {
  String? _title;
  String? _content;
  List<String> _tags = [];
  
  NoteBuilder setTitle(String title) {
    _title = title;
    return this;
  }
  
  Note build() {
    return Note(
      title: _title ?? '',
      content: _content ?? '',
      tags: _tags,
    );
  }
}
```

### 3. Observer Pattern

Widgets observe state changes:

```dart
ref.watch(notesProvider);  // Rebuilds when notes change
ref.listen(notesProvider, (previous, next) {
  // React to state changes
});
```

### 4. Strategy Pattern

Different sorting/filtering strategies:

```dart
List<Note> _applyFilters(List<Note> notes) {
  // Apply search filter
  // Apply tag filter
  // Apply sorting
  return filtered;
}
```

## Data Flow

### Creating a Note

```
User Input (UI)
    ↓
NoteEditorScreen
    ↓
ref.read(notesProvider.notifier).addNote(note)
    ↓
NotesNotifier.addNote()
    ↓
Update NotesState
    ↓
Rebuild affected widgets
    ↓
Display updated note list
```

### Filtering Notes

```
User selects filter
    ↓
ref.read(notesProvider.notifier).setSelectedTags(tags)
    ↓
NotesNotifier.setSelectedTags()
    ↓
_applyFilters() called
    ↓
filteredNotesProvider updates
    ↓
NoteListScreen rebuilds
    ↓
Display filtered notes
```

## File Organization

```
lib/
├── main.dart                          # App entry point
│
├── models/                            # Domain layer
│   └── note.dart                      # Data models
│
├── providers/                         # State management layer
│   ├── note_provider.dart             # Note state
│   └── theme_provider.dart            # Theme state
│
├── screens/                           # Presentation layer
│   ├── home_screen.dart
│   ├── note_list_screen.dart
│   ├── note_editor_screen.dart
│   ├── search_screen.dart
│   ├── reminders_screen.dart
│   ├── notebooks_screen.dart
│   ├── tags_screen.dart
│   └── settings_screen.dart
│
├── widgets/                           # Reusable UI components
│   ├── note_card.dart
│   ├── rich_text_toolbar.dart
│   ├── filter_and_sort_widget.dart
│   └── app_drawer.dart
│
├── themes/                            # Styling
│   └── app_theme.dart
│
├── utils/                             # Utilities
│   ├── app_constants.dart
│   └── responsive_helper.dart
│
└── l10n/                              # Localization
    └── app_localizations.dart
```

## State Management Strategy

### Global State (Riverpod)

Managed at the app level:
- Notes list
- Theme settings
- Language preference
- Search query

### Local State (StatefulWidget)

Managed within a widget:
- Text field input
- Scroll position
- Temporary UI state

### Ephemeral State

Managed by framework:
- Animation state
- Focus state
- Keyboard visibility

## Error Handling

### User-Facing Errors

```dart
try {
  await saveNote(note);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Note saved successfully')),
  );
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error saving note: $e')),
  );
}
```

### Logging

```dart
import 'dart:developer' as developer;

developer.log('Important event', name: 'app.notes');
```

## Performance Optimization

### Lazy Loading

```dart
// Only load notes when needed
final notesProvider = Provider<List<Note>>((ref) {
  return loadNotesFromDatabase();
});
```

### Memoization

```dart
// Cache computed values
final pinnedNotesProvider = Provider<List<Note>>((ref) {
  final notes = ref.watch(notesProvider);
  return notes.where((n) => n.isPinned).toList();
});
```

### Selective Rebuilds

```dart
// Only rebuild affected widgets
ref.watch(filteredNotesProvider);  // Only rebuilds list
ref.watch(themeProvider);           // Only rebuilds theme
```

## Testing Strategy

### Unit Tests

```dart
test('NotesNotifier adds note', () {
  final notifier = NotesNotifier();
  final note = Note(title: 'Test', content: 'Test content');
  
  notifier.addNote(note);
  
  expect(notifier.state.notes.length, 1);
  expect(notifier.state.notes.first.title, 'Test');
});
```

### Widget Tests

```dart
testWidgets('NoteCard displays note', (WidgetTester tester) async {
  final note = Note(title: 'Test', content: 'Content');
  
  await tester.pumpWidget(
    MaterialApp(home: NoteCard(note: note)),
  );
  
  expect(find.text('Test'), findsOneWidget);
});
```

## Future Improvements

### Backend Integration
- Add repository pattern for data access
- Implement API client
- Add error handling and retry logic

### Advanced State Management
- Implement caching strategies
- Add offline-first synchronization
- Implement conflict resolution

### Performance
- Implement pagination
- Add image caching
- Optimize database queries

### Features
- Add real-time collaboration
- Implement cloud sync
- Add advanced search

## References

- [Flutter Architecture Best Practices](https://flutter.dev/docs/development/best-practices)
- [Riverpod Documentation](https://riverpod.dev/)
- [Clean Architecture in Flutter](https://resocoder.com/flutter-clean-architecture)
- [State Management Guide](https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro)

---

**Well-architected code is maintainable code!** 🏗️
