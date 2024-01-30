import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade200,
    fontFamily: 'MontReg',
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    colorScheme: colorScheme(),
    elevatedButtonTheme: elevatedButtonTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    centerTitle: true,
    backgroundColor: Colors.black87,
    elevation: 0,
  );
}

ColorScheme colorScheme() {
  return ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey).copyWith(
    primary: Colors.black,
    secondary: Colors.teal,
    tertiary: Colors.white,
  );
}

ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 4,
      backgroundColor: Colors.teal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    // header text theme
    headline1: TextStyle(
      fontFamily: 'MontBold',
      color: Colors.black,
      fontSize: 26,
    ),
    headline2: TextStyle(
      fontFamily: 'MontBold',
      color: Colors.black,
      fontSize: 20,
    ),
    headline3: TextStyle(
      fontFamily: 'MontBold',
      color: Colors.black,
      fontSize: 18,
    ),
    headline4: TextStyle(
      fontFamily: 'MontReg',
      color: Colors.black,
      fontSize: 16,
    ),
    headline5: TextStyle(
      fontFamily: 'MontReg',
      color: Colors.black,
      fontSize: 14,
    ),
    headline6: TextStyle(
      fontFamily: 'MontReg',
      color: Colors.black54,
      fontSize: 12,
    ),

    // body text theme
    bodyText1: TextStyle(
      fontFamily: 'MontReg',
      color: Colors.black87,
      fontSize: 14,
    ),
    bodyText2: TextStyle(
      fontFamily: 'MontReg',
      color: Colors.black87,
      fontSize: 12,
    ),
  );
}
