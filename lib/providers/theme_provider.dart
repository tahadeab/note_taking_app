import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Enum for theme modes
enum ThemeMode {
  light,
  dark,
  system,
}

/// State class for theme management
class ThemeState {
  final ThemeMode mode;
  final Color accentColor;
  final bool useSystemTheme;

  const ThemeState({
    this.mode = ThemeMode.system,
    this.accentColor = const Color(0xFF6200EE),
    this.useSystemTheme = true,
  });

  ThemeState copyWith({
    ThemeMode? mode,
    Color? accentColor,
    bool? useSystemTheme,
  }) {
    return ThemeState(
      mode: mode ?? this.mode,
      accentColor: accentColor ?? this.accentColor,
      useSystemTheme: useSystemTheme ?? this.useSystemTheme,
    );
  }

  /// Check if dark mode is enabled
  bool isDarkMode(BuildContext context) {
    if (useSystemTheme) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return mode == ThemeMode.dark;
  }
}

/// Notifier class for theme management
class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(const ThemeState());

  /// Toggle between light and dark mode
  void toggleTheme() {
    final newMode = state.mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = state.copyWith(mode: newMode, useSystemTheme: false);
  }

  /// Set theme mode
  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(mode: mode);
  }

  /// Use system theme
  void useSystemTheme() {
    state = state.copyWith(mode: ThemeMode.system, useSystemTheme: true);
  }

  /// Set accent color
  void setAccentColor(Color color) {
    state = state.copyWith(accentColor: color);
  }

  /// Get current theme mode
  ThemeMode getThemeMode() => state.mode;

  /// Check if using system theme
  bool isUsingSystemTheme() => state.useSystemTheme;
}

/// Provider for theme state
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});

/// Provider for checking if dark mode is enabled
final isDarkModeProvider = Provider.family<bool, BuildContext>((ref, context) {
  final themeState = ref.watch(themeProvider);
  return themeState.isDarkMode(context);
});
