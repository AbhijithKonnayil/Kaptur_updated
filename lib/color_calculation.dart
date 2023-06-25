import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class TextStyles {
  static TextTheme generateTextTheme(Color accentColor, Color labelTextColor, {required int theme}) {
    Color titleColor;
    if (theme == 1) {
      titleColor = Colors.white;
    } else {
      titleColor = Colors.black;
    }

    return TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Gloock',
          fontSize: 76,
          color: titleColor,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Gloock',
          fontSize: 56,
          color: titleColor,
        ),
        titleLarge: TextStyle(
          //Use this for titles in the homepage
          fontFamily: 'Inter',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: titleColor,
        ),
        titleMedium: TextStyle(
            //Use this for titles elsewhere
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: titleColor),
        titleSmall: TextStyle(
            //For subtitles if any
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: titleColor),
        labelLarge: TextStyle(
            //Use this for button labels
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: labelTextColor));
  }
}

class AppState extends ChangeNotifier {
  Color accentColor = Color(0xFFD4582F);
  Color labelColor = Color(0xFFE7B9AA);
  Color labelTextColor = Colors.black;
  int appTheme = 1; //1 for dark; 0 for light
  ThemeData _appTheme = ThemeData.light();

  Future<void> loadColorsFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accentColor = Color(prefs.getInt('accentColor') ?? (0xFFD4582F));
    labelColor = Color(prefs.getInt('labelColor') ?? (0xFFE7B9AA));
    labelTextColor = Color(prefs.getInt('labelTextColor') ?? (0xFF000000));
    appTheme = prefs.getInt('appTheme') ?? 0;

    if (appTheme == 1) {
      setDarkTheme();
    } else
      setLightTheme();

    notifyListeners();
  }

  Future<void> saveColorsToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('accentColor', accentColor.value);
    await calculateColors();
    prefs.setInt('labelColor', labelColor.value);
    prefs.setInt('labelTextColor', labelTextColor.value);
    _appTheme = _appTheme.copyWith(textTheme: TextStyles.generateTextTheme(accentColor, labelTextColor, theme: appTheme));
  }

  Future<void> saveThemeToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('appTheme', appTheme);
  }

  Future<void> calculateColors() async {
    double luminance = await calculateLuminance(color: accentColor);

    if (luminance >= 0.5) {
      labelTextColor = Colors.black;
      labelColor = await lightenColor(accentColor, 0.4);
    } else {
      labelTextColor = Colors.white;
      labelColor = await lightenColor(accentColor, 0.6);
    }
    notifyListeners();
  }

  Future<double> calculateLuminance({required Color color}) async {
    final num r = color.red / 255.0;
    final num g = color.green / 255.0;
    final num b = color.blue / 255.0;

    final num rAdjusted = r <= 0.03928 ? r / 12.92 : pow(((r + 0.055) / 1.055), 2.4);
    final num gAdjusted = g <= 0.03928 ? g / 12.92 : pow(((g + 0.055) / 1.055), 2.4);
    final num bAdjusted = b <= 0.03928 ? b / 12.92 : pow(((b + 0.055) / 1.055), 2.4);

    double luminance = 0.2126 * rAdjusted + 0.7152 * gAdjusted + 0.0722 * bAdjusted;
    return (luminance);
  }

  Future<Color> lightenColor(Color color, double lightnessFactor) async {
    int red = (color.red + (255 - color.red) * lightnessFactor).round();
    int green = (color.green + (255 - color.green) * lightnessFactor).round();
    int blue = (color.blue + (255 - color.blue) * lightnessFactor).round();
    return (Color.fromARGB(255, red, green, blue));
  }

  void setLightTheme() {
    appTheme = 0;
    saveThemeToSharedPreferences();
    _appTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        background: Color(0xFFFFFBEB),
      ),
      textTheme: TextStyles.generateTextTheme(accentColor, labelTextColor, theme: 0),
    );
    saveThemeToSharedPreferences();
    notifyListeners();
  }

  void setDarkTheme() {
    appTheme = 1;
    saveThemeToSharedPreferences();
    _appTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        background: const Color(0xFF261C2C),
      ),
      textTheme: TextStyles.generateTextTheme(accentColor, labelTextColor, theme: 1),
    );
    saveThemeToSharedPreferences();
    notifyListeners();
  }

  ThemeData get theme => _appTheme;
}
