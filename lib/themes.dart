import 'package:flutter/material.dart';

class ThemesControler {
  static ThemeData lightState() {
    return ThemeData(
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.brown),
        // textTheme: TextTheme(
        //     displayMedium: TextStyle(color: Colors.white),
        //     headlineMedium: TextStyle(color: Colors.white),
        //     caption: TextStyle(color: Colors.grey[500])),
        primaryColor: Colors.brown,
        colorScheme: ColorScheme.light().copyWith(primary: Colors.brown),
        appBarTheme:
            AppBarTheme(centerTitle: false, backgroundColor: Colors.brown),
        // buttonBarTheme: ButtonThemeData()
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                primary: Colors.brown)));
  }

  static ThemeData darkState() {
    return ThemeData.dark().copyWith(
        primaryColor: Colors.grey,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                primary: Colors.grey)));
  }
}
