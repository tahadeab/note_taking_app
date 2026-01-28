import 'package:flutter/material.dart';
import 'package:note_taking_app/models/note.dart';
import 'package:note_taking_app/l10n/app_localizations.dart';

/// NoteCard widget displays a single note in a card format.
/// Shows note title, preview of content, tags, and action buttons.
class NoteCard extends StatefulWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onPin;
  final VoidCallback onArchive;
  final VoidCallback onFavorite;

  const NoteCard({
    Key? key,
    required this.note,
    required this.onTap,
    required this.onDelete,
    required this.onPin,
    required this.onArchive,
    required this.onFavorite,
  }) : super(key: key);

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  late Locale _locale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locale = Localizations.localeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(_locale);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    
    // Parse color from hex string
    final cardColor = Color(int.parse(widget.note.color.replaceFirst('#', '0xff')));

    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color: cardColor,
        elevation: widget.note.isPinned ? 4 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: widget.note.isPinned
              ? BorderSide(color: theme.primaryColor, width: 2)
              : BorderSide.none,
        ),
        child: Stack(
          children: [
            // Main content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.note.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Content preview
                  Text(
                    widget.note.content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),

                  // Tags
                  if (widget.note.tags.isNotEmpty)
                    Wrap(
                      spacing: 4,
                      children: widget.note.tags
                          .take(3)
                          .map(
                            (tag) => Chip(
                              label: Text(
                                tag,
                                style: const TextStyle(fontSize: 11),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              backgroundColor: Colors.grey.withOpacity(0.3),
                            ),
                          )
                          .toList(),
                    ),

                  const SizedBox(height: 12),

                  // Date
                  Text(
                    localizations.formatRelativeTime(widget.note.updatedAt),
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            // Pin indicator
            if (widget.note.isPinned)
              Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.push_pin,
                  color: theme.primaryColor,
                  size: 20,
                ),
              ),

            // Favorite indicator
            if (widget.note.isFavorite)
              Positioned(
                top: 8,
                left: 8,
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 20,
                ),
              ),

            // Action buttons
            Positioned(
              bottom: 8,
              right: 8,
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'delete':
                      _showDeleteConfirmation(context, localizations);
                      break;
                    case 'pin':
                      widget.onPin();
                      break;
                    case 'archive':
                      widget.onArchive();
                      break;
                    case 'favorite':
                      widget.onFavorite();
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'pin',
                    child: Row(
                      children: [
                        Icon(
                          widget.note.isPinned ? Icons.push_pin_outlined : Icons.push_pin,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.note.isPinned
                              ? localizations.unpinNote
                              : localizations.pinNote,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'favorite',
                    child: Row(
                      children: [
                        Icon(
                          widget.note.isFavorite ? Icons.favorite : Icons.favorite_outline,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.note.isFavorite
                              ? localizations.removeFromFavorites
                              : localizations.addToFavorites,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'archive',
                    child: Row(
                      children: [
                        const Icon(Icons.archive_outlined, size: 18),
                        const SizedBox(width: 8),
                        Text(localizations.archiveNote),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                        const SizedBox(width: 8),
                        Text(
                          localizations.deleteNote,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
                icon: const Icon(Icons.more_vert, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show delete confirmation dialog
  void _showDeleteConfirmation(BuildContext context, AppLocalizations localizations) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.deleteNote),
        content: Text(localizations.deleteNoteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localizations.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onDelete();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(localizations.noteDeletedSuccess)),
              );
            },
            child: Text(
              localizations.delete,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

/// NoteListCard widget displays a note in list format (single line).
class NoteListCard extends StatefulWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onPin;

  const NoteListCard({
    Key? key,
    required this.note,
    required this.onTap,
    required this.onDelete,
    required this.onPin,
  }) : super(key: key);

  @override
  State<NoteListCard> createState() => _NoteListCardState();
}

class _NoteListCardState extends State<NoteListCard> {
  late Locale _locale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locale = Localizations.localeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(_locale);
    final theme = Theme.of(context);

    return ListTile(
      onTap: widget.onTap,
      leading: Icon(
        widget.note.isPinned ? Icons.push_pin : Icons.note_outlined,
        color: theme.primaryColor,
      ),
      title: Text(
        widget.note.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.titleMedium,
      ),
      subtitle: Text(
        widget.note.content,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          switch (value) {
            case 'delete':
              widget.onDelete();
              break;
            case 'pin':
              widget.onPin();
              break;
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'pin',
            child: Text(
              widget.note.isPinned
                  ? localizations.unpinNote
                  : localizations.pinNote,
            ),
          ),
          PopupMenuItem<String>(
            value: 'delete',
            child: Text(
              localizations.deleteNote,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
