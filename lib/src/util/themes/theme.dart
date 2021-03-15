import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.grey[100],
    accentColor: Colors.purple,
    primarySwatch: Colors.deepOrange,
    textTheme: GoogleFonts.sourceSansProTextTheme().copyWith(
      headline6: TextStyle(
        color: Colors.purple,
        fontWeight: FontWeight.w700,
        fontSize: 30,
      ),
      headline5: TextStyle(color: Colors.blueAccent),
      headline4: TextStyle(color: Colors.yellow),
      headline3: TextStyle(color: Colors.pink),
      headline2: TextStyle(color: Colors.green),
      headline1: TextStyle(color: Colors.cyan),
    ),
    cardTheme: CardTheme(
      elevation: 1,
      color: Colors.white,
      margin: EdgeInsets.all(0),
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(0),
        side: BorderSide(color: Colors.white, width: 0),
      ),
    ),
    buttonTheme: ButtonThemeData(
      splashColor: Colors.black,
      textTheme: ButtonTextTheme.primary,
      height: 50,
      padding: EdgeInsets.all(10),
      alignedDropdown: true,
      buttonColor: Colors.purple[700],
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(0),
        side: BorderSide(color: Colors.transparent),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.purple),
      prefixStyle: TextStyle(color: Colors.purple),
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
    hintColor: Colors.purple[500],
    iconTheme: IconThemeData(
      color: Colors.purple[800],
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
      selectedItemColor: Colors.purple[900],
      unselectedItemColor: Colors.black,
      unselectedLabelStyle: TextStyle(color: Colors.purple[900]),
      backgroundColor: Colors.grey[100],
    ),
  );
}
