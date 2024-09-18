import 'package:flutter/material.dart';

class MenuClienteStyles {
  // Colores
  static const Color appBarColor = Colors.teal;
  static const Color buttonColor = Color(0xFF1E293B);
  static const Color textColor = Colors.white;

  // Fondo con imagen en lugar de gradiente
  static final BoxDecoration backgroundDecoration = BoxDecoration(
    image: DecorationImage(
      image: AssetImage('lib/images/imagenFondoPantalla.png'), // Ruta de la imagen de fondo
      fit: BoxFit.cover, // Ajusta la imagen para cubrir toda la pantalla
    ),
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
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  // Imágenes
  static const String placeholderImage = 'assets/placeholder.png';
}
