import 'package:flutter/material.dart';
import 'package:note_taking_app/l10n/app_localizations.dart';

/// FilterAndSortWidget provides UI for filtering and sorting notes.
class FilterAndSortWidget extends StatefulWidget {
  final Function(String) onSortChange;
  final Function(List<String>) onTagsChange;
  final List<String> availableTags;
  final List<String> selectedTags;
  final String currentSort;

  const FilterAndSortWidget({
    Key? key,
    required this.onSortChange,
    required this.onTagsChange,
    required this.availableTags,
    required this.selectedTags,
    required this.currentSort,
  }) : super(key: key);

  @override
  State<FilterAndSortWidget> createState() => _FilterAndSortWidgetState();
}

class _FilterAndSortWidgetState extends State<FilterAndSortWidget> {
  late Locale _locale;
  late List<String> _selectedTags;

  @override
  void initState() {
    super.initState();
    _selectedTags = List.from(widget.selectedTags);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locale = Localizations.localeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(_locale);
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Sort section
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.sortBy,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  _SortChip(
                    label: localizations.newest,
                    isSelected: widget.currentSort == 'newest',
                    onSelected: () => widget.onSortChange('newest'),
                  ),
                  _SortChip(
                    label: localizations.lastEdited,
                    isSelected: widget.currentSort == 'lastEdited',
                    onSelected: () => widget.onSortChange('lastEdited'),
                  ),
                  _SortChip(
                    label: localizations.alphabetical,
                    isSelected: widget.currentSort == 'title',
                    onSelected: () => widget.onSortChange('title'),
                  ),
                ],
              ),
            ],
          ),
        ),

        const Divider(),

        // Tags filter section
        if (widget.availableTags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.selectTags,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.availableTags
                      .map(
                        (tag) => FilterChip(
                          label: Text(tag),
                          selected: _selectedTags.contains(tag),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedTags.add(tag);
                              } else {
                                _selectedTags.remove(tag);
                              }
                            });
                            widget.onTagsChange(_selectedTags);
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),

        // Action buttons
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.clear),
                label: Text(localizations.cancel),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.done),
                label: Text(localizations.done),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Simple sort chip widget
class _SortChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const _SortChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      backgroundColor: Colors.transparent,
      side: BorderSide(
        color: isSelected ? theme.primaryColor : Colors.grey,
        width: isSelected ? 2 : 1,
      ),
    );
  }
}

/// Tag selector widget for selecting multiple tags
class TagSelector extends StatefulWidget {
  final List<String> availableTags;
  final List<String> selectedTags;
  final Function(List<String>) onTagsSelected;

  const TagSelector({
    Key? key,
    required this.availableTags,
    required this.selectedTags,
    required this.onTagsSelected,
  }) : super(key: key);

  @override
  State<TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<TagSelector> {
  late List<String> _selectedTags;

  @override
  void initState() {
    super.initState();
    _selectedTags = List.from(widget.selectedTags);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.availableTags
          .map(
            (tag) => FilterChip(
              label: Text(tag),
              selected: _selectedTags.contains(tag),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedTags.add(tag);
                  } else {
                    _selectedTags.remove(tag);
                  }
                });
                widget.onTagsSelected(_selectedTags);
              },
              backgroundColor: _selectedTags.contains(tag)
                  ? theme.primaryColor.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.1),
            ),
          )
          .toList(),
    );
  }
}
