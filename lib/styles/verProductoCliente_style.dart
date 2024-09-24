import 'package:flutter/material.dart';

class AppStyles {
  // Colores principales
  static const Color primaryColor = Color(0xFF318C7A);
  static const Color secondaryColor = Color(0xFF1E293B);

  static const String placeholderImage = 'lib/images/placeholder.png';
  
  // Imagen de fondo
  static BoxDecoration backgroundImage = BoxDecoration(
    image: DecorationImage(
      image: AssetImage('lib/images/imagenFondoPantalla.png'),
      fit: BoxFit.cover,
    ),
  );
  
  // Gradiente de fondo (opcional, por si lo necesitas más adelante)
  static const BoxDecoration backgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      colors: [primaryColor, secondaryColor],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
  
  // TextStyle para los títulos
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // TextStyle para los campos de entrada de texto
  static const TextStyle inputTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  // TextStyle para las etiquetas
  static const TextStyle labelTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
  );

  // TextStyle para el subtítulo del precio
  static const TextStyle subtotalTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // TextStyle para el hint del TextField
  static const TextStyle hintTextStyle = TextStyle(
    color: Colors.white,
  );

  // Bordes para los campos de texto
  static const UnderlineInputBorder enabledBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  );

  static const UnderlineInputBorder focusedBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  );

  // Padding general
  static const EdgeInsets paddingAll = EdgeInsets.all(16.0);

  // Padding para los campos de texto
  static const EdgeInsets inputFieldPadding = EdgeInsets.symmetric(vertical: 8.0);

  // Estilo para el botón
  static final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: primaryColor,
    minimumSize: const Size(double.infinity, 50),
  );
}
