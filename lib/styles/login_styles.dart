import 'package:flutter/material.dart';

class Styles {
  // Fondo del LoginScreen con una imagen
  static final BoxDecoration backgroundDecoration = BoxDecoration(
    image: DecorationImage(
      image: AssetImage('lib/images/imagenFondoPantalla.png'), // Reemplaza con la imagen de fondo
      fit: BoxFit.cover, // Ajusta la imagen para cubrir toda la pantalla
    ),
  );

  // Decoración del contenedor del formulario de login
  static const EdgeInsets containerPadding = EdgeInsets.all(20);
  static final BoxDecoration containerDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.1), // Fondo translúcido
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 6,
        offset: Offset(0, 4),
      ),
    ],
  );

  // Icono
  static const Color iconColor = Colors.white;

  // Estilo del título
  static const TextStyle titleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
  );

  // Decoración para los campos de texto (email y contraseña)
  static InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    );
  }

  // Estilo del texto dentro de los campos de texto
  static const TextStyle inputTextStyle = TextStyle(color: Colors.white);

  // Estilo del botón
  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF334155),
    padding: EdgeInsets.symmetric(vertical: 12),
  );

  // Estilo del texto dentro del botón
  static const TextStyle buttonTextStyle = TextStyle(color: Colors.white);

  // Estilo del texto del link para registrarse
  static const TextStyle linkTextStyle = TextStyle(color: Colors.white);
}
