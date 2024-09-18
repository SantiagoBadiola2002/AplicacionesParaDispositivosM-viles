import 'package:flutter/material.dart';

class AppStyles {
  // Colores
  static const Color primaryColor = Color(0xFF318C7A);
  static const Color secondaryColor = Color(0xFF1E293B);
  static const Color buttonColor = Color(0xFF334155);
  static const Color textColor = Colors.white;

  // Text Styles
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle inputTextStyle = TextStyle(
    color: textColor,
  );

  // Decorations
  static BoxDecoration imageBackground = BoxDecoration(
    image: DecorationImage(
      image: AssetImage('lib/images/imagenFondoPantalla.png'),
      fit: BoxFit.cover, // Ajustar la imagen para que cubra toda la pantalla
    ),
  );

  static const InputDecoration inputDecoration = InputDecoration(
    labelStyle: TextStyle(color: textColor),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: textColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: textColor),
    ),
  );

  static const BoxDecoration circleBoxDecoration = BoxDecoration(
    color: Colors.grey,
    shape: BoxShape.circle,
  );

  // Button Style
  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: buttonColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.zero, // Sin bordes redondeados
    ),
    textStyle: TextStyle(color: textColor),
  );
}
