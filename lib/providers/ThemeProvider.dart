import 'package:flutter/material.dart';
import 'package:glimpse_my_feeds/service/StorageController.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.grey,
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFF212121),
      accentColor: Colors.white,
      accentIconTheme: IconThemeData(color: Colors.black),
      dividerColor: Colors.black12,
      textTheme: TextTheme(
          title: TextStyle(color: Colors.white),
          subtitle: TextStyle(color: Colors.white70)));

  final lightTheme = ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.white,
      brightness: Brightness.light,
      backgroundColor: Colors.white70,
      accentColor: Colors.indigoAccent,
      accentIconTheme: IconThemeData(color: Colors.white),
      dividerColor: Color.fromARGB(1, 250, 250, 250),
      textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black87)));
  bool _darkMod;

  ThemeData _themeData;
  ThemeData get getTheme => _themeData == null ? lightTheme : _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
