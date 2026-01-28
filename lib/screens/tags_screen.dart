import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/l10n/app_localizations.dart';
import 'package:note_taking_app/models/note.dart';
import 'package:note_taking_app/providers/note_provider.dart';
import 'package:note_taking_app/utils/responsive_helper.dart';

/// TagsScreen displays all tags and allows filtering by tag.
class TagsScreen extends ConsumerWidget {
  const TagsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context);
    final localizations = AppLocalizations.of(locale);
    final theme = Theme.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    final allTags = ref.watch(allTagsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.tags),
        elevation: 0,
      ),
      body: allTags.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.label_off,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No tags yet',
                    style: theme.textTheme.titleLarge,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(isMobile ? 8 : 12),
              itemCount: allTags.length,
              itemBuilder: (context, index) {
                final tag = allTags[index];
                return _TagListItem(
                  tag: tag,
                  onTap: () {
                    // Filter notes by tag
                    ref.read(notesProvider.notifier).setSelectedTags([tag.name]);
                  },
                  onDelete: () {
                    // Delete tag
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show add tag dialog
        },
        tooltip: localizations.newTag,
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Tag list item widget
class _TagListItem extends StatelessWidget {
  final Tag tag;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _TagListItem({
    required this.tag,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = Color(int.parse(tag.color.replaceFirst('#', '0xff')));

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        title: Text(
          tag.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          '${tag.noteCount} notes',
          style: theme.textTheme.bodySmall,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
