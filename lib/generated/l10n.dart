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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Shop`
  String get ShopAppBar {
    return Intl.message(
      'Shop',
      name: 'ShopAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get CartAppBar {
    return Intl.message(
      'Cart',
      name: 'CartAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get ProfileAppBar {
    return Intl.message(
      'Profile',
      name: 'ProfileAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get SettingsAppBar {
    return Intl.message(
      'Settings',
      name: 'SettingsAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get Search_TextField {
    return Intl.message(
      'Search',
      name: 'Search_TextField',
      desc: '',
      args: [],
    );
  }

  /// `categoryNameEn`
  String get CategoryNameEnAr {
    return Intl.message(
      'categoryNameEn',
      name: 'CategoryNameEnAr',
      desc: '',
      args: [],
    );
  }

  /// `productNameEn`
  String get ProductNameEnAr {
    return Intl.message(
      'productNameEn',
      name: 'ProductNameEnAr',
      desc: '',
      args: [],
    );
  }

  /// `productDescriptionEn`
  String get productDescriptionEnAr {
    return Intl.message(
      'productDescriptionEn',
      name: 'productDescriptionEnAr',
      desc: '',
      args: [],
    );
  }

  /// `Recommedned`
  String get RecommendedProducts_ProductDetailsScreen {
    return Intl.message(
      'Recommedned',
      name: 'RecommendedProducts_ProductDetailsScreen',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get addToCartButton_ProductDetailsScreen {
    return Intl.message(
      'Add to cart',
      name: 'addToCartButton_ProductDetailsScreen',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get ChangeLanguage {
    return Intl.message(
      'Change Language',
      name: 'ChangeLanguage',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
