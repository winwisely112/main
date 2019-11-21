import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:com.winwisely99.app/localizations/flutter_json_localization.dart';

part 'localizations.g.dart';

@JSONLocalization('assets/localizations/')
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.languages.containsKey(locale);
  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
