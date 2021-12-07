import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final light = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green[800],
  backgroundColor: Colors.grey[200],
  buttonTheme: ButtonThemeData(
      buttonColor: Colors.green[400], 
      shape: RoundedRectangleBorder()
  ),
  fontFamily: GoogleFonts.roboto().fontFamily,
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    headline3: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    headline4: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    headline5: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
    headline6: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic),
    bodyText1: TextStyle(fontSize: 14.0),
    bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
    caption: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),

  )
);

/// In the future this could be derived from user preferences
final current = light;