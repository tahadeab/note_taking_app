import 'package:intl/intl.dart';

/// AppLocalizations class provides localized strings for the application.
/// Supports English and Arabic languages with RTL support for Arabic.
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  /// Get instance of AppLocalizations
  static AppLocalizations of(Locale locale) {
    return AppLocalizations(locale);
  }

  /// Check if current locale is Arabic
  bool get isArabic => locale.languageCode == 'ar';

  /// Check if current locale is RTL
  bool get isRTL => isArabic;

  // ==================== General Strings ====================
  String get appName => isArabic ? 'تطبيق الملاحظات' : 'Note Taking App';
  String get appVersion => isArabic ? 'الإصدار 1.0.0' : 'Version 1.0.0';

  // ==================== Navigation ====================
  String get home => isArabic ? 'الرئيسية' : 'Home';
  String get notes => isArabic ? 'الملاحظات' : 'Notes';
  String get notebooks => isArabic ? 'الدفاتر' : 'Notebooks';
  String get tags => isArabic ? 'الوسوم' : 'Tags';
  String get reminders => isArabic ? 'التذكيرات' : 'Reminders';
  String get archived => isArabic ? 'المؤرشفة' : 'Archived';
  String get favorites => isArabic ? 'المفضلة' : 'Favorites';
  String get settings => isArabic ? 'الإعدادات' : 'Settings';
  String get search => isArabic ? 'بحث' : 'Search';

  // ==================== Actions ====================
  String get create => isArabic ? 'إنشاء' : 'Create';
  String get edit => isArabic ? 'تعديل' : 'Edit';
  String get delete => isArabic ? 'حذف' : 'Delete';
  String get save => isArabic ? 'حفظ' : 'Save';
  String get cancel => isArabic ? 'إلغاء' : 'Cancel';
  String get confirm => isArabic ? 'تأكيد' : 'Confirm';
  String get close => isArabic ? 'إغلاق' : 'Close';
  String get back => isArabic ? 'رجوع' : 'Back';
  String get next => isArabic ? 'التالي' : 'Next';
  String get previous => isArabic ? 'السابق' : 'Previous';
  String get done => isArabic ? 'تم' : 'Done';
  String get add => isArabic ? 'إضافة' : 'Add';
  String get remove => isArabic ? 'إزالة' : 'Remove';
  String get share => isArabic ? 'مشاركة' : 'Share';
  String get export => isArabic ? 'تصدير' : 'Export';
  String get import => isArabic ? 'استيراد' : 'Import';

  // ==================== Note Related ====================
  String get newNote => isArabic ? 'ملاحظة جديدة' : 'New Note';
  String get noteTitle => isArabic ? 'عنوان الملاحظة' : 'Note Title';
  String get noteContent => isArabic ? 'محتوى الملاحظة' : 'Note Content';
  String get addTitle => isArabic ? 'أضف عنواناً' : 'Add a title';
  String get addContent => isArabic ? 'ابدأ الكتابة...' : 'Start typing...';
  String get pinNote => isArabic ? 'تثبيت الملاحظة' : 'Pin Note';
  String get unpinNote => isArabic ? 'إلغاء تثبيت الملاحظة' : 'Unpin Note';
  String get archiveNote => isArabic ? 'أرشفة الملاحظة' : 'Archive Note';
  String get restoreNote => isArabic ? 'استعادة الملاحظة' : 'Restore Note';
  String get deleteNote => isArabic ? 'حذف الملاحظة' : 'Delete Note';
  String get addToFavorites => isArabic ? 'إضافة إلى المفضلة' : 'Add to Favorites';
  String get removeFromFavorites => isArabic ? 'إزالة من المفضلة' : 'Remove from Favorites';
  String get deleteNoteConfirm => isArabic 
      ? 'هل أنت متأكد من رغبتك في حذف هذه الملاحظة؟' 
      : 'Are you sure you want to delete this note?';

  // ==================== Formatting ====================
  String get bold => isArabic ? 'غامق' : 'Bold';
  String get italic => isArabic ? 'مائل' : 'Italic';
  String get underline => isArabic ? 'تسطير' : 'Underline';
  String get strikethrough => isArabic ? 'شطب' : 'Strikethrough';
  String get heading => isArabic ? 'عنوان' : 'Heading';
  String get bulletList => isArabic ? 'قائمة نقطية' : 'Bullet List';
  String get numberedList => isArabic ? 'قائمة مرقمة' : 'Numbered List';
  String get blockquote => isArabic ? 'اقتباس' : 'Blockquote';
  String get codeBlock => isArabic ? 'كود' : 'Code Block';
  String get inlineCode => isArabic ? 'كود مضمن' : 'Inline Code';
  String get link => isArabic ? 'رابط' : 'Link';
  String get image => isArabic ? 'صورة' : 'Image';
  String get color => isArabic ? 'لون' : 'Color';
  String get textColor => isArabic ? 'لون النص' : 'Text Color';
  String get backgroundColor => isArabic ? 'لون الخلفية' : 'Background Color';
  String get undo => isArabic ? 'تراجع' : 'Undo';
  String get redo => isArabic ? 'إعادة' : 'Redo';

  // ==================== Attachments ====================
  String get attachments => isArabic ? 'المرفقات' : 'Attachments';
  String get addAttachment => isArabic ? 'إضافة مرفق' : 'Add Attachment';
  String get addImage => isArabic ? 'إضافة صورة' : 'Add Image';
  String get addAudio => isArabic ? 'إضافة صوت' : 'Add Audio';
  String get addFile => isArabic ? 'إضافة ملف' : 'Add File';
  String get camera => isArabic ? 'الكاميرا' : 'Camera';
  String get gallery => isArabic ? 'المعرض' : 'Gallery';
  String get file => isArabic ? 'ملف' : 'File';
  String get audio => isArabic ? 'صوت' : 'Audio';

  // ==================== Notebooks ====================
  String get newNotebook => isArabic ? 'دفتر جديد' : 'New Notebook';
  String get notebookName => isArabic ? 'اسم الدفتر' : 'Notebook Name';
  String get notebookDescription => isArabic ? 'وصف الدفتر' : 'Notebook Description';
  String get deleteNotebook => isArabic ? 'حذف الدفتر' : 'Delete Notebook';
  String get deleteNotebookConfirm => isArabic 
      ? 'هل أنت متأكد من رغبتك في حذف هذا الدفتر؟' 
      : 'Are you sure you want to delete this notebook?';

  // ==================== Tags ====================
  String get newTag => isArabic ? 'وسم جديد' : 'New Tag';
  String get tagName => isArabic ? 'اسم الوسم' : 'Tag Name';
  String get addTag => isArabic ? 'إضافة وسم' : 'Add Tag';
  String get removeTag => isArabic ? 'إزالة وسم' : 'Remove Tag';
  String get deleteTag => isArabic ? 'حذف الوسم' : 'Delete Tag';
  String get selectTags => isArabic ? 'اختر الوسوم' : 'Select Tags';

  // ==================== Reminders ====================
  String get newReminder => isArabic ? 'تذكير جديد' : 'New Reminder';
  String get reminderTitle => isArabic ? 'عنوان التذكير' : 'Reminder Title';
  String get reminderTime => isArabic ? 'وقت التذكير' : 'Reminder Time';
  String get reminderDate => isArabic ? 'تاريخ التذكير' : 'Reminder Date';
  String get setReminder => isArabic ? 'تعيين تذكير' : 'Set Reminder';
  String get deleteReminder => isArabic ? 'حذف التذكير' : 'Delete Reminder';
  String get noReminders => isArabic ? 'لا توجد تذكيرات' : 'No Reminders';

  // ==================== Filters & Search ====================
  String get filter => isArabic ? 'تصفية' : 'Filter';
  String get sort => isArabic ? 'ترتيب' : 'Sort';
  String get sortBy => isArabic ? 'ترتيب حسب' : 'Sort By';
  String get newest => isArabic ? 'الأحدث' : 'Newest';
  String get oldest => isArabic ? 'الأقدم' : 'Oldest';
  String get lastEdited => isArabic ? 'آخر تعديل' : 'Last Edited';
  String get alphabetical => isArabic ? 'أبجدي' : 'Alphabetical';
  String get searchNotes => isArabic ? 'ابحث عن الملاحظات' : 'Search Notes';
  String get noSearchResults => isArabic ? 'لا توجد نتائج بحث' : 'No Search Results';
  String get searchHint => isArabic ? 'ابحث عن ملاحظة...' : 'Search for a note...';

  // ==================== Empty States ====================
  String get noNotes => isArabic ? 'لا توجد ملاحظات' : 'No Notes';
  String get noNotesMessage => isArabic 
      ? 'ابدأ بإنشاء ملاحظتك الأولى!' 
      : 'Start by creating your first note!';
  String get noArchivedNotes => isArabic ? 'لا توجد ملاحظات مؤرشفة' : 'No Archived Notes';
  String get noFavoriteNotes => isArabic ? 'لا توجد ملاحظات مفضلة' : 'No Favorite Notes';
  String get noPinnedNotes => isArabic ? 'لا توجد ملاحظات مثبتة' : 'No Pinned Notes';

  // ==================== Settings ====================
  String get appearance => isArabic ? 'المظهر' : 'Appearance';
  String get theme => isArabic ? 'المظهر' : 'Theme';
  String get lightMode => isArabic ? 'الوضع الفاتح' : 'Light Mode';
  String get darkMode => isArabic ? 'الوضع الداكن' : 'Dark Mode';
  String get systemTheme => isArabic ? 'موضوع النظام' : 'System Theme';
  String get language => isArabic ? 'اللغة' : 'Language';
  String get english => isArabic ? 'الإنجليزية' : 'English';
  String get arabic => isArabic ? 'العربية' : 'Arabic';
  String get accentColor => isArabic ? 'لون التمييز' : 'Accent Color';
  String get fontSize => isArabic ? 'حجم الخط' : 'Font Size';
  String get small => isArabic ? 'صغير' : 'Small';
  String get medium => isArabic ? 'متوسط' : 'Medium';
  String get large => isArabic ? 'كبير' : 'Large';
  String get about => isArabic ? 'حول التطبيق' : 'About';
  String get version => isArabic ? 'الإصدار' : 'Version';
  String get privacy => isArabic ? 'سياسة الخصوصية' : 'Privacy Policy';
  String get terms => isArabic ? 'شروط الاستخدام' : 'Terms of Use';
  String get feedback => isArabic ? 'إرسال ملاحظات' : 'Send Feedback';

  // ==================== Messages ====================
  String get success => isArabic ? 'نجح' : 'Success';
  String get error => isArabic ? 'خطأ' : 'Error';
  String get warning => isArabic ? 'تحذير' : 'Warning';
  String get info => isArabic ? 'معلومة' : 'Information';
  String get loading => isArabic ? 'جاري التحميل...' : 'Loading...';
  String get retry => isArabic ? 'إعادة محاولة' : 'Retry';
  String get tryAgain => isArabic ? 'حاول مرة أخرى' : 'Try Again';
  String get somethingWentWrong => isArabic ? 'حدث خطأ ما' : 'Something went wrong';
  String get networkError => isArabic ? 'خطأ في الاتصال' : 'Network Error';
  String get serverError => isArabic ? 'خطأ في الخادم' : 'Server Error';

  // ==================== Date & Time ====================
  String get today => isArabic ? 'اليوم' : 'Today';
  String get yesterday => isArabic ? 'أمس' : 'Yesterday';
  String get tomorrow => isArabic ? 'غداً' : 'Tomorrow';
  String get thisWeek => isArabic ? 'هذا الأسبوع' : 'This Week';
  String get thisMonth => isArabic ? 'هذا الشهر' : 'This Month';
  String get thisYear => isArabic ? 'هذا العام' : 'This Year';
  String get older => isArabic ? 'أقدم' : 'Older';

  // ==================== Accessibility ====================
  String get createNewNote => isArabic ? 'إنشاء ملاحظة جديدة' : 'Create New Note';
  String get openMenu => isArabic ? 'فتح القائمة' : 'Open Menu';
  String get closeMenu => isArabic ? 'إغلاق القائمة' : 'Close Menu';
  String get openDrawer => isArabic ? 'فتح الدرج' : 'Open Drawer';
  String get closeDrawer => isArabic ? 'إغلاق الدرج' : 'Close Drawer';
  String get doubleClickToEdit => isArabic ? 'انقر مرتين للتعديل' : 'Double-click to edit';
  String get swipeToDelete => isArabic ? 'اسحب لحذف' : 'Swipe to delete';
  String get swipeToArchive => isArabic ? 'اسحب للأرشفة' : 'Swipe to archive';

  // ==================== Format Date & Time ====================
  String formatDate(DateTime date) {
    final DateFormat formatter = isArabic
        ? DateFormat('d MMMM y', 'ar_SA')
        : DateFormat('MMMM d, y', 'en_US');
    return formatter.format(date);
  }

  String formatTime(DateTime time) {
    final DateFormat formatter = isArabic
        ? DateFormat('HH:mm', 'ar_SA')
        : DateFormat('h:mm a', 'en_US');
    return formatter.format(time);
  }

  String formatDateTime(DateTime dateTime) {
    return '${formatDate(dateTime)} ${formatTime(dateTime)}';
  }

  String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return isArabic ? 'الآن' : 'Just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return isArabic 
          ? 'قبل $minutes دقيقة' 
          : '$minutes minute${minutes > 1 ? 's' : ''} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return isArabic 
          ? 'قبل $hours ساعة' 
          : '$hours hour${hours > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return isArabic 
          ? 'قبل $days يوم' 
          : '$days day${days > 1 ? 's' : ''} ago';
    } else {
      return formatDate(dateTime);
    }
  }
}
