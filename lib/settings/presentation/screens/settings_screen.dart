import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
import 'package:app_vendor/core/application/theme_provider.dart';
import 'package:app_vendor/core/constant/theme.dart';
import 'package:app_vendor/core/presentation/components/language_dialog_component.dart';
import 'package:app_vendor/settings/presentation/widgets/settings_card_widget.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Settings'.i18n))),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsCardWidget(
              onTap: () {
                context.push('/profileScreen');
              },
              icon: const Icon(Icons.person_pin_outlined),
              title: "Profile".i18n,
            ),
            // SettingsCardWidget(
            //   onTap: () {
            //     context.push('/categoryScreen');
            //   },
            //   icon: const Icon(Icons.article),
            //   title: "My Category".i18n,
            // ),
            SettingsCardWidget(
              onTap: () {},
              icon: const Icon(Icons.info),
              title: "About".i18n,
            ),
            SettingsCardWidget(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const LanguageDialogComponent(),
                );
              },
              icon: const Icon(FontAwesomeIcons.language),
              title: "Language".i18n,
            ),
            SettingsCardWidget(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Select Theme".i18n),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile<ThemeMode>(
                            title:
                                //Text("Light".i18n),
                                Row(
                                  children: [
                                    Expanded(child: Text("Light".i18n)),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: lightTheme.colorScheme.primary,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            value: ThemeMode.light,
                            groupValue: currentTheme,
                            onChanged: (value) {
                              if (value != null) {
                                ref
                                    .read(themeModeProvider.notifier)
                                    .setThemeMode(value);
                                Navigator.of(
                                  context,
                                ).pop(); // ← يغلق الـ Dialog
                              }
                            },
                          ),
                          RadioListTile<ThemeMode>(
                            title:
                                //  Text("Dark".i18n),
                                Row(
                                  children: [
                                    Expanded(child: Text("Dark".i18n)),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: darkTheme.colorScheme.primary,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            value: ThemeMode.dark,
                            groupValue: currentTheme,
                            onChanged: (value) {
                              if (value != null) {
                                ref
                                    .read(themeModeProvider.notifier)
                                    .setThemeMode(value);
                                Navigator.of(
                                  context,
                                ).pop(); // ← يغلق الـ Dialog
                              }
                            },
                          ),
                          RadioListTile<ThemeMode>(
                            title: Text("System".i18n),
                            value: ThemeMode.system,
                            groupValue: currentTheme,
                            onChanged: (value) {
                              if (value != null) {
                                ref
                                    .read(themeModeProvider.notifier)
                                    .setThemeMode(value);
                                Navigator.of(
                                  context,
                                ).pop(); // ← يغلق الـ Dialog
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.dark_mode),
              title: "Theme".i18n,
            ),
            SettingsCardWidget(
              onTap: () {
                ref.read(authNotifierProvider.notifier).logout();
              },
              icon: const Icon(Icons.logout),
              title: "Logout".i18n,
            ),
          ],
        ),
      ),
    );
  }
}
