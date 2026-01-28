import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/models/note.dart';

/// State class for managing notes list state
class NotesState {
  final List<Note> notes;
  final List<Note> filteredNotes;
  final bool isLoading;
  final String? error;
  final String searchQuery;
  final List<String> selectedTags;
  final String selectedNotebook;
  final String sortBy; // 'newest', 'lastEdited', 'title'

  const NotesState({
    this.notes = const [],
    this.filteredNotes = const [],
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
    this.selectedTags = const [],
    this.selectedNotebook = 'all',
    this.sortBy = 'newest',
  });

  NotesState copyWith({
    List<Note>? notes,
    List<Note>? filteredNotes,
    bool? isLoading,
    String? error,
    String? searchQuery,
    List<String>? selectedTags,
    String? selectedNotebook,
    String? sortBy,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
      filteredNotes: filteredNotes ?? this.filteredNotes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedTags: selectedTags ?? this.selectedTags,
      selectedNotebook: selectedNotebook ?? this.selectedNotebook,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}

/// Notifier class for managing notes state
class NotesNotifier extends StateNotifier<NotesState> {
  NotesNotifier() : super(const NotesState());

  /// Initialize with sample notes
  void initializeSampleNotes() {
    final sampleNotes = [
      Note(
        id: '1',
        title: 'Welcome to Note Taking App',
        content: 'This is your first note. You can edit, delete, or archive it.',
        notebookId: 'default',
        tags: ['welcome', 'tutorial'],
        color: '#FFF9C4',
        isPinned: true,
      ),
      Note(
        id: '2',
        title: 'Rich Text Editing',
        content: 'You can format your notes with bold, italic, underline, and more!',
        notebookId: 'default',
        tags: ['formatting'],
        color: '#F8BBD0',
      ),
      Note(
        id: '3',
        title: 'Organize with Tags',
        content: 'Add tags to your notes for better organization and quick filtering.',
        notebookId: 'default',
        tags: ['organization'],
        color: '#E1BEE7',
      ),
    ];
    state = state.copyWith(notes: sampleNotes, filteredNotes: sampleNotes);
  }

  /// Add a new note
  void addNote(Note note) {
    final updatedNotes = [note, ...state.notes];
    state = state.copyWith(
      notes: updatedNotes,
      filteredNotes: _applyFilters(updatedNotes),
    );
  }

  /// Update an existing note
  void updateNote(Note note) {
    final updatedNotes = state.notes.map((n) => n.id == note.id ? note : n).toList();
    state = state.copyWith(
      notes: updatedNotes,
      filteredNotes: _applyFilters(updatedNotes),
    );
  }

  /// Delete a note
  void deleteNote(String noteId) {
    final updatedNotes = state.notes.where((n) => n.id != noteId).toList();
    state = state.copyWith(
      notes: updatedNotes,
      filteredNotes: _applyFilters(updatedNotes),
    );
  }

  /// Pin/Unpin a note
  void togglePin(String noteId) {
    final updatedNotes = state.notes.map((n) {
      if (n.id == noteId) {
        return n.copyWith(isPinned: !n.isPinned);
      }
      return n;
    }).toList();
    state = state.copyWith(
      notes: updatedNotes,
      filteredNotes: _applyFilters(updatedNotes),
    );
  }

  /// Archive/Unarchive a note
  void toggleArchive(String noteId) {
    final updatedNotes = state.notes.map((n) {
      if (n.id == noteId) {
        return n.copyWith(isArchived: !n.isArchived);
      }
      return n;
    }).toList();
    state = state.copyWith(
      notes: updatedNotes,
      filteredNotes: _applyFilters(updatedNotes),
    );
  }

  /// Add note to favorites
  void toggleFavorite(String noteId) {
    final updatedNotes = state.notes.map((n) {
      if (n.id == noteId) {
        return n.copyWith(isFavorite: !n.isFavorite);
      }
      return n;
    }).toList();
    state = state.copyWith(
      notes: updatedNotes,
      filteredNotes: _applyFilters(updatedNotes),
    );
  }

  /// Update search query and apply filters
  void setSearchQuery(String query) {
    state = state.copyWith(
      searchQuery: query,
      filteredNotes: _applyFilters(state.notes),
    );
  }

  /// Update selected tags and apply filters
  void setSelectedTags(List<String> tags) {
    state = state.copyWith(
      selectedTags: tags,
      filteredNotes: _applyFilters(state.notes),
    );
  }

  /// Update selected notebook and apply filters
  void setSelectedNotebook(String notebookId) {
    state = state.copyWith(
      selectedNotebook: notebookId,
      filteredNotes: _applyFilters(state.notes),
    );
  }

  /// Update sort order
  void setSortBy(String sortBy) {
    state = state.copyWith(
      sortBy: sortBy,
      filteredNotes: _applyFilters(state.notes),
    );
  }

  /// Apply all filters to notes list
  List<Note> _applyFilters(List<Note> notes) {
    var filtered = notes;

    // Filter by search query
    if (state.searchQuery.isNotEmpty) {
      filtered = filtered.where((note) {
        final query = state.searchQuery.toLowerCase();
        return note.title.toLowerCase().contains(query) ||
            note.content.toLowerCase().contains(query);
      }).toList();
    }

    // Filter by selected tags
    if (state.selectedTags.isNotEmpty) {
      filtered = filtered.where((note) {
        return state.selectedTags.any((tag) => note.tags.contains(tag));
      }).toList();
    }

    // Filter by selected notebook
    if (state.selectedNotebook != 'all') {
      filtered = filtered.where((note) => note.notebookId == state.selectedNotebook).toList();
    }

    // Filter out archived notes by default
    filtered = filtered.where((note) => !note.isArchived).toList();

    // Apply sorting
    switch (state.sortBy) {
      case 'lastEdited':
        filtered.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;
      case 'title':
        filtered.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'newest':
      default:
        filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    // Move pinned notes to the top
    final pinnedNotes = filtered.where((n) => n.isPinned).toList();
    final unpinnedNotes = filtered.where((n) => !n.isPinned).toList();
    return [...pinnedNotes, ...unpinnedNotes];
  }

  /// Get notes by notebook
  List<Note> getNotesByNotebook(String notebookId) {
    return state.notes.where((n) => n.notebookId == notebookId && !n.isArchived).toList();
  }

  /// Get pinned notes
  List<Note> getPinnedNotes() {
    return state.notes.where((n) => n.isPinned && !n.isArchived).toList();
  }

  /// Get favorite notes
  List<Note> getFavoriteNotes() {
    return state.notes.where((n) => n.isFavorite && !n.isArchived).toList();
  }

  /// Get archived notes
  List<Note> getArchivedNotes() {
    return state.notes.where((n) => n.isArchived).toList();
  }

  /// Get recent notes
  List<Note> getRecentNotes({int limit = 5}) {
    final recent = state.notes.where((n) => !n.isArchived).toList();
    recent.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return recent.take(limit).toList();
  }

  /// Get all tags from notes
  List<Tag> getAllTags() {
    final tagMap = <String, int>{};
    for (final note in state.notes) {
      for (final tag in note.tags) {
        tagMap[tag] = (tagMap[tag] ?? 0) + 1;
      }
    }
    return tagMap.entries
        .map((e) => Tag(name: e.key, noteCount: e.value))
        .toList();
  }
}

/// Provider for notes state
final notesProvider = StateNotifierProvider<NotesNotifier, NotesState>((ref) {
  final notifier = NotesNotifier();
  notifier.initializeSampleNotes();
  return notifier;
});

/// Provider for filtered notes
final filteredNotesProvider = Provider<List<Note>>((ref) {
  return ref.watch(notesProvider).filteredNotes;
});

/// Provider for pinned notes
final pinnedNotesProvider = Provider<List<Note>>((ref) {
  final notifier = ref.read(notesProvider.notifier);
  return notifier.getPinnedNotes();
});

/// Provider for favorite notes
final favoriteNotesProvider = Provider<List<Note>>((ref) {
  final notifier = ref.read(notesProvider.notifier);
  return notifier.getFavoriteNotes();
});

/// Provider for archived notes
final archivedNotesProvider = Provider<List<Note>>((ref) {
  final notifier = ref.read(notesProvider.notifier);
  return notifier.getArchivedNotes();
});

/// Provider for recent notes
final recentNotesProvider = Provider<List<Note>>((ref) {
  final notifier = ref.read(notesProvider.notifier);
  return notifier.getRecentNotes();
});

/// Provider for all tags
final allTagsProvider = Provider<List<Tag>>((ref) {
  final notifier = ref.read(notesProvider.notifier);
  return notifier.getAllTags();
});

/// Provider for search query
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Provider for selected tags
final selectedTagsProvider = StateProvider<List<String>>((ref) => []);

/// Provider for selected notebook
final selectedNotebookProvider = StateProvider<String>((ref) => 'all');

/// Provider for sort order
final sortByProvider = StateProvider<String>((ref) => 'newest');
