import 'package:flutter/cupertino.dart';
import '../../l10n/app_localizations.dart';

class ConstantManager {
  static String? getFullName(BuildContext context) {
    return AppLocalizations.of(context)?.fullName;
  }

  static String? getUserName(BuildContext context) {
    return AppLocalizations.of(context)?.enterUserName;
  }

  static String? getEmail(BuildContext context) {
    return AppLocalizations.of(context)?.enterUserName;
  }

  static String? getPassword(BuildContext context) {
    return AppLocalizations.of(context)?.enterPassword;
  }

  static String? getPasswordConfirmation(BuildContext context) {
    return AppLocalizations.of(context)?.confirmPassword;
  }

  static String? getWeakPassword(BuildContext context) {
    return AppLocalizations.of(context)?.weakPassword;
  }

  static String? getEmailInUse(BuildContext context) {
    return AppLocalizations.of(context)?.emailInUse;
  }

  static String? getInvalidCredential(BuildContext context) {
    return AppLocalizations.of(context)?.invalidCredential;
  }

  static String? weakPasswordMessage(BuildContext context) {
    return AppLocalizations.of(context)?.weakPasswordMessage;
  }

  static String? emailInUseMessage(BuildContext context) {
    return AppLocalizations.of(context)?.emailInUseMessage;
  }

  static String? wrongEmailOrPasswordMessage(BuildContext context) {
    return AppLocalizations.of(context)?.wrongEmailOrPasswordMessage;
  }
}
