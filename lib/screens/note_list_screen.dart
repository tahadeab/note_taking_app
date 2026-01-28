import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/l10n/app_localizations.dart';
import 'package:note_taking_app/providers/note_provider.dart';
import 'package:note_taking_app/utils/responsive_helper.dart';
import 'package:note_taking_app/widgets/filter_and_sort_widget.dart';
import 'package:note_taking_app/widgets/note_card.dart';

/// NoteListScreen displays all notes with filtering and sorting options.
class NoteListScreen extends ConsumerStatefulWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends ConsumerState<NoteListScreen> {
  late Locale _locale;
  bool _isGridView = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locale = Localizations.localeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(_locale);
    final theme = Theme.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    final filteredNotes = ref.watch(filteredNotesProvider);
    final allTags = ref.watch(allTagsProvider);
    final notesState = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.notes),
        elevation: 0,
        actions: [
          // View toggle button
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
            tooltip: _isGridView ? 'List View' : 'Grid View',
          ),

          // Filter button
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet(context, localizations, allTags);
            },
            tooltip: localizations.filter,
          ),

          // Search button
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _showSearchDialog(context, localizations);
            },
            tooltip: localizations.search,
          ),
        ],
      ),
      body: filteredNotes.isEmpty
          ? _EmptyState(localizations: localizations)
          : _NotesListView(
              notes: filteredNotes,
              isGridView: _isGridView,
              ref: ref,
              context: context,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to note editor
        },
        tooltip: localizations.newNote,
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Show filter bottom sheet
  void _showFilterBottomSheet(
    BuildContext context,
    AppLocalizations localizations,
    List<Tag> allTags,
  ) {
    final notesState = ref.read(notesProvider);
    final tagNames = allTags.map((tag) => tag.name).toList();

    showModalBottomSheet(
      context: context,
      builder: (context) => FilterAndSortWidget(
        onSortChange: (sortBy) {
          ref.read(notesProvider.notifier).setSortBy(sortBy);
        },
        onTagsChange: (tags) {
          ref.read(notesProvider.notifier).setSelectedTags(tags);
        },
        availableTags: tagNames,
        selectedTags: notesState.selectedTags,
        currentSort: notesState.sortBy,
      ),
    );
  }

  /// Show search dialog
  void _showSearchDialog(BuildContext context, AppLocalizations localizations) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.search),
        content: TextField(
          decoration: InputDecoration(
            hintText: localizations.searchHint,
            prefixIcon: const Icon(Icons.search),
          ),
          onChanged: (query) {
            ref.read(notesProvider.notifier).setSearchQuery(query);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localizations.close),
          ),
        ],
      ),
    );
  }
}

/// Empty state widget
class _EmptyState extends StatelessWidget {
  final AppLocalizations localizations;

  const _EmptyState({required this.localizations});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            localizations.noSearchResults,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters or search query',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Notes list/grid view widget
class _NotesListView extends StatelessWidget {
  final List<Note> notes;
  final bool isGridView;
  final WidgetRef ref;
  final BuildContext context;

  const _NotesListView({
    required this.notes,
    required this.isGridView,
    required this.ref,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final columns = ResponsiveHelper.getGridColumns(context);

    if (isGridView) {
      return GridView.builder(
        padding: EdgeInsets.all(isMobile ? 8 : 12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          childAspectRatio: 1.2,
          crossAxisSpacing: isMobile ? 8 : 12,
          mainAxisSpacing: isMobile ? 8 : 12,
        ),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return NoteCard(
            note: note,
            onTap: () {
              // Navigate to note editor
            },
            onDelete: () {
              ref.read(notesProvider.notifier).deleteNote(note.id);
            },
            onPin: () {
              ref.read(notesProvider.notifier).togglePin(note.id);
            },
            onArchive: () {
              ref.read(notesProvider.notifier).toggleArchive(note.id);
            },
            onFavorite: () {
              ref.read(notesProvider.notifier).toggleFavorite(note.id);
            },
          );
        },
      );
    } else {
      return ListView.builder(
        padding: EdgeInsets.all(isMobile ? 8 : 12),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: NoteListCard(
              note: note,
              onTap: () {
                // Navigate to note editor
              },
              onDelete: () {
                ref.read(notesProvider.notifier).deleteNote(note.id);
              },
              onPin: () {
                ref.read(notesProvider.notifier).togglePin(note.id);
              },
            ),
          );
        },
      );
    }
  }
}

import 'package:note_taking_app/models/note.dart';
