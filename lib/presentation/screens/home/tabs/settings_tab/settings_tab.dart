import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/utils/routes_manager.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/colors_manager.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../my_app.dart';

typedef OnChanged = void Function(String? newValue);

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String selectedTheme = 'Light';
  String selectedLang = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.theme,
            style: LightAppStyle.settingsTabLabel,
          ),
          const SizedBox(
            height: 4,
          ),
          buildSettingsTabComponent(
            context,
            AppLocalizations.of(context)!.light,
            AppLocalizations.of(context)!.dark,
            selectedTheme,
            (newTheme) {
              selectedTheme = newTheme ?? selectedTheme;
              setState(() {});
            },
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            AppLocalizations.of(context)!.language,
            style: LightAppStyle.settingsTabLabel,
          ),
          const SizedBox(
            height: 4,
          ),
          buildSettingsTabComponent(
            context,
            AppLocalizations.of(context)!.english,
            AppLocalizations.of(context)!.arabicLang,
            selectedLang,
            (newLang) {
              selectedLang = newLang ?? selectedLang;
              setState(
                () {
                  Provider.of<LocaleProvider>(context, listen: false).setLocale(
                      Locale(selectedLang == 'English' ? 'en' : 'ar'));
                },
              );
            },
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            AppLocalizations.of(context)!.logout,
            style: LightAppStyle.settingsTabLabel,
          ),
          const SizedBox(
            height: 4,
          ),
          buildLogoutButton(),
        ],
      ),
    );
  }

  Widget buildSettingsTabComponent(BuildContext context, String item1,
      String item2, String textView, OnChanged onChanged) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        border: Border.all(width: 1, color: ColorsManager.blue),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(textView, style: LightAppStyle.selectedItemLabel),
          DropdownButton<String>(
            underline: const SizedBox(),
            borderRadius: BorderRadius.circular(12),
            items: <String>[item1, item2].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget buildLogoutButton() {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        border: Border.all(width: 1, color: ColorsManager.blue),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppLocalizations.of(context)!.logout,
              style: LightAppStyle.selectedItemLabel),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                if (mounted) {
                  Navigator.of(context)
                      .pushReplacementNamed(RoutesManager.login);
                }
              } catch (v) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!.tryAgain,
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

class MenuItem {
  String item1;
  String item2;

  MenuItem({required this.item1, required this.item2});
}
