import 'package:flutter/material.dart';

class AppColors {
  // Paleta de grises
  static const Color darkGrey = Color(0xFF2D2D2D);
  static const Color mediumGrey = Color(0xFF4A4A4A);
  static const Color grey = Color(0xFF6E6E6E);
  static const Color lightGrey = Color(0xFFB0B0B0);
  static const Color ultraLightGrey = Color(0xFFF2F2F2);
  static const Color backgroundGrey = Color(0xFFEAEAEA); // Nuevo color de fondo
  
  // Acentos
  static const Color primary = Color(0xFF2D2D2D);
  static const Color secondary = Color(0xFF6E6E6E);
  static const Color accent = Color(0xFF4A4A4A);
  
  // Generadores y exploradores
  static const Color generatorPrimary = Color(0xFF3D5A80);
  static const Color generatorSecondary = Color(0xFFE0FBFC);
  static const Color explorerPrimary = Color(0xFF606C38);
  static const Color explorerSecondary = Color(0xFFFEFAE0);
}

class AppStyles {
  static TextStyle get heading1 => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.darkGrey,
    letterSpacing: -0.5,
    height: 1.3,
  );
  
  static TextStyle get heading2 => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.darkGrey,
    letterSpacing: -0.3,
  );
  
  static TextStyle get subtitle => const TextStyle(
    fontSize: 14,
    color: AppColors.grey,
    height: 1.4,
    letterSpacing: 0.1,
  );
  
  static TextStyle get body => const TextStyle(
    fontSize: 14,
    color: AppColors.mediumGrey,
    height: 1.5,
  );
  
  static TextStyle get caption => const TextStyle(
    fontSize: 12,
    color: AppColors.grey,
    letterSpacing: 0.2,
  );
  
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );
  
  static BoxDecoration get searchBarDecoration => BoxDecoration(
    color: AppColors.ultraLightGrey,
    borderRadius: BorderRadius.circular(12),
  );
  
  // Nuevos estilos para la pantalla de detalle
  static BoxDecoration get tagDecoration => BoxDecoration(
    color: AppColors.ultraLightGrey,
    borderRadius: BorderRadius.circular(8),
  );
  
  static TextStyle get tagText => const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.mediumGrey,
  );
  
  static ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: AppColors.darkGrey,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 0,
  );
  
  static ButtonStyle get secondaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: AppColors.darkGrey,
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: AppColors.lightGrey),
    ),
    elevation: 0,
  );
}
