/// App Constants - Contains all constant values used throughout the application.
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // App Information
  static const String appName = 'Note Taking App';
  static const String appVersion = '1.0.0';
  static const String appAuthor = 'Manus AI';

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double defaultElevation = 2.0;

  // Animation Durations (in milliseconds)
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 400);
  static const Duration longAnimationDuration = Duration(milliseconds: 600);

  // Text Field Constraints
  static const int maxNoteTitleLength = 200;
  static const int maxNoteContentLength = 50000;
  static const int minSearchQueryLength = 1;

  // Note Colors
  static const List<String> noteColors = [
    '#FFFFFF', // White
    '#FFF9C4', // Light Yellow
    '#F8BBD0', // Light Pink
    '#E1BEE7', // Light Purple
    '#C5E1A5', // Light Green
    '#B3E5FC', // Light Blue
    '#FFE0B2', // Light Orange
    '#FFCCBC', // Light Brown
  ];

  // Grid Settings
  static const int notesGridColumnsPhone = 1;
  static const int notesGridColumnsTablet = 2;
  static const int notesGridColumnsLarge = 3;

  // Pagination
  static const int notesPerPage = 20;

  // Search Debounce Duration
  static const Duration searchDebounceDuration = Duration(milliseconds: 500);

  // Default Notebook
  static const String defaultNotebookId = 'default';
  static const String defaultNotebookName = 'My Notes';

  // Reminder Notification IDs
  static const int reminderNotificationId = 1001;

  // Database Constants
  static const String databaseName = 'notes_app.db';
  static const int databaseVersion = 1;

  // Shared Preferences Keys
  static const String themePreferenceKey = 'theme_preference';
  static const String languagePreferenceKey = 'language_preference';
  static const String accentColorPreferenceKey = 'accent_color_preference';
  static const String lastSyncTimeKey = 'last_sync_time';

  // Theme Preferences
  static const String themeLightMode = 'light';
  static const String themeDarkMode = 'dark';
  static const String themeSystemMode = 'system';

  // Language Codes
  static const String languageEnglish = 'en';
  static const String languageArabic = 'ar';

  // Default Language
  static const String defaultLanguage = languageEnglish;

  // Supported Locales
  static const List<String> supportedLanguages = [
    languageEnglish,
    languageArabic,
  ];

  // File Size Limits
  static const int maxImageSizeInBytes = 5 * 1024 * 1024; // 5 MB
  static const int maxFileSizeInBytes = 10 * 1024 * 1024; // 10 MB

  // Supported File Extensions
  static const List<String> supportedImageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp',
  ];

  static const List<String> supportedAudioExtensions = [
    'mp3',
    'wav',
    'aac',
    'm4a',
  ];

  static const List<String> supportedDocumentExtensions = [
    'pdf',
    'doc',
    'docx',
    'txt',
  ];

  // Empty State Messages
  static const String noNotesMessage = 'No notes yet. Create your first note!';
  static const String noSearchResultsMessage = 'No notes found matching your search.';
  static const String noArchivedNotesMessage = 'No archived notes.';
  static const String noFavoriteNotesMessage = 'No favorite notes yet.';

  // Error Messages
  static const String errorLoadingNotes = 'Error loading notes. Please try again.';
  static const String errorSavingNote = 'Error saving note. Please try again.';
  static const String errorDeletingNote = 'Error deleting note. Please try again.';
  static const String errorLoadingImage = 'Error loading image. Please try again.';

  // Success Messages
  static const String noteCreatedSuccess = 'Note created successfully.';
  static const String noteUpdatedSuccess = 'Note updated successfully.';
  static const String noteDeletedSuccess = 'Note deleted successfully.';
  static const String noteArchivedSuccess = 'Note archived successfully.';
  static const String noteRestoredSuccess = 'Note restored successfully.';
  static const String notePinnedSuccess = 'Note pinned successfully.';
  static const String noteUnpinnedSuccess = 'Note unpinned successfully.';

  // Accessibility
  static const String semanticLabelNewNote = 'Create new note';
  static const String semanticLabelDeleteNote = 'Delete note';
  static const String semanticLabelArchiveNote = 'Archive note';
  static const String semanticLabelPinNote = 'Pin note';
  static const String semanticLabelFavoriteNote = 'Add to favorites';
  static const String semanticLabelSearch = 'Search notes';
  static const String semanticLabelSettings = 'Open settings';
  static const String semanticLabelNotebookList = 'List of notebooks';
  static const String semanticLabelTagList = 'List of tags';
}
