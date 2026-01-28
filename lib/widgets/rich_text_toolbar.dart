import 'package:flutter/material.dart';
import 'package:note_taking_app/l10n/app_localizations.dart';

/// RichTextToolbar provides formatting options for text editing.
/// Includes bold, italic, underline, lists, and other text formatting tools.
class RichTextToolbar extends StatefulWidget {
  final Function(String) onFormatApply;
  final VoidCallback onUndo;
  final VoidCallback onRedo;
  final VoidCallback onAddImage;
  final VoidCallback onAddLink;
  final Function(Color) onColorChange;

  const RichTextToolbar({
    Key? key,
    required this.onFormatApply,
    required this.onUndo,
    required this.onRedo,
    required this.onAddImage,
    required this.onAddLink,
    required this.onColorChange,
  }) : super(key: key);

  @override
  State<RichTextToolbar> createState() => _RichTextToolbarState();
}

class _RichTextToolbarState extends State<RichTextToolbar> {
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

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            // Bold button
            _ToolbarButton(
              icon: Icons.format_bold,
              tooltip: localizations.bold,
              onPressed: () => widget.onFormatApply('bold'),
            ),

            // Italic button
            _ToolbarButton(
              icon: Icons.format_italic,
              tooltip: localizations.italic,
              onPressed: () => widget.onFormatApply('italic'),
            ),

            // Underline button
            _ToolbarButton(
              icon: Icons.format_underlined,
              tooltip: localizations.underline,
              onPressed: () => widget.onFormatApply('underline'),
            ),

            // Strikethrough button
            _ToolbarButton(
              icon: Icons.strikethrough_s,
              tooltip: localizations.strikethrough,
              onPressed: () => widget.onFormatApply('strikethrough'),
            ),

            const SizedBox(width: 8),
            const VerticalDivider(width: 1),
            const SizedBox(width: 8),

            // Heading button
            _ToolbarButton(
              icon: Icons.title,
              tooltip: localizations.heading,
              onPressed: () => widget.onFormatApply('heading'),
            ),

            // Bullet list button
            _ToolbarButton(
              icon: Icons.format_list_bulleted,
              tooltip: localizations.bulletList,
              onPressed: () => widget.onFormatApply('bulletList'),
            ),

            // Numbered list button
            _ToolbarButton(
              icon: Icons.format_list_numbered,
              tooltip: localizations.numberedList,
              onPressed: () => widget.onFormatApply('numberedList'),
            ),

            // Blockquote button
            _ToolbarButton(
              icon: Icons.format_quote,
              tooltip: localizations.blockquote,
              onPressed: () => widget.onFormatApply('blockquote'),
            ),

            // Code block button
            _ToolbarButton(
              icon: Icons.code,
              tooltip: localizations.codeBlock,
              onPressed: () => widget.onFormatApply('codeBlock'),
            ),

            const SizedBox(width: 8),
            const VerticalDivider(width: 1),
            const SizedBox(width: 8),

            // Link button
            _ToolbarButton(
              icon: Icons.link,
              tooltip: localizations.link,
              onPressed: widget.onAddLink,
            ),

            // Image button
            _ToolbarButton(
              icon: Icons.image,
              tooltip: localizations.image,
              onPressed: widget.onAddImage,
            ),

            // Color picker button
            _ColorPickerButton(
              tooltip: localizations.color,
              onColorSelected: widget.onColorChange,
            ),

            const SizedBox(width: 8),
            const VerticalDivider(width: 1),
            const SizedBox(width: 8),

            // Undo button
            _ToolbarButton(
              icon: Icons.undo,
              tooltip: localizations.undo,
              onPressed: widget.onUndo,
            ),

            // Redo button
            _ToolbarButton(
              icon: Icons.redo,
              tooltip: localizations.redo,
              onPressed: widget.onRedo,
            ),
          ],
        ),
      ),
    );
  }
}

/// Simple toolbar button widget
class _ToolbarButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool isSelected;

  const _ToolbarButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: isSelected ? theme.primaryColor : null,
        tooltip: tooltip,
        constraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
      ),
    );
  }
}

/// Color picker button for selecting text color
class _ColorPickerButton extends StatefulWidget {
  final String tooltip;
  final Function(Color) onColorSelected;

  const _ColorPickerButton({
    required this.tooltip,
    required this.onColorSelected,
  });

  @override
  State<_ColorPickerButton> createState() => _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<_ColorPickerButton> {
  final List<Color> _colors = [
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: PopupMenuButton<Color>(
        onSelected: widget.onColorSelected,
        itemBuilder: (BuildContext context) => _colors
            .map(
              (color) => PopupMenuItem<Color>(
                value: color,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey),
                  ),
                ),
              ),
            )
            .toList(),
        icon: const Icon(Icons.palette),
        tooltip: widget.tooltip,
      ),
    );
  }
}
