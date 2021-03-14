import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.grey[300],
    accentColor: Colors.purple,
    primarySwatch: Colors.deepOrange,
    textTheme: GoogleFonts.sourceSansProTextTheme().copyWith(
      headline1: TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        fontSize: 16,
        color: Color(0xFF86848C),
      ),
      bodyText2: TextStyle(
        fontSize: 14,
      ),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      color: Colors.transparent,
      margin: EdgeInsets.all(0),
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey[100], width: 1),
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
    scaffoldBackgroundColor: Colors.grey[100],
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
