import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';

ThemeData themeData = ThemeData.dark().copyWith(
  // dialogBackgroundColor: const Color.fromRGBO(37, 42, 52, 1),
  scaffoldBackgroundColor: const Color.fromRGBO(24, 25, 32, 1),
  primaryColor: const Color(0xFF21212f),
  appBarTheme: const AppBarTheme(
    color: Color.fromRGBO(24, 25, 32, 1),
    shadowColor: Colors.black87, // Change the AppBar color
    elevation: 8,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor:
        Color.fromARGB(255, 114, 122, 226), // Set the desired cursor color
  ),
  inputDecorationTheme: const InputDecorationTheme(
    // labelStyle: TextStyle(
    //   color: Color.fromARGB(
    //       255, 114, 122, 226), // Set the desired label color
    // ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 114, 122, 226),
      ), // Set the desired underline color for active text fields
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: const Color.fromRGBO(
        37, 42, 52, 1), //Color.fromARGB(255, 114, 122, 226),
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(20.0), // Set the desired border radius here
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(
      color: Color(0xFFd988a1),
    ),
    selectedItemColor: Color(0xFFd988a1),
    backgroundColor: Color.fromRGBO(24, 25, 32, 1),
    elevation: 20,
  ),
  cardTheme: CardTheme(
    color: const Color.fromRGBO(37, 42, 52, 1),
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(26),
    ),
  ),
  // textTheme: GoogleFonts.nunitoTextTheme(ThemeData.dark().textTheme),
  iconTheme: const IconThemeData(
    color: Color(0xFFd988a1),
  ),
);

TextStyle titleStyle =
    GoogleFonts.acme(fontSize: 24, fontWeight: FontWeight.w500);

TextStyle bodyStyle = GoogleFonts.exo2(
  textStyle: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  ),
);

TextStyle readingStyle = GoogleFonts.alegreya(fontSize: 18);

LinearGradient savioLinearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xFF50559a).withOpacity(0.7),
      const Color(0xFFd988a1).withOpacity(0.7),
      //50559a
    ]);
