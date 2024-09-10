import 'package:flutter/material.dart';

class Styles {
  // Decoración de fondo
  static const BoxDecoration backgroundDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF318C7A), Color(0xFF1E293B)],
    ),
  );

  // Padding
  static const EdgeInsets padding16 = EdgeInsets.all(16.0);

  // Iconos
  static const Icon menuIcon = Icon(Icons.menu, color: Colors.white);
  static const Icon profileIcon = Icon(Icons.person, color: Colors.white);

  // Color del cuadrado girado
  static const Color squareColor = Colors.orange;

  // Ángulo de rotación en radianes
  static const double rotationAngle = 45 * 3.14159 / 180;

  // Estilo de texto del título
  static const TextStyle titleTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  // Estilo de texto del subtítulo
  static const TextStyle subtitleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  // Estilo del botón
  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.orange,
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  );

  // Estilo de texto del botón
  static const TextStyle buttonTextStyle = TextStyle(fontSize: 18);
}
