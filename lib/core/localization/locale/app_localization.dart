import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/localization/l10n/messages_all.dart';
import 'package:intl/intl.dart';

class AppLocalization {
  static Future<AppLocalization> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  /// flutter pub run intl_translation:extract_to_arb --output-dir=lib/core/localization/l10n lib/core/localization/locale/app_localization.dart
  /// flutter pub run intl_translation:generate_from_arb --output-dir=lib/core/localization/l10n --no-use-deferred-loading lib/core/localization/l10n/intl_messages.arb lib/core/localization/l10n/intl_en.arb lib/core/localization/l10n/intl_id.arb lib/core/localization/locale/app_localization.dart
  /// 
  /// flutter pub run 
  /// intl_translation:extract_to_arb 
  /// --output-dir=lib/core/localization/l10n 
  /// lib/core/localization/locale/app_localization.dart
  /// 
  /// flutter pub run 
  /// intl_translation:generate_from_arb 
  /// --output-dir=lib/core/localization/l10n 
  /// --no-use-deferred-loading 
  /// lib/core/localization/l10n/intl_messages.arb 
  /// lib/core/localization/l10n/intl_en.arb 
  /// lib/core/localization/l10n/intl_id.arb 
  /// lib/core/localization/locale/app_localization.dart

  String get appTitle {
    return Intl.message(
      'Flutter Architecture',
      name: 'appTitle',
      desc: 'Application Title',
    );
  }

  String widgetCount(int howMany) => Intl.plural(
        howMany,
        zero: 'No widgets',
        one: '$howMany widget',
        other: '$howMany widgets',
        args: [howMany],
        name: 'widgetCount',
        desc: 'Widget counter',
      );
}
