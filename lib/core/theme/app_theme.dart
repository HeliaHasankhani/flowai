
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6C63FF),
      brightness: Brightness.light,
    ),

    scaffoldBackgroundColor: const Color(0xFFF7F7FC),

    // ----------------------------------------------------------
    // Typography
    // ----------------------------------------------------------

    textTheme: GoogleFonts.interTextTheme(),

    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFFF7F7FC),
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF17171C),
      ),
    ),

    // ----------------------------------------------------------
    // Cards
    // ----------------------------------------------------------

    cardTheme: const CardThemeData(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
    ),

    // ----------------------------------------------------------
    // Text fields
    // ----------------------------------------------------------

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,

      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        borderSide: BorderSide.none,
      ),

      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        borderSide: BorderSide(
          color: const Color(0xFF6C63FF),
          width: 1.5,
        ),
      ),

      labelStyle: GoogleFonts.inter(
        fontSize: 14,
      ),

      hintStyle: GoogleFonts.inter(
        fontSize: 14,
        color: Colors.grey,
      ),
    ),

    // ----------------------------------------------------------
    // Buttons
    // ----------------------------------------------------------

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        textStyle: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 20,
        ),
      ),
    ),

    // ----------------------------------------------------------
    // Floating Action Button
    // ----------------------------------------------------------

    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(
      shape: CircleBorder(),
    ),
  );
}
