import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_generator/material_color_generator.dart';

ThemeData themeData = ThemeData(
    useMaterial3: true,
    primarySwatch: generateMaterialColor(color: const Color(0xFF466571)),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF466571),
      onPrimary: Color(0xFF00BC0D),
      secondary: Color(0xFFFF7C18),
      onSecondary: Color(0xFF0069D2),
      error: Colors.red,
      onError: Color(0xFFF60000),
      background: Colors.white,
      onBackground: Color(0xFFF2F2F2),
      surface: Colors.white,
      onSurface: Colors.white,
      tertiary: Color(0xFF404040),
      onTertiary: Color(0xFFB8B8B8),
      tertiaryContainer: Color(0xFF656565),
    ),
    scaffoldBackgroundColor: const Color(0xFFF6F6F6),
    textTheme: GoogleFonts.ubuntuTextTheme());
