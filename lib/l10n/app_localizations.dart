import 'package:flutter/material.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ar.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': appLocalizationsEn,
    'ar': appLocalizationsAr,
  };

  String get title {
    return _localizedValues[locale.languageCode]!['title']!;
  }

  String get theme {
    return _localizedValues[locale.languageCode]!['theme']!;
  }

  String get language {
    return _localizedValues[locale.languageCode]!['language']!;
  }

  String get logout {
    return _localizedValues[locale.languageCode]!['logout']!;
  }

  String get tasks {
    return _localizedValues[locale.languageCode]!['tasks']!;
  }

  String get settings {
    return _localizedValues[locale.languageCode]!['settings']!;
  }

  String get edit {
    return _localizedValues[locale.languageCode]!['edit']!;
  }

  String get deleteTask {
    return _localizedValues[locale.languageCode]!['deleteTask']!;
  }

  String get light {
    return _localizedValues[locale.languageCode]!['light']!;
  }

  String get dark {
    return _localizedValues[locale.languageCode]!['dark']!;
  }

  String get editTask {
    return _localizedValues[locale.languageCode]!['editTask']!;
  }

  String get plzEnterTitle {
    return _localizedValues[locale.languageCode]!['plzEnterTitle']!;
  }

  String get description {
    return _localizedValues[locale.languageCode]!['description']!;
  }

  String get plzEnterDes {
    return _localizedValues[locale.languageCode]!['plzEnterDes']!;
  }

  String get save {
    return _localizedValues[locale.languageCode]!['save']!;
  }

  String get english {
    return _localizedValues[locale.languageCode]!['english']!;
  }

  String get arabicLang {
    return _localizedValues[locale.languageCode]!['arabicLang']!;
  }

  String get fullName {
    return _localizedValues[locale.languageCode]!['fullName']!;
  }

  String get plzFullName {
    return _localizedValues[locale.languageCode]!['plzFullName']!;
  }

  String get userName {
    return _localizedValues[locale.languageCode]!['userName']!;
  }

  String get plzUserName {
    return _localizedValues[locale.languageCode]!['plzUserName']!;
  }

  String get emailAddress {
    return _localizedValues[locale.languageCode]!['emailAddress']!;
  }

  String get plzEmail {
    return _localizedValues[locale.languageCode]!['plzEmail']!;
  }

  String get badFormat {
    return _localizedValues[locale.languageCode]!['badFormat']!;
  }

  String get password {
    return _localizedValues[locale.languageCode]!['password']!;
  }

  String get plzPassword {
    return _localizedValues[locale.languageCode]!['plzPassword']!;
  }

  String get rePassword {
    return _localizedValues[locale.languageCode]!['rePassword']!;
  }

  String get plzRePassword {
    return _localizedValues[locale.languageCode]!['plzRePassword']!;
  }

  String get dontMatch {
    return _localizedValues[locale.languageCode]!['dontMatch']!;
  }

  String get signup {
    return _localizedValues[locale.languageCode]!['signup']!;
  }

  String get haveAccount {
    return _localizedValues[locale.languageCode]!['haveAccount']!;
  }

  String get login {
    return _localizedValues[locale.languageCode]!['login']!;
  }

  String get processing {
    return _localizedValues[locale.languageCode]!['processing']!;
  }

  String get userRegisteredSuccessfully {
    return _localizedValues[locale.languageCode]![
        'user_registered_successfully']!;
  }

  String get ok {
    return _localizedValues[locale.languageCode]!['ok']!;
  }

  String get error {
    return _localizedValues[locale.languageCode]!['error']!;
  }

  String get tryAgain {
    return _localizedValues[locale.languageCode]!['try_again']!;
  }

  String get signIn {
    return _localizedValues[locale.languageCode]!["sign_in"]!;
  }

  String get dontHaveAnAccount {
    return _localizedValues[locale.languageCode]!["dont_have_an_account"]!;
  }

  String get register {
    return _localizedValues[locale.languageCode]!["register"]!;
  }

  String get userLoggedInSuccessfully {
    return _localizedValues[locale.languageCode]![
        "user_logged_in_successfully"]!;
  }

  String get enterUserName {
    return _localizedValues[locale.languageCode]!["enter_user_name"]!;
  }

  String get enterEmailAddress {
    return _localizedValues[locale.languageCode]!["enter_email_address"]!;
  }

  String get enterPassword {
    return _localizedValues[locale.languageCode]!["enter_password"]!;
  }

  String get confirmPassword {
    return _localizedValues[locale.languageCode]!["confirm_password"]!;
  }

  String get weakPassword {
    return _localizedValues[locale.languageCode]!["weak_password"]!;
  }

  String get emailInUse {
    return _localizedValues[locale.languageCode]!["email_in_use"]!;
  }

  String get invalidCredential {
    return _localizedValues[locale.languageCode]!["invalid_credential"]!;
  }

  String get weakPasswordMessage {
    return _localizedValues[locale.languageCode]!["weak_password_message"]!;
  }

  String get emailInUseMessage {
    return _localizedValues[locale.languageCode]!["email_in_use_message"]!;
  }

  String get wrongEmailOrPasswordMessage {
    return _localizedValues[locale.languageCode]![
        "wrong_email_or_password_message"]!;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
