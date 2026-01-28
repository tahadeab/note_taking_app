import 'package:flutter/material.dart';
import 'package:note_taking_app/l10n/app_localizations.dart';
import 'package:note_taking_app/utils/responsive_helper.dart';

/// RemindersScreen displays scheduled reminders for notes.
class RemindersScreen extends StatefulWidget {
  const RemindersScreen({Key? key}) : super(key: key);

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
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

    // Sample reminders data
    final reminders = [
      {
        'id': '1',
        'title': 'Review project proposal',
        'noteId': '1',
        'time': DateTime.now().add(const Duration(hours: 2)),
        'isCompleted': false,
      },
      {
        'id': '2',
        'title': 'Follow up with team',
        'noteId': '2',
        'time': DateTime.now().add(const Duration(days: 1)),
        'isCompleted': false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.reminders),
        elevation: 0,
      ),
      body: reminders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    localizations.noReminders,
                    style: theme.textTheme.titleLarge,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(isMobile ? 8 : 12),
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];
                return _ReminderCard(
                  title: reminder['title'] as String,
                  time: reminder['time'] as DateTime,
                  isCompleted: reminder['isCompleted'] as bool,
                  onMarkComplete: () {
                    // Mark reminder as complete
                  },
                  onDelete: () {
                    // Delete reminder
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show add reminder dialog
        },
        tooltip: localizations.newReminder,
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Reminder card widget
class _ReminderCard extends StatelessWidget {
  final String title;
  final DateTime time;
  final bool isCompleted;
  final VoidCallback onMarkComplete;
  final VoidCallback onDelete;

  const _ReminderCard({
    required this.title,
    required this.time,
    required this.isCompleted,
    required this.onMarkComplete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context);
    final localizations = AppLocalizations.of(locale);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Checkbox(
          value: isCompleted,
          onChanged: (_) => onMarkComplete(),
        ),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            decoration: isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          localizations.formatDateTime(time),
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
