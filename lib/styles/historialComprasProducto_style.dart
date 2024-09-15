import 'package:flutter/material.dart';

class AppStyles {
  static const Color appBarColor = Color(0xFF318C7A);

  static const Gradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF318C7A), Color(0xFF1E293B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const EdgeInsets listPadding = EdgeInsets.all(16);
  static const EdgeInsets cardMargin = EdgeInsets.symmetric(vertical: 8);

  // Usar variables no constantes para colores con opacidad
  static final Color cardColor = Colors.white.withOpacity(0.7);
  static final Color headerColor = Colors.white.withOpacity(0.1);
  static final Color bodyColor = Colors.white.withOpacity(0.1);

  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtotalTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );
}
