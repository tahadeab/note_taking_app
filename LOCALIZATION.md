# Localization & Internationalization Guide

This document provides comprehensive information about the localization and internationalization (i18n) features implemented in the Flutter Note Taking App.

## Overview

The app supports multiple languages with full localization including:
- **Language Support**: English and Arabic
- **RTL Support**: Automatic right-to-left layout for Arabic
- **Date/Time Formatting**: Locale-specific formatting
- **Number Formatting**: Locale-specific number display

## Supported Languages

### English (en)
- Default language
- Left-to-right (LTR) layout
- English date format: "Month Day, Year"
- English time format: "h:mm AM/PM"

### Arabic (ar)
- Full Arabic interface
- Right-to-left (RTL) layout
- Arabic date format: "Day Month Year"
- Arabic time format: "HH:mm"
- All UI elements automatically mirrored

## Implementation Details

### AppLocalizations Class

All localized strings are managed in `lib/l10n/app_localizations.dart`:

```dart
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  bool get isArabic => locale.languageCode == 'ar';
  bool get isRTL => isArabic;

  String get appName => isArabic ? 'تطبيق الملاحظات' : 'Note Taking App';
}
```

### Adding New Strings

To add new localized strings:

```dart
// In AppLocalizations class
String get myNewString => isArabic 
    ? 'النص العربي' 
    : 'English Text';
```

### Using Localizations in Widgets

```dart
@override
void didChangeDependencies() {
  super.didChangeDependencies();
  _locale = Localizations.localeOf(context);
}

@override
Widget build(BuildContext context) {
  final localizations = AppLocalizations.of(_locale);
  
  return Text(localizations.appName);
}
```

## RTL Support

### Automatic RTL Layout

Flutter automatically handles RTL layout when using `Directionality`:

```dart
// Flutter automatically reverses layout for RTL
Row(
  children: [
    Icon(Icons.arrow_forward),  // Automatically mirrored in RTL
    SizedBox(width: 8),
    Text('Next'),
  ],
)
```

### RTL-Aware Widgets

All widgets in the app properly handle RTL:

| Widget | LTR | RTL |
|--------|-----|-----|
| Row | Left to Right | Right to Left |
| Column | Top to Bottom | Top to Bottom |
| Alignment.centerRight | Right | Left |
| Padding | Respected | Respected |
| Icons | Normal | Mirrored |

### Manual RTL Handling

For custom layouts, use `TextDirection`:

```dart
Directionality(
  textDirection: localizations.isRTL 
      ? TextDirection.rtl 
      : TextDirection.ltr,
  child: Row(
    children: [ /* widgets */ ],
  ),
)
```

## Date & Time Formatting

### Locale-Specific Formatting

```dart
String formatDate(DateTime date) {
  final DateFormat formatter = isArabic
      ? DateFormat('d MMMM y', 'ar_SA')
      : DateFormat('MMMM d, y', 'en_US');
  return formatter.format(date);
}

// Output examples:
// English: "November 29, 2025"
// Arabic: "29 نوفمبر 2025"
```

### Time Formatting

```dart
String formatTime(DateTime time) {
  final DateFormat formatter = isArabic
      ? DateFormat('HH:mm', 'ar_SA')
      : DateFormat('h:mm a', 'en_US');
  return formatter.format(time);
}

// Output examples:
// English: "2:30 PM"
// Arabic: "14:30"
```

### Relative Time

```dart
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
  }
  // ... more cases
}
```

## Configuration

### Main App Configuration

```dart
MaterialApp(
  // Localization delegates
  localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  
  // Supported locales
  supportedLocales: const [
    Locale('en'),
    Locale('ar'),
  ],
  
  // Initial locale
  locale: const Locale('en'),
)
```

### Adding New Language

To add a new language (e.g., French):

1. **Update main.dart**:
```dart
supportedLocales: const [
  Locale('en'),
  Locale('ar'),
  Locale('fr'),  // Add French
],
```

2. **Add strings to AppLocalizations**:
```dart
String get appName => isArabic 
    ? 'تطبيق الملاحظات'
    : isFrench
        ? 'Application de Prise de Notes'
        : 'Note Taking App';

bool get isFrench => locale.languageCode == 'fr';
```

3. **Update date/time formatting**:
```dart
String formatDate(DateTime date) {
  final DateFormat formatter = isFrench
      ? DateFormat('d MMMM y', 'fr_FR')
      : isArabic
          ? DateFormat('d MMMM y', 'ar_SA')
          : DateFormat('MMMM d, y', 'en_US');
  return formatter.format(date);
}
```

## Language Switching

### Settings Screen

Users can change language in the Settings screen:

```dart
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
```

### Persisting Language Preference

```dart
// Save to SharedPreferences
final prefs = await SharedPreferences.getInstance();
await prefs.setString('language', 'ar');

// Load on app start
final savedLanguage = prefs.getString('language') ?? 'en';
```

## String Categories

### Navigation Strings
```dart
String get home => isArabic ? 'الرئيسية' : 'Home';
String get notes => isArabic ? 'الملاحظات' : 'Notes';
String get notebooks => isArabic ? 'الدفاتر' : 'Notebooks';
String get tags => isArabic ? 'الوسوم' : 'Tags';
String get reminders => isArabic ? 'التذكيرات' : 'Reminders';
```

### Action Strings
```dart
String get create => isArabic ? 'إنشاء' : 'Create';
String get edit => isArabic ? 'تعديل' : 'Edit';
String get delete => isArabic ? 'حذف' : 'Delete';
String get save => isArabic ? 'حفظ' : 'Save';
String get cancel => isArabic ? 'إلغاء' : 'Cancel';
```

### Note-Related Strings
```dart
String get newNote => isArabic ? 'ملاحظة جديدة' : 'New Note';
String get noteTitle => isArabic ? 'عنوان الملاحظة' : 'Note Title';
String get noteContent => isArabic ? 'محتوى الملاحظة' : 'Note Content';
String get pinNote => isArabic ? 'تثبيت الملاحظة' : 'Pin Note';
String get archiveNote => isArabic ? 'أرشفة الملاحظة' : 'Archive Note';
```

### Formatting Strings
```dart
String get bold => isArabic ? 'غامق' : 'Bold';
String get italic => isArabic ? 'مائل' : 'Italic';
String get underline => isArabic ? 'تسطير' : 'Underline';
String get heading => isArabic ? 'عنوان' : 'Heading';
String get bulletList => isArabic ? 'قائمة نقطية' : 'Bullet List';
```

## Best Practices

### 1. Always Use Localizations
```dart
// ✅ Good
Text(localizations.appName)

// ❌ Bad
Text('Note Taking App')
```

### 2. Handle Plural Forms
```dart
String getNoteCount(int count) {
  if (isArabic) {
    return 'لديك $count ملاحظة';
  } else {
    return 'You have $count note${count == 1 ? '' : 's'}';
  }
}
```

### 3. Use Proper Date Formatting
```dart
// ✅ Good
Text(localizations.formatDate(noteDate))

// ❌ Bad
Text(noteDate.toString())
```

### 4. Respect Text Direction
```dart
// ✅ Good - Flutter handles automatically
Row(children: [Icon(...), Text(...)])

// ❌ Bad - Hardcoded LTR
Align(alignment: Alignment.centerLeft, child: Text(...))
```

### 5. Test Both Languages
- Always test UI with both English and Arabic
- Check RTL layout for proper spacing
- Verify date/time formatting

## Testing Localization

### Manual Testing
1. Change device language to Arabic
2. Verify all UI elements are in Arabic
3. Check RTL layout is correct
4. Test date/time formatting

### Automated Testing
```dart
testWidgets('Arabic localization works', (WidgetTester tester) async {
  await tester.binding.window.physicalSizeTestValue = 
      const Size(800, 600);
  
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('ar'),
      home: const MyApp(),
    ),
  );
  
  expect(find.text('تطبيق الملاحظات'), findsOneWidget);
});
```

## Common Issues & Solutions

### Issue: Text Not Translating
**Solution**: Ensure you're using `AppLocalizations.of(locale)` and that the locale is properly set.

### Issue: RTL Layout Broken
**Solution**: Check that all widgets are using proper `Directionality` and avoid hardcoded alignments.

### Issue: Date Format Incorrect
**Solution**: Verify the locale code matches the system locale (e.g., 'ar_SA' for Arabic Saudi Arabia).

### Issue: Icons Not Mirrored
**Solution**: Flutter automatically mirrors icons in RTL. If not working, use `Semantics(textDirection: ...)`.

## Resources

### Flutter Documentation
- [Internationalization](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
- [Localizations](https://api.flutter.dev/flutter/widgets/Localizations-class.html)
- [intl Package](https://pub.dev/packages/intl)

### Arabic-Specific Resources
- [Arabic Text Rendering](https://flutter.dev/docs/development/ui/advanced/internationalization)
- [RTL Best Practices](https://material.io/design/usability/bidirectionality.html)

---

**Localization makes your app accessible to the world!** 🌍
