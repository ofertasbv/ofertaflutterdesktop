import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getTheme(BuildContext context) {
  return ThemeData(
    tabBarTheme: TabBarTheme(),
    brightness: Brightness.light,
    primaryColor: Colors.deepPurple[600],
    accentColor: Colors.deepOrangeAccent[400],
    primarySwatch: Colors.deepOrange,
    textTheme: GoogleFonts.sourceSansProTextTheme().copyWith(
      subtitle2: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      subtitle1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      bodyText1: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      headline6: TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      headline5: TextStyle(color: Colors.blueAccent),
      headline4: TextStyle(color: Colors.yellow),
      headline3: TextStyle(color: Colors.pink),
      headline2: TextStyle(color: Colors.green),
      headline1: TextStyle(color: Colors.cyan),
    ),
    scaffoldBackgroundColor: Colors.grey[100],
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
        borderRadius: new BorderRadius.circular(0),
        side: BorderSide(color: Colors.transparent),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(color: Colors.transparent, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(color: Colors.transparent, width: 2),
      ),
      labelStyle: TextStyle(color: Colors.grey[600]),
      prefixStyle: TextStyle(color: Colors.grey[600]),
      hintStyle: TextStyle(color: Colors.deepOrange),
      fillColor: Colors.grey[300],
      focusColor: Colors.red[900],
      hoverColor: Colors.grey[100],
      suffixStyle: TextStyle(color: Colors.deepOrange),
      errorStyle: TextStyle(color: Colors.red),
      isDense: false,
      contentPadding: EdgeInsets.all(18),
    ),
    hintColor: Colors.grey[900],
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
      selectedItemColor: Colors.grey[900],
      unselectedItemColor: Colors.black,
      unselectedLabelStyle: TextStyle(color: Colors.grey[900]),
      backgroundColor: Colors.grey[100],
    ),
  );
}
