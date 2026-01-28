import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/l10n/app_localizations.dart';
import 'package:note_taking_app/models/note.dart';
import 'package:note_taking_app/providers/note_provider.dart';
import 'package:note_taking_app/utils/responsive_helper.dart';
import 'package:note_taking_app/widgets/note_card.dart';

/// HomeScreen displays recent, pinned, and favorite notes.
/// Provides quick access to create new notes and navigate to other sections.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context);
    final localizations = AppLocalizations.of(locale);
    final theme = Theme.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    final recentNotes = ref.watch(recentNotesProvider);
    final pinnedNotes = ref.watch(pinnedNotesProvider);
    final favoriteNotes = ref.watch(favoriteNotesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.home),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Navigate to search screen
            },
            tooltip: localizations.search,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings screen
            },
            tooltip: localizations.settings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 12 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section
            _WelcomeSection(localizations: localizations),
            const SizedBox(height: 24),

            // Pinned notes section
            if (pinnedNotes.isNotEmpty) ...[
              _SectionHeader(
                title: 'Pinned Notes',
                icon: Icons.push_pin,
              ),
              const SizedBox(height: 12),
              _NotesGrid(
                notes: pinnedNotes,
                ref: ref,
                context: context,
              ),
              const SizedBox(height: 24),
            ],

            // Recent notes section
            if (recentNotes.isNotEmpty) ...[
              _SectionHeader(
                title: localizations.notes,
                icon: Icons.note,
              ),
              const SizedBox(height: 12),
              _NotesGrid(
                notes: recentNotes,
                ref: ref,
                context: context,
              ),
              const SizedBox(height: 24),
            ],

            // Favorite notes section
            if (favoriteNotes.isNotEmpty) ...[
              _SectionHeader(
                title: localizations.favorites,
                icon: Icons.favorite,
              ),
              const SizedBox(height: 12),
              _NotesGrid(
                notes: favoriteNotes,
                ref: ref,
                context: context,
              ),
              const SizedBox(height: 24),
            ],

            // Empty state
            if (recentNotes.isEmpty && pinnedNotes.isEmpty && favoriteNotes.isEmpty)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.note_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      localizations.noNotes,
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      localizations.noNotesMessage,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
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
}

/// Welcome section widget
class _WelcomeSection extends StatelessWidget {
  final AppLocalizations localizations;

  const _WelcomeSection({required this.localizations});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.primaryColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back!',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You have ${5} notes. Keep organizing your thoughts!',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Section header widget
class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, color: theme.primaryColor),
        const SizedBox(width: 8),
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

/// Notes grid widget
class _NotesGrid extends StatelessWidget {
  final List<Note> notes;
  final WidgetRef ref;
  final BuildContext context;

  const _NotesGrid({
    required this.notes,
    required this.ref,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final columns = ResponsiveHelper.getGridColumns(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
  }
}
