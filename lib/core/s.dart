import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final localeProvider = StateProvider<Locale>((ref) {
  final systemLocale = Platform.localeName.substring(0, 2);
  return S.supportedLocales.firstWhere(
    (element) => element.languageCode == systemLocale,
    orElse: () => S.supportedLocales.first,
  );
});

class S {
  static const en = Locale('en');
  static const ru = Locale('ru');

  static const supportedLocales = [ru, en];

  static LocalizationsDelegate<AppLocalizations> get delegate =>
      AppLocalizations.delegate;

  static AppLocalizations of(BuildContext context) =>
      AppLocalizations.of(context)!;

  const S._();
}

class StaticS {
  static late AppLocalizations _loc;

  static AppLocalizations get loc => StaticS._loc;

  static void init(BuildContext context) => _loc = S.of(context);
}
