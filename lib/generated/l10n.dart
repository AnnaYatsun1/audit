// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Chose...`
  String get chose_picker {
    return Intl.message('Chose...', name: 'chose_picker', desc: '', args: []);
  }

  /// `Edit Product`
  String get edit_product_title {
    return Intl.message(
      'Edit Product',
      name: 'edit_product_title',
      desc: '',
      args: [],
    );
  }

  /// `Pick An Image (Optionaly)`
  String get pickAnImage {
    return Intl.message(
      'Pick An Image (Optionaly)',
      name: 'pickAnImage',
      desc: '',
      args: [],
    );
  }

  /// `Get Startet`
  String get getStartetWelcomeTitle {
    return Intl.message(
      'Get Startet',
      name: 'getStartetWelcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pls enter email`
  String get plsEnterPassword {
    return Intl.message(
      'Pls enter email',
      name: 'plsEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message('Email', name: 'emailLabel', desc: '', args: []);
  }

  /// `Enter Email`
  String get laceholderEnterEmail {
    return Intl.message(
      'Enter Email',
      name: 'laceholderEnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message('Password', name: 'passwordLabel', desc: '', args: []);
  }

  /// `Enter Password`
  String get placeholderEnterPassword {
    return Intl.message(
      'Enter Password',
      name: 'placeholderEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Забили пароль?`
  String get forgotPasswordTitle {
    return Intl.message(
      'Забили пароль?',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Войти`
  String get enterTitleLabel {
    return Intl.message('Войти', name: 'enterTitleLabel', desc: '', args: []);
  }

  /// `I agree to the processing`
  String get agreedamantData {
    return Intl.message(
      'I agree to the processing',
      name: 'agreedamantData',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ukr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
