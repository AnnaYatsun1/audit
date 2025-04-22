import 'package:flutter/material.dart';
import 'package:sound_level_meter/generated/l10n.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('ukr');
  Locale get locale => _locale;

  void changeLanguage(Locale newLocal) {
    if (_locale != newLocal) {
      _locale = newLocal;
      S.load(newLocal);
      notifyListeners();
    }
  }
}
