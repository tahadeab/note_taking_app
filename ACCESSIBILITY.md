# Accessibility Features Guide

This document outlines all accessibility features implemented in the Flutter Note Taking App to ensure the application is usable by everyone, including people with disabilities.

## Overview

The app is designed with accessibility as a core principle, following WCAG 2.1 guidelines and Flutter best practices for accessible applications.

## Screen Reader Support

### Semantic Widgets
All interactive elements use proper semantic widgets with meaningful labels:

```dart
// Example: Semantic button with label
Semantics(
  label: AppLocalizations.of(locale).createNewNote,
  button: true,
  enabled: true,
  onTap: () { /* action */ },
  child: FloatingActionButton(
    onPressed: () { /* action */ },
    tooltip: AppLocalizations.of(locale).createNewNote,
    child: const Icon(Icons.add),
  ),
)
```

### Tooltip Support
All icon buttons include tooltips that are read by screen readers:

```dart
IconButton(
  icon: const Icon(Icons.search),
  tooltip: localizations.search,  // Read by screen readers
  onPressed: () { /* action */ },
)
```

### Semantic Labels
All interactive elements have semantic labels defined in `AppConstants`:

- `semanticLabelNewNote`: "Create new note"
- `semanticLabelDeleteNote`: "Delete note"
- `semanticLabelArchiveNote`: "Archive note"
- `semanticLabelPinNote`: "Pin note"
- `semanticLabelFavoriteNote`: "Add to favorites"
- `semanticLabelSearch`: "Search notes"
- `semanticLabelSettings`: "Open settings"

## Text & Font Accessibility

### Readable Font Sizes
The app uses responsive font sizes that scale with user preferences:

```dart
// Responsive font sizing
double fontSize = ResponsiveHelper.getResponsiveFontSize(
  context,
  mobileSize: 14,
  tabletSize: 16,
  desktopSize: 18,
);
```

### Font Family
Uses Google Fonts (Roboto and Poppins) which are highly readable:
- **Roboto**: For body text (excellent readability)
- **Poppins**: For headings (modern and clear)

### Line Height & Spacing
Proper line height and spacing for improved readability:
```dart
TextStyle(
  fontSize: 14,
  height: 1.5,  // 150% line height
  letterSpacing: 0.5,
)
```

## Color & Contrast

### High Contrast
The app ensures sufficient color contrast ratios (WCAG AA standard):

| Element | Light Mode | Dark Mode | Contrast Ratio |
|---------|-----------|-----------|-----------------|
| Text on Background | Black on White | White on Dark | 21:1 |
| Primary Button | Purple on White | Light Purple on Dark | 8.5:1 |
| Secondary Text | Gray on White | Light Gray on Dark | 7:1 |

### Color Independence
Information is not conveyed by color alone:
- Status indicators use both color and icons
- Disabled states use both color and reduced opacity
- Links are underlined in addition to being colored

### Dark Mode
High-contrast dark mode available for users with light sensitivity:
- Reduces eye strain in low-light environments
- Uses AMOLED-friendly colors on supported devices

## Navigation & Interaction

### Keyboard Navigation
Full keyboard support for all interactive elements:

```dart
// Keyboard shortcuts
- Tab: Navigate to next element
- Shift+Tab: Navigate to previous element
- Enter/Space: Activate button
- Arrow Keys: Navigate lists and menus
```

### Focus Indicators
Clear visual focus indicators for keyboard navigation:
```dart
OutlinedButton(
  style: OutlinedButton.styleFrom(
    side: BorderSide(
      color: isFocused ? Colors.blue : Colors.grey,
      width: isFocused ? 3 : 1,
    ),
  ),
  child: Text('Button'),
)
```

### Gesture Alternatives
All gestures have keyboard/button alternatives:
- Swipe to delete → Delete button in menu
- Long-press → Context menu
- Double-tap → Edit button

## Right-to-Left (RTL) Support

### Automatic RTL Layout
Full RTL support for Arabic language:

```dart
// Automatic RTL layout for Arabic
Directionality(
  textDirection: localizations.isRTL ? TextDirection.rtl : TextDirection.ltr,
  child: Row(
    children: [ /* widgets */ ],
  ),
)
```

### RTL-Aware Widgets
All widgets properly handle RTL:
- Text direction automatically reversed
- Icons mirrored appropriately
- Padding and margins adjusted
- Navigation drawer on correct side

### Language-Specific Formatting
Dates and times formatted according to locale:

```dart
String formatDate(DateTime date) {
  final DateFormat formatter = isArabic
      ? DateFormat('d MMMM y', 'ar_SA')
      : DateFormat('MMMM d, y', 'en_US');
  return formatter.format(date);
}
```

## Localization

### Supported Languages
- **English**: Full English interface
- **Arabic**: Full Arabic interface with RTL layout

### Localization Implementation
All strings are centralized in `AppLocalizations`:

```dart
String get createNewNote => isArabic 
    ? 'إنشاء ملاحظة جديدة' 
    : 'Create New Note';
```

### Language Switching
Users can change language in settings without restarting the app.

## Motor Accessibility

### Touch Target Size
All interactive elements meet minimum touch target size (48x48 dp):

```dart
// Proper touch target sizing
SizedBox(
  width: 48,
  height: 48,
  child: IconButton(
    icon: const Icon(Icons.add),
    onPressed: () { /* action */ },
  ),
)
```

### Reduced Motion
Respects system reduced motion preferences:

```dart
if (MediaQuery.of(context).disableAnimations) {
  // Use instant transitions instead of animations
} else {
  // Use smooth animations
}
```

### Swipe Alternatives
All swipe gestures have button alternatives in menus.

## Cognitive Accessibility

### Clear Labels
All buttons and fields have clear, descriptive labels:
- ✅ "Delete Note" (clear)
- ❌ "Delete" (ambiguous)

### Consistent Navigation
Consistent navigation patterns throughout the app:
- Bottom navigation for main sections
- Drawer for additional options
- Back button for returning to previous screen

### Error Prevention
Clear error messages and confirmation dialogs:

```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Delete Note?'),
    content: Text('This action cannot be undone.'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Cancel'),
      ),
      TextButton(
        onPressed: () => deleteNote(),
        child: Text('Delete'),
      ),
    ],
  ),
)
```

### Predictable Behavior
- Actions have predictable outcomes
- Navigation is consistent
- No unexpected page changes

## Testing Accessibility

### Screen Reader Testing
Test with TalkBack (Android) or VoiceOver (iOS):

1. **Android**: Settings → Accessibility → TalkBack
2. **iOS**: Settings → Accessibility → VoiceOver

### Manual Testing Checklist
- [ ] All buttons have labels/tooltips
- [ ] Text is readable with system font size increased
- [ ] Dark mode works properly
- [ ] Keyboard navigation works
- [ ] RTL layout works for Arabic
- [ ] Color contrast meets WCAG AA
- [ ] Touch targets are at least 48x48 dp
- [ ] Error messages are clear
- [ ] Focus indicators are visible

### Automated Testing
```bash
flutter test
# Run accessibility tests
flutter test --verbose
```

## Accessibility Resources

### Flutter Documentation
- [Flutter Accessibility](https://flutter.dev/docs/development/accessibility-and-localization/accessibility)
- [Semantics Widget](https://api.flutter.dev/flutter/widgets/Semantics-class.html)

### WCAG Guidelines
- [WCAG 2.1](https://www.w3.org/WAI/WCAG21/quickref/)
- [WCAG 2.1 Level AA](https://www.w3.org/WAI/WCAG21/quickref/?versions=2.1&level=aa)

### Material Design
- [Material Design Accessibility](https://material.io/design/usability/accessibility.html)

## Reporting Accessibility Issues

If you find any accessibility issues, please report them:

1. Describe the issue clearly
2. Include device and OS version
3. Provide steps to reproduce
4. Suggest a solution if possible

## Continuous Improvement

Accessibility is an ongoing process. We regularly:
- Review and update accessibility features
- Test with real users who have disabilities
- Stay updated with Flutter best practices
- Implement new accessibility features

---

**Accessibility is not a feature—it's a fundamental right.** We're committed to making this app usable by everyone.
