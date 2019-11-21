// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localizations.dart';

// **************************************************************************
// JSONLocalizationGenerator
// **************************************************************************

class AppLocalizations {
  AppLocalizations(this.locale) : this.labels = languages[locale];

  final Locale locale;

  static final Map<Locale, AppLocalizations_Labels> languages = {
    Locale.fromSubtags(languageCode: "de"): AppLocalizations_Labels(
      dates: AppLocalizations_Labels_Dates(
        month: AppLocalizations_Labels_Dates_Month(
          april: "April",
          february: "Februar",
          january: "Januar",
          march: "März",
        ),
        weekday: AppLocalizations_Labels_Dates_Weekday(
          friday: "Freitag",
          monday: "Montag",
          saturday: "Samstag",
          sunday: "Sonntag",
          thursday: "Donnerstag",
          tuesday: "Dienstag",
          wednesday: "Mittwoch",
        ),
      ),
      home: AppLocalizations_Labels_Home(
        chat: "Chats",
        enrollments: "Einschreibungen",
        news: "Nachrichten",
      ),
      login: AppLocalizations_Labels_Login(
        getStarted: "Loslegen",
        signIn: "Einloggen",
      ),
      plurals: AppLocalizations_Labels_Plurals(
        man: (condition) {
          if (condition == Plural.multiple) return "Männer";
          if (condition == Plural.one) return "Mann";
          if (condition == Plural.zero) return "Mann";
          throw Exception();
        },
      ),
      templated: AppLocalizations_Labels_Templated(
        contact: (condition) {
          if (condition == Gender.female) return "Frau {{ `last_name`}}";
          if (condition == Gender.male) return "Herr {{ `last_name`}}";
          throw Exception();
        },
        hello: "Hallo {{ `first_name`}}",
      ),
    ),
    Locale.fromSubtags(languageCode: "fr"): AppLocalizations_Labels(
      dates: AppLocalizations_Labels_Dates(
        month: AppLocalizations_Labels_Dates_Month(
          april: "avril",
          february: "février",
          january: "janvier",
          march: "Mars",
        ),
        weekday: AppLocalizations_Labels_Dates_Weekday(
          friday: "Vendredi",
          monday: "Lundi",
          saturday: "samedi",
          sunday: "dimanche",
          thursday: "Jeudi",
          tuesday: "Mardi",
          wednesday: "Mercredi",
        ),
      ),
      home: AppLocalizations_Labels_Home(
        chat: "chats",
        enrollments: "Les inscriptions",
        news: "Nouvelles",
      ),
      login: AppLocalizations_Labels_Login(
        getStarted: "Commencer",
        signIn: "Se connecter",
      ),
      plurals: AppLocalizations_Labels_Plurals(
        man: (condition) {
          if (condition == Plural.multiple) return "Hommes";
          if (condition == Plural.one) return "homme";
          if (condition == Plural.zero) return "homme";
          throw Exception();
        },
      ),
      templated: AppLocalizations_Labels_Templated(
        contact: (condition) {
          if (condition == Gender.female) return "Mme {{`last_name`}}";
          if (condition == Gender.male) return "M. {{`last_name`}}";
          throw Exception();
        },
        hello: "Bonjour {{`first_name`}}",
      ),
    ),
    Locale.fromSubtags(
        languageCode: "zh",
        scriptCode: "Hans",
        countryCode: "CN"): AppLocalizations_Labels(
      dates: AppLocalizations_Labels_Dates(
        month: AppLocalizations_Labels_Dates_Month(
          april: "四月",
          february: "二月",
          january: "一月",
          march: "游行",
        ),
        weekday: AppLocalizations_Labels_Dates_Weekday(
          friday: "星期五",
          monday: "星期一",
          saturday: "星期六",
          sunday: "星期日",
          thursday: "星期四",
          tuesday: "星期二",
          wednesday: "星期三",
        ),
      ),
      home: AppLocalizations_Labels_Home(
        chat: "聊天",
        enrollments: "扩招",
        news: "新闻",
      ),
      login: AppLocalizations_Labels_Login(
        getStarted: "入门",
        signIn: "登入",
      ),
      plurals: AppLocalizations_Labels_Plurals(
        man: (condition) {
          if (condition == Plural.multiple) return "男人";
          if (condition == Plural.one) return "男人";
          if (condition == Plural.zero) return "男人";
          throw Exception();
        },
      ),
      templated: AppLocalizations_Labels_Templated(
        contact: (condition) {
          if (condition == Gender.female) return "太太{{`last_name`}}";
          if (condition == Gender.male) return "先生{{`last_name`}}";
          throw Exception();
        },
        hello: "您好{{`first_name`}}",
      ),
    ),
    Locale.fromSubtags(languageCode: "en"): AppLocalizations_Labels(
      dates: AppLocalizations_Labels_Dates(
        month: AppLocalizations_Labels_Dates_Month(
          april: "April",
          february: "February",
          january: "January",
          march: "March",
        ),
        weekday: AppLocalizations_Labels_Dates_Weekday(
          friday: "Friday",
          monday: "Monday",
          saturday: "Saturday",
          sunday: "Sunday",
          thursday: "Thursday",
          tuesday: "Tuesday",
          wednesday: "Wednesday",
        ),
      ),
      home: AppLocalizations_Labels_Home(
        chat: "Chats",
        enrollments: "Enrollments",
        news: "News",
      ),
      login: AppLocalizations_Labels_Login(
        getStarted: "Get Started",
        signIn: "Sign In",
      ),
      plurals: AppLocalizations_Labels_Plurals(
        man: (condition) {
          if (condition == Plural.multiple) return "men";
          if (condition == Plural.one) return "man";
          if (condition == Plural.zero) return "man";
          throw Exception();
        },
      ),
      templated: AppLocalizations_Labels_Templated(
        contact: (condition) {
          if (condition == Gender.female) return "Mrs {{`last_name`}}";
          if (condition == Gender.male) return "Mr {{`last_name`}}";
          throw Exception();
        },
        hello: "Hello {{`first_name`}}",
      ),
    ),
  };

  final AppLocalizations_Labels labels;

  static AppLocalizations_Labels of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)?.labels;
}

enum Plural {
  multiple,
  one,
  zero,
}
enum Gender {
  female,
  male,
}

class AppLocalizations_Labels_Dates_Month {
  const AppLocalizations_Labels_Dates_Month(
      {this.april, this.february, this.january, this.march});

  final String april;

  final String february;

  final String january;

  final String march;
}

class AppLocalizations_Labels_Dates_Weekday {
  const AppLocalizations_Labels_Dates_Weekday(
      {this.friday,
      this.monday,
      this.saturday,
      this.sunday,
      this.thursday,
      this.tuesday,
      this.wednesday});

  final String friday;

  final String monday;

  final String saturday;

  final String sunday;

  final String thursday;

  final String tuesday;

  final String wednesday;
}

class AppLocalizations_Labels_Dates {
  const AppLocalizations_Labels_Dates({this.month, this.weekday});

  final AppLocalizations_Labels_Dates_Month month;

  final AppLocalizations_Labels_Dates_Weekday weekday;
}

class AppLocalizations_Labels_Home {
  const AppLocalizations_Labels_Home({this.chat, this.enrollments, this.news});

  final String chat;

  final String enrollments;

  final String news;
}

class AppLocalizations_Labels_Login {
  const AppLocalizations_Labels_Login({this.getStarted, this.signIn});

  final String getStarted;

  final String signIn;
}

typedef String AppLocalizations_Labels_Plurals_man(Plural condition);

class AppLocalizations_Labels_Plurals {
  const AppLocalizations_Labels_Plurals(
      {AppLocalizations_Labels_Plurals_man man})
      : this._man = man;

  final AppLocalizations_Labels_Plurals_man _man;

  String man(Plural condition) => this._man(
        condition,
      );
}

typedef String AppLocalizations_Labels_Templated_contact(Gender condition);

class AppLocalizations_Labels_Templated {
  const AppLocalizations_Labels_Templated(
      {AppLocalizations_Labels_Templated_contact contact, this.hello})
      : this._contact = contact;

  final AppLocalizations_Labels_Templated_contact _contact;

  final String hello;

  String contact(Gender condition) => this._contact(
        condition,
      );
}

class AppLocalizations_Labels {
  const AppLocalizations_Labels(
      {this.dates, this.home, this.login, this.plurals, this.templated});

  final AppLocalizations_Labels_Dates dates;

  final AppLocalizations_Labels_Home home;

  final AppLocalizations_Labels_Login login;

  final AppLocalizations_Labels_Plurals plurals;

  final AppLocalizations_Labels_Templated templated;
}
