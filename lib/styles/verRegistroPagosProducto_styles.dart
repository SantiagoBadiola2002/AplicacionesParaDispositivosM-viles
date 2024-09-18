import 'package:flutter/material.dart';

class AppStyles {
  // Fondo de pantalla
  static final backgroundImage = AssetImage('lib/images/imagenFondoPantalla.png');

  // Card styling
  static final cardStyle = CardStyle(
    color: Colors.white.withOpacity(0.8), // Fondo blanco con opacidad
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
  );

  // AppBar styling
  static final appBarStyle = AppBarStyle(
    backgroundColor: Colors.teal,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  );
}

// Estilo para el Card
class CardStyle {
  final Color color;
  final EdgeInsetsGeometry margin;

  CardStyle({
    required this.color,
    required this.margin,
  });
}

// Estilo para el AppBar
class AppBarStyle {
  final Color backgroundColor;
  final TextStyle titleTextStyle;

  AppBarStyle({
    required this.backgroundColor,
    required this.titleTextStyle,
  });
}
