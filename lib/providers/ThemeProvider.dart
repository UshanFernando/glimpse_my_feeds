import 'package:flutter/material.dart';
import 'package:glimpse_my_feeds/service/StorageController.dart';

class ThemeNotifier with ChangeNotifier {
  bool _darkMod = false;
  final darkTheme = ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.grey,
      secondaryHeaderColor: const Color.fromARGB(255, 84, 93, 110),
      brightness: Brightness.dark,
      backgroundColor: const Color.fromARGB(255, 59, 66, 84),
      accentColor: const Color.fromARGB(255, 123, 31, 162),
      accentIconTheme: IconThemeData(color: Color.fromARGB(255, 219, 255, 98)),
      dividerColor: Colors.black12,
      textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white70)));

  final lightTheme = ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.white,
      brightness: Brightness.light,
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      accentColor: Colors.indigoAccent,
      secondaryHeaderColor: Colors.white,
      accentIconTheme: IconThemeData(color: Color.fromARGB(255, 255, 23, 68)),
      dividerColor: const Color.fromARGB(1, 250, 250, 250),
      textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black87)));

  ThemeData _themeData;
  ThemeData get getTheme => _themeData == null ? lightTheme : _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
        _darkMod = false;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
        _darkMod = true;
      }
      notifyListeners();
    });
  }

  void toggleTheme() async {
    if (_darkMod) {
      setLightMode();
    } else {
      setDarkMode();
    }
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    _darkMod = true;
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    _darkMod = false;
    notifyListeners();
  }
}
