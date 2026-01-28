import 'package:flutter/material.dart';
import 'package:note_taking_app/l10n/app_localizations.dart';
import 'package:note_taking_app/models/note.dart';
import 'package:note_taking_app/utils/responsive_helper.dart';

/// NotebooksScreen displays all notebooks/folders for organizing notes.
class NotebooksScreen extends StatefulWidget {
  const NotebooksScreen({Key? key}) : super(key: key);

  @override
  State<NotebooksScreen> createState() => _NotebooksScreenState();
}

class _NotebooksScreenState extends State<NotebooksScreen> {
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
    final isMobile = ResponsiveHelper.isMobile(context);

    // Sample notebooks
    final notebooks = [
      Notebook(
        id: 'default',
        name: 'My Notes',
        description: 'Default notebook for all notes',
        color: '#4CAF50',
        noteCount: 5,
      ),
      Notebook(
        id: 'work',
        name: 'Work',
        description: 'Work-related notes and tasks',
        color: '#2196F3',
        noteCount: 12,
      ),
      Notebook(
        id: 'personal',
        name: 'Personal',
        description: 'Personal thoughts and ideas',
        color: '#FF9800',
        noteCount: 8,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.notebooks),
        elevation: 0,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(isMobile ? 8 : 12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ResponsiveHelper.getGridColumns(context),
          childAspectRatio: 1.3,
          crossAxisSpacing: isMobile ? 8 : 12,
          mainAxisSpacing: isMobile ? 8 : 12,
        ),
        itemCount: notebooks.length,
        itemBuilder: (context, index) {
          final notebook = notebooks[index];
          return _NotebookCard(
            notebook: notebook,
            onTap: () {
              // Navigate to notebook notes
            },
            onEdit: () {
              // Edit notebook
            },
            onDelete: () {
              // Delete notebook
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show add notebook dialog
        },
        tooltip: localizations.newNotebook,
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Notebook card widget
class _NotebookCard extends StatelessWidget {
  final Notebook notebook;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _NotebookCard({
    required this.notebook,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = Color(int.parse(notebook.color.replaceFirst('#', '0xff')));

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color.withOpacity(0.1),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Notebook icon
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.folder,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Notebook name
                  Text(
                    notebook.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Note count
                  Text(
                    '${notebook.noteCount} notes',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            // More options button
            Positioned(
              top: 8,
              right: 8,
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      onEdit();
                      break;
                    case 'delete':
                      onDelete();
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined, size: 18),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, size: 18, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
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
}
