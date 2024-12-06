import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notes_app_exam_tk2/services/shared_preferences.dart';

enum ChoosenTheme { light, dark }

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, this.changeTheme});

  final Function(Brightness brightness)? changeTheme;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ChoosenTheme? selectedTheme;

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (Theme.of(context).brightness == Brightness.dark) {
        selectedTheme = ChoosenTheme.dark;
      } else {
        selectedTheme = ChoosenTheme.light;
      }
    });
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 26, right: 24),
                child: buildHeaderWidget(context),
              ),
              buildCardWidget(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'App Theme',
                    style: TextStyle(fontFamily: 'ZillaSlab', fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      ChoosenTheme light = ChoosenTheme.light;
                      handleThemeSelection(light);
                    },
                    child: Row(
                      children: <Widget>[
                        Radio<ChoosenTheme>(
                          value: ChoosenTheme.light,
                          groupValue: selectedTheme,
                          onChanged: (ChoosenTheme? value) {
                            if (value != null) {
                              handleThemeSelection(value);
                            }
                          },
                        ),
                        const Text(
                          'Light theme',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ChoosenTheme dark = ChoosenTheme.dark;
                      handleThemeSelection(dark);
                    },
                    child: Row(
                      children: <Widget>[
                        Radio<ChoosenTheme>(
                          value: ChoosenTheme.dark,
                          groupValue: selectedTheme,
                          onChanged: (ChoosenTheme? value) {
                            if (value != null) {
                              log(value.toString());
                              handleThemeSelection(value);
                            }
                          },
                        ),
                        const Text(
                          'Dark theme',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              buildCardWidget(Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('About app',
                      style: TextStyle(
                          fontFamily: 'ZillaSlab',
                          fontSize: 24,
                          color: Theme.of(context).primaryColor)),
                  Container(
                    height: 40,
                  ),
                  Center(
                    child: Text('Developed by'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1)),
                  ),
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Text(
                      'Team Kelompok 4\nSoftware Engineering',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'ZillaSlab', fontSize: 24),
                    ),
                  )),
                  Container(
                    height: 20,
                  ),
                  Center(
                    child: Text('IDEA CREATOR'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1)),
                  ),
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Text(
                      'FARROS KASHIKOI MURTADHO',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'ZillaSlab', fontSize: 24),
                    ),
                  )),
                  Container(
                    height: 20,
                  ),
                  Center(
                    child: Text('UI/UX'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1)),
                  ),
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Text(
                      'IMELDA MAHENDRO PUTRI',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'ZillaSlab', fontSize: 24),
                    ),
                  )),
                  Container(
                    height: 20,
                  ),
                  Center(
                    child: Text('SYSTEM ANALYZE'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1)),
                  ),
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Text(
                      'DIAN KARTIKO WICAKSONO',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'ZillaSlab', fontSize: 24),
                    ),
                  )),
                  Container(
                    height: 20,
                  ),
                  Center(
                    child: Text('CODE DEVELOP'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1)),
                  ),
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Text(
                      'AKHMAD FAIDZAL IBRAHIM',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'ZillaSlab', fontSize: 24),
                    ),
                  )),
                  Container(
                    height: 20,
                  ),
                  Center(
                    child: Text('QA & QC'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1)),
                  ),
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Text(
                      'RIZALDI SAKIM SUHADI',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'ZillaSlab', fontSize: 24),
                    ),
                  )),
                  Container(
                    alignment: Alignment.center,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.link),
                      label: Text('GITHUB',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                              color: Colors.grey.shade500)),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: openGitHub,
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                  Center(
                    child: Text('Made With'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1)),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlutterLogo(
                            size: 40,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Flutter',
                              style: TextStyle(
                                  fontFamily: 'ZillaSlab', fontSize: 24),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCardWidget(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 8),
            color: Colors.black.withAlpha(20),
            blurRadius: 16,
          ),
        ],
      ),
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }

  Widget buildHeaderWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 16, left: 8),
      child: Text(
        'Settings',
        style: TextStyle(
          fontFamily: 'ZillaSlab',
          fontWeight: FontWeight.w700,
          fontSize: 36,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  void openGitHub() {
    // launch('https://www.github.com/roshanrahman');
  }

  void handleThemeSelection(ChoosenTheme value) {
    setState(() {
      selectedTheme = value;
      log(selectedTheme.toString());
    });

    String themeValue = value == ChoosenTheme.light ? "light" : "dark";
    Brightness brightness =
        value == ChoosenTheme.light ? Brightness.light : Brightness.dark;

    widget.changeTheme?.call(brightness);
    setThemeinSharedPref(themeValue);
  }
}
