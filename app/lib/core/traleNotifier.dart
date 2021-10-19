import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:trale/core/language.dart';
import 'package:trale/core/preferences.dart';
import 'package:trale/core/theme.dart';
import 'package:trale/core/units.dart';

/// Class to dynamically change themeMode, isAmoled and language within app
class TraleNotifier with ChangeNotifier {
  /// empty constructor, in main.dart load preferences is called first.
  TraleNotifier();

  /// shared preferences instance
  final Preferences prefs = Preferences();
  /// getter
  ThemeMode get themeMode => prefs.nightMode.toThemeMode();
  /// setter
  set themeMode(ThemeMode mode) {
    if (mode != themeMode) {
      prefs.nightMode = mode.toCustomString();
      notifyListeners();
    }
  }
  /// getter
  bool get isAmoled => prefs.isAmoled;
  /// setter
  set isAmoled(bool amoled) {
    if (amoled != isAmoled) {
      prefs.isAmoled = amoled;
      notifyListeners();
    }
  }
  /// getter
  TraleCustomTheme get theme => prefs.theme.toTraleCustomTheme()
    ?? prefs.defaultTheme.toTraleCustomTheme()!;
  /// setter
  set theme(TraleCustomTheme newTheme) {
    if (newTheme != theme) {
      prefs.theme = newTheme.name;
      notifyListeners();
    }
  }

  /// getter
  Language get language => prefs.language;
  /// setter
  set language(Language newLanguage) {
    if (language != newLanguage) {
      prefs.language = newLanguage;
      notifyListeners();
    }
  }

  /// getter
  DateFormat get dateFormat => DateFormat(
    'dd/MM/yyyy',
    locale?.languageCode,
  );

  /// getter
  TraleUnit get unit => prefs.unit;
  /// setter
  set unit(TraleUnit newUnit) {
    if (unit != newUnit) {
      prefs.unit = newUnit;
      notifyListeners();
    }
  }

  /// get locale
  Locale? get locale => language.compareTo(Language.system())
      ? null  // defaults to systems default
      : language.locale;
}