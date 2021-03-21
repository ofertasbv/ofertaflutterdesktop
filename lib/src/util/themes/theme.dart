import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getTheme(BuildContext context) {
  return ThemeData(
    tabBarTheme: TabBarTheme(),
    brightness: Brightness.light,
    primaryColor: Colors.white,
    accentColor: Colors.green,
    primarySwatch: Colors.pink,
    textTheme: GoogleFonts.sourceSansProTextTheme().copyWith(
      subtitle2: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      subtitle1: TextStyle(
        color: Colors.green[600],
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      bodyText1: TextStyle(
        color: Colors.green[400],
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      headline6: TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      headline5: TextStyle(color: Colors.blueAccent),
      headline4: TextStyle(color: Colors.yellow),
      headline3: TextStyle(color: Colors.pink),
      headline2: TextStyle(color: Colors.green),
      headline1: TextStyle(color: Colors.cyan),
    ),
    scaffoldBackgroundColor: Colors.grey[100].withOpacity(1),
    cardTheme: CardTheme(
      elevation: 1,
      color: Colors.white,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(0),
        side: BorderSide(color: Colors.white, width: 0),
      ),
    ),
    buttonTheme: ButtonThemeData(
      splashColor: Colors.green,
      textTheme: ButtonTextTheme.primary,
      height: 50,
      padding: EdgeInsets.all(10),
      alignedDropdown: true,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10),
        side: BorderSide(color: Colors.transparent),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.indigo[900]),
      prefixStyle: TextStyle(color: Colors.indigo[900]),
      hintStyle: TextStyle(color: Colors.deepOrange),
      fillColor: Colors.grey[200],
      alignLabelWithHint: true,
      focusColor: Colors.red[900],
      hoverColor: Colors.grey[100],
      suffixStyle: TextStyle(color: Colors.deepOrange),
      errorStyle: TextStyle(color: Colors.red),
      isDense: true,
      filled: true,
    ),
    hintColor: Colors.indigo[900],
    iconTheme: IconThemeData(
      color: Colors.indigo[900],
    ),
    snackBarTheme: SnackBarThemeData(
      actionTextColor: Colors.black,
      backgroundColor: Colors.yellow[900],
    ),
    // scaffoldBackgroundColor: Colors.grey[100],
    bottomSheetTheme: BottomSheetThemeData(
      modalElevation: 1,
      backgroundColor: Colors.yellow[900],
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      selectedItemColor: Colors.indigo[900],
      unselectedItemColor: Colors.black,
      unselectedLabelStyle: TextStyle(color: Colors.indigo[900]),
      backgroundColor: Colors.grey[100],
    ),
  );
}
