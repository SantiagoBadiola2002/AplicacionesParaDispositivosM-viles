import 'package:flutter/material.dart';

class AppStyles {
  // Colores
  static const Color primaryColor = Color(0xFF318C7A);
  static const Color secondaryColor = Color(0xFF1E293B);
  static const Color buttonColor = Color(0xFF1E293B);
  static const Color textColor = Colors.white;

  // Fondo de Imagen
  static BoxDecoration imageBackground = BoxDecoration(
    image: DecorationImage(
      image: AssetImage('lib/images/imagenFondoPantalla.png'),
      fit: BoxFit.cover, // Ajustar la imagen para cubrir toda la pantalla
    ),
  );

  // AppBar
  static AppBar appBar = AppBar(
    title: const Text('Menú Admin'),
    backgroundColor: primaryColor,
  );

  // Estilo de texto para títulos
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  // Botón Estilo
  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    foregroundColor: textColor,
    backgroundColor: buttonColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.zero, // Botones sin bordes redondeados
    ),
  );

  // Imagen de perfil por defecto
  static const String placeholderImage = 'lib/images/placeholder.png';
}
