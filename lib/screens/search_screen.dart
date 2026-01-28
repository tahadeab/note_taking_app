import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/l10n/app_localizations.dart';
import 'package:note_taking_app/providers/note_provider.dart';
import 'package:note_taking_app/utils/responsive_helper.dart';
import 'package:note_taking_app/widgets/note_card.dart';

/// SearchScreen provides a dedicated search interface for finding notes.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late TextEditingController _searchController;
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locale = Localizations.localeOf(context);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(_locale);
    final theme = Theme.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    final filteredNotes = ref.watch(filteredNotesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.search),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search input field
          Padding(
            padding: EdgeInsets.all(isMobile ? 12 : 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: localizations.searchHint,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(notesProvider.notifier).setSearchQuery('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (query) {
                ref.read(notesProvider.notifier).setSearchQuery(query);
                setState(() {});
              },
            ),
          ),

          // Search results
          Expanded(
            child: filteredNotes.isEmpty
                ? Center(
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
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsets.all(isMobile ? 8 : 12),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveHelper.getGridColumns(context),
                      childAspectRatio: 1.2,
                      crossAxisSpacing: isMobile ? 8 : 12,
                      mainAxisSpacing: isMobile ? 8 : 12,
                    ),
                    itemCount: filteredNotes.length,
                    itemBuilder: (context, index) {
                      final note = filteredNotes[index];
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
                  ),
          ),
        ],
      ),
    );
  }
}
