import 'package:flutter/material.dart';

class SignUpStyles {
  static const appBarColor = Colors.teal;

  // Fondo de imagen en lugar del gradiente
  static final bodyDecoration = BoxDecoration(
    image: DecorationImage(
      image: AssetImage('lib/images/imagenFondoPantalla.png'), // Reemplaza con la imagen de fondo
      fit: BoxFit.cover, // Ajusta la imagen para cubrir toda la pantalla
    ),
  );

  static const padding = EdgeInsets.all(16.0);

  // Decoración de un círculo
  static const circleDecoration = BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.grey,
  );

  // Estilo del título
  static const TextStyle titleStyle = TextStyle(
    color: Colors.white,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  // Estilo del texto dentro de los campos de texto
  static const TextStyle inputTextStyle = TextStyle(color: Colors.white);

  // Decoración de los campos de texto
  static InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.transparent,
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    );
  }

  // Estilo del botón
  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: const Color(0xFF334155),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    ),
  );
}
