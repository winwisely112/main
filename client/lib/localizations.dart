import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';

part 'localizations.g.dart';

// https://docs.google.com/spreadsheets/d/16eeYgh8dus50fISokKK8TMVWLR8A18Er-p5dBcO0FYw/edit#gid=0
@SheetLocalization('16eeYgh8dus50fISokKK8TMVWLR8A18Er-p5dBcO0FYw', '0')
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

/// So this will be a call to the go sheet tool?
/// If so, how do I call the go function from here? I should I not worry about that?
/// Load the base (machine) file then rewrite the values with the human file? Can we not do that on the back end? and make up the files as is?
/// Do we want the {{name}} style functionality? to specify other values
///
/// Configure the generator to generate the localizations.g.dart file from json files such as using build_runner?
