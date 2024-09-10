import 'package:flutter/material.dart';

class MenuClienteStyles {
  // Colores
  static const Color appBarColor = Colors.teal;
  static const Color buttonColor = Color(0xFF1E293B);
  static const Color textColor = Colors.white;
  static const Color backgroundGradientStart = Color(0xFF318C7A);
  static const Color backgroundGradientEnd = Color(0xFF1E293B);

  // Gradientes
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundGradientStart, backgroundGradientEnd],
  );

  // Textos
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    color: textColor,
  );

  // Botones
  static final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    foregroundColor: textColor,
    backgroundColor: buttonColor,
    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  // Imágenes
  static const String placeholderImage = 'assets/placeholder.png';
}
