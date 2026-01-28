import 'package:flutter/material.dart';
import 'package:note_taking_app/l10n/app_localizations.dart';

/// AppDrawer provides a navigation drawer for the application.
class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const AppDrawer({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final localizations = AppLocalizations.of(locale);
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer header
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.note,
                  size: 48,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                Text(
                  'Note Taking App',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Organize your thoughts',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Navigation items
          _DrawerItem(
            icon: Icons.home,
            title: localizations.home,
            isSelected: selectedIndex == 0,
            onTap: () {
              onItemSelected(0);
              Navigator.pop(context);
            },
          ),
          _DrawerItem(
            icon: Icons.note,
            title: localizations.notes,
            isSelected: selectedIndex == 1,
            onTap: () {
              onItemSelected(1);
              Navigator.pop(context);
            },
          ),
          _DrawerItem(
            icon: Icons.folder,
            title: localizations.notebooks,
            isSelected: selectedIndex == 2,
            onTap: () {
              onItemSelected(2);
              Navigator.pop(context);
            },
          ),
          _DrawerItem(
            icon: Icons.label,
            title: localizations.tags,
            isSelected: selectedIndex == 3,
            onTap: () {
              onItemSelected(3);
              Navigator.pop(context);
            },
          ),
          _DrawerItem(
            icon: Icons.notifications,
            title: localizations.reminders,
            isSelected: selectedIndex == 4,
            onTap: () {
              onItemSelected(4);
              Navigator.pop(context);
            },
          ),

          const Divider(),

          _DrawerItem(
            icon: Icons.archive,
            title: localizations.archived,
            isSelected: selectedIndex == 5,
            onTap: () {
              onItemSelected(5);
              Navigator.pop(context);
            },
          ),
          _DrawerItem(
            icon: Icons.favorite,
            title: localizations.favorites,
            isSelected: selectedIndex == 6,
            onTap: () {
              onItemSelected(6);
              Navigator.pop(context);
            },
          ),

          const Divider(),

          _DrawerItem(
            icon: Icons.settings,
            title: localizations.settings,
            isSelected: selectedIndex == 7,
            onTap: () {
              onItemSelected(7);
              Navigator.pop(context);
            },
          ),
          _DrawerItem(
            icon: Icons.info,
            title: localizations.about,
            isSelected: false,
            onTap: () {
              Navigator.pop(context);
              // Show about dialog
            },
          ),
        ],
      ),
    );
  }
}

/// Drawer item widget
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? theme.primaryColor : null,
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: isSelected ? theme.primaryColor : null,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      selected: isSelected,
      selectedTileColor: theme.primaryColor.withOpacity(0.1),
      onTap: onTap,
    );
  }
}
