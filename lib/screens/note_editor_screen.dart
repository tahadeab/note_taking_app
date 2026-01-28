import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/l10n/app_localizations.dart';
import 'package:note_taking_app/models/note.dart';
import 'package:note_taking_app/providers/note_provider.dart';
import 'package:note_taking_app/utils/responsive_helper.dart';
import 'package:note_taking_app/widgets/rich_text_toolbar.dart';

/// NoteEditorScreen provides a rich text editor for creating and editing notes.
class NoteEditorScreen extends ConsumerStatefulWidget {
  final Note? note;

  const NoteEditorScreen({Key? key, this.note}) : super(key: key);

  @override
  ConsumerState<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends ConsumerState<NoteEditorScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late Locale _locale;
  bool _isAutoSaving = false;
  List<String> _selectedTags = [];
  String _selectedColor = '#FFFFFF';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
    _selectedTags = widget.note?.tags ?? [];
    _selectedColor = widget.note?.color ?? '#FFFFFF';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locale = Localizations.localeOf(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(_locale);
    final theme = Theme.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? localizations.newNote : localizations.edit),
        elevation: 0,
        actions: [
          // Autosave indicator
          if (_isAutoSaving)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
                  ),
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  'Saved',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.green,
                  ),
                ),
              ),
            ),

          // More options
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'delete':
                  _showDeleteConfirmation(context, localizations);
                  break;
                case 'share':
                  // Share note
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'share',
                child: Row(
                  children: [
                    const Icon(Icons.share, size: 18),
                    const SizedBox(width: 8),
                    Text(localizations.share),
                  ],
                ),
              ),
              if (widget.note != null)
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
          ),
        ],
      ),
      body: Column(
        children: [
          // Rich text toolbar
          RichTextToolbar(
            onFormatApply: (format) {
              // Apply text formatting
            },
            onUndo: () {
              // Undo action
            },
            onRedo: () {
              // Redo action
            },
            onAddImage: () {
              // Add image
            },
            onAddLink: () {
              // Add link
            },
            onColorChange: (color) {
              // Change text color
            },
          ),

          // Divider
          const Divider(height: 1),

          // Editor content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isMobile ? 12 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title field
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Note Title',
                      border: InputBorder.none,
                      hintStyle: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: null,
                    onChanged: (_) => _autoSave(),
                  ),

                  const SizedBox(height: 16),

                  // Content field
                  TextField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      hintText: localizations.addContent,
                      border: InputBorder.none,
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                    style: theme.textTheme.bodyMedium,
                    maxLines: null,
                    onChanged: (_) => _autoSave(),
                  ),

                  const SizedBox(height: 24),

                  // Tags section
                  if (_selectedTags.isNotEmpty) ...[
                    Text(
                      localizations.tags,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: _selectedTags
                          .map(
                            (tag) => Chip(
                              label: Text(tag),
                              onDeleted: () {
                                setState(() {
                                  _selectedTags.remove(tag);
                                });
                                _autoSave();
                              },
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Add tag button
                  OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    label: Text(localizations.addTag),
                    onPressed: () {
                      _showTagDialog(context, localizations);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Auto-save note
  void _autoSave() {
    setState(() {
      _isAutoSaving = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      final note = Note(
        id: widget.note?.id,
        title: _titleController.text,
        content: _contentController.text,
        tags: _selectedTags,
        color: _selectedColor,
      );

      if (widget.note == null) {
        ref.read(notesProvider.notifier).addNote(note);
      } else {
        ref.read(notesProvider.notifier).updateNote(note);
      }

      if (mounted) {
        setState(() {
          _isAutoSaving = false;
        });
      }
    });
  }

  /// Show tag selection dialog
  void _showTagDialog(BuildContext context, AppLocalizations localizations) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.addTag),
        content: TextField(
          decoration: InputDecoration(
            hintText: localizations.tagName,
            prefixIcon: const Icon(Icons.label),
          ),
          onSubmitted: (tag) {
            if (tag.isNotEmpty) {
              setState(() {
                _selectedTags.add(tag);
              });
              Navigator.pop(context);
              _autoSave();
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localizations.cancel),
          ),
        ],
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
              if (widget.note != null) {
                ref.read(notesProvider.notifier).deleteNote(widget.note!.id);
              }
              Navigator.pop(context);
              Navigator.pop(context);
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
