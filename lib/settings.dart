import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'color_calculation.dart';
import 'navigation_bar.dart';
import 'sreen_constants.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<int> loadSelectedColorIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('selectedColorIndex') ?? 0;
  }

  Future<void> saveSelectedColorIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedColorIndex', index);
  }

  @override
  void initState() {
    super.initState();
    loadSelectedColorIndex().then((index) {
      setState(() {
        selectedColorIndex = index;
      });
    });
  }

  List<Color> accentColors = [
    Color(0xffd4572e),
    Color(0xffcba1d2),
    Color(0xffc6638f),
    Color(0xff988b34),
    Color(0xffffc785)
  ];

  int selectedColorIndex = 0;
  Widget buildColorCircle(Color color, int index, AppState appState) {
    bool isSelected = index == selectedColorIndex;

    return Container(
        width: 50 / 360 * ScreenConstants.screenWidth,
        height: 50 / 360 * ScreenConstants.screenWidth,
        decoration: BoxDecoration(shape: BoxShape.circle, color: null, border: isSelected ? Border.all(color: appState.accentColor, width: 4, strokeAlign: BorderSide.strokeAlignOutside) : null),
        child: Material(
          shape: const CircleBorder(),
          child: InkWell(
            splashColor: appState.labelColor,
            customBorder: const CircleBorder(),
            onTap: () {
              setState(() {
                selectedColorIndex = index;
                saveSelectedColorIndex(index);
                appState.accentColor = accentColors[index];
                appState.saveColorsToSharedPreferences();
              });
            },
            child: Align(
              alignment: Alignment.center,
              child: Ink(
                width: 36 / 360 * ScreenConstants.screenWidth,
                height: 36 / 360 * ScreenConstants.screenWidth,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
            ),
          ),
        ));
  }

  void changeColor(Color color) => setState(() => accentColors[selectedColorIndex] = color);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    Color currentColor = appState.accentColor;
    return Scaffold(
        bottomNavigationBar: BottomNavBar(
          index: 0,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 75 / 360 * ScreenConstants.screenWidth),
                child: Text(
                  'Settings.',
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(24 / 360 * ScreenConstants.screenWidth, 95 / 360 * ScreenConstants.screenWidth, 0, 0),
                child: Text(
                  'Accent Color',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Container(
                width: double.infinity,
                height: 50 / 360 * ScreenConstants.screenWidth,
                margin: EdgeInsets.only(top: 10 / 360 * ScreenConstants.screenWidth, left: 10 / 360 * ScreenConstants.screenWidth, right: 24 / 360 * ScreenConstants.screenWidth),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < accentColors.length; i++) buildColorCircle(accentColors[i], i, appState),
                      Material(
                        shape: const CircleBorder(),
                        child: Ink(
                          width: 50 / 360 * ScreenConstants.screenWidth,
                          height: 50 / 360 * ScreenConstants.screenWidth,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: appState.labelColor,
                          ),
                          child: InkWell(
                            splashColor: appState.accentColor,
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ColorPicker(pickerColor: currentColor, onColorChanged: changeColor);
                                  });
                            },
                            customBorder: const CircleBorder(),
                            child: Icon(
                              Icons.add,
                              color: appState.labelTextColor,
                              weight: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(24 / 360 * ScreenConstants.screenWidth, 10 / 360 * ScreenConstants.screenWidth, 0, 0),
                child: Text(
                  'App Theme',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 24 / 360 * ScreenConstants.screenWidth, top: 20 / 360 * ScreenConstants.screenWidth),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: InkWell(
                            onTap: () {
                              appState.setLightTheme();
                            },
                            customBorder: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Ink(
                              width: 110 / 360 * ScreenConstants.screenWidth,
                              height: 153 / 360 * ScreenConstants.screenWidth,
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage('assets/icons/light.png')),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  border: appState.appTheme == 0
                                      ? Border.all(
                                          color: appState.accentColor,
                                          width: 5 / 360 * ScreenConstants.screenWidth,
                                          strokeAlign: BorderSide.strokeAlignInside,
                                        )
                                      : null),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Light",
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                      children: [
                        Material(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: InkWell(
                            onTap: () {
                              appState.setDarkTheme();
                            },
                            customBorder: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Ink(
                              width: 110 / 360 * ScreenConstants.screenWidth,
                              height: 153 / 360 * ScreenConstants.screenWidth,
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage('assets/icons/dark.png')),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  border: appState.appTheme == 1
                                      ? Border.all(
                                          color: appState.accentColor,
                                          width: 5 / 360 * ScreenConstants.screenWidth,
                                          strokeAlign: BorderSide.strokeAlignInside,
                                        )
                                      : null),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Dark",
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
