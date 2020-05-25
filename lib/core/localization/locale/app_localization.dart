import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/localization/l10n/messages_all.dart';
import 'package:intl/intl.dart';

class AppLocalization {
  static Future<AppLocalization> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization of (BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  String get appTitle {
    return Intl.message(
      'Flutter Architecture',
      name: 'appTitle',
      desc: 'Application Title',
    );
  }
}