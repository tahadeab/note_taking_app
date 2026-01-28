import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/l10n/app_localizations.dart';
import 'package:note_taking_app/providers/theme_provider.dart';
import 'package:note_taking_app/utils/app_constants.dart';

/// SettingsScreen provides options for customizing the app appearance and behavior.
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late Locale _locale;
  late String _selectedLanguage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locale = Localizations.localeOf(context);
    _selectedLanguage = _locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(_locale);
    final theme = Theme.of(context);
    final themeState = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settings),
        elevation: 0,
      ),
      body: ListView(
        children: [
          // Appearance section
          _SettingsSection(
            title: localizations.appearance,
            children: [
              // Theme selection
              _SettingsGroup(
                title: localizations.theme,
                children: [
                  _ThemeOption(
                    title: localizations.lightMode,
                    isSelected: themeState.mode == ThemeMode.light,
                    onTap: () {
                      ref.read(themeProvider.notifier).setThemeMode(ThemeMode.light);
                    },
                  ),
                  _ThemeOption(
                    title: localizations.darkMode,
                    isSelected: themeState.mode == ThemeMode.dark,
                    onTap: () {
                      ref.read(themeProvider.notifier).setThemeMode(ThemeMode.dark);
                    },
                  ),
                  _ThemeOption(
                    title: localizations.systemTheme,
                    isSelected: themeState.mode == ThemeMode.system,
                    onTap: () {
                      ref.read(themeProvider.notifier).useSystemTheme();
                    },
                  ),
                ],
              ),

              // Accent color selection
              _SettingsGroup(
                title: localizations.accentColor,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        Colors.blue,
                        Colors.purple,
                        Colors.pink,
                        Colors.red,
                        Colors.orange,
                        Colors.green,
                        Colors.teal,
                        Colors.indigo,
                      ]
                          .map(
                            (color) => GestureDetector(
                              onTap: () {
                                ref.read(themeProvider.notifier).setAccentColor(color);
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: themeState.accentColor == color
                                        ? Colors.white
                                        : Colors.transparent,
                                    width: 3,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Language section
          _SettingsSection(
            title: localizations.language,
            children: [
              _LanguageOption(
                title: localizations.english,
                code: 'en',
                isSelected: _selectedLanguage == 'en',
                onTap: () {
                  setState(() {
                    _selectedLanguage = 'en';
                  });
                  // Change language
                },
              ),
              _LanguageOption(
                title: localizations.arabic,
                code: 'ar',
                isSelected: _selectedLanguage == 'ar',
                onTap: () {
                  setState(() {
                    _selectedLanguage = 'ar';
                  });
                  // Change language
                },
              ),
            ],
          ),

          // About section
          _SettingsSection(
            title: localizations.about,
            children: [
              _SettingsItem(
                title: localizations.appName,
                subtitle: AppConstants.appVersion,
              ),
              _SettingsItem(
                title: localizations.version,
                subtitle: AppConstants.appVersion,
              ),
              _SettingsButton(
                title: localizations.privacy,
                icon: Icons.privacy_tip_outlined,
                onTap: () {
                  // Open privacy policy
                },
              ),
              _SettingsButton(
                title: localizations.terms,
                icon: Icons.description_outlined,
                onTap: () {
                  // Open terms of use
                },
              ),
              _SettingsButton(
                title: localizations.feedback,
                icon: Icons.feedback_outlined,
                onTap: () {
                  // Send feedback
                },
              ),
            ],
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

/// Settings section widget
class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.primaryColor,
            ),
          ),
        ),
        ...children,
        const Divider(height: 1),
      ],
    );
  }
}

/// Settings group widget
class _SettingsGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsGroup({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ...children,
      ],
    );
  }
}

/// Theme option widget
class _ThemeOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(title),
      trailing: Radio<bool>(
        value: true,
        groupValue: isSelected,
        onChanged: (_) => onTap(),
      ),
      onTap: onTap,
    );
  }
}

/// Language option widget
class _LanguageOption extends StatelessWidget {
  final String title;
  final String code;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.code,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(title),
      trailing: Checkbox(
        value: isSelected,
        onChanged: (_) => onTap(),
      ),
      onTap: onTap,
    );
  }
}

/// Settings item widget
class _SettingsItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SettingsItem({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}

/// Settings button widget
class _SettingsButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _SettingsButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
