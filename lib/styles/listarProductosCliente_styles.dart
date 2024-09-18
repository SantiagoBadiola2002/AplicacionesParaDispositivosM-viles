import 'package:flutter/material.dart';

class AppStyles {
  // Colores
  static const Color primaryColor = Color(0xFF318C7A);
  static const Color secondaryColor = Color(0xFF1E293B);
  static const Color buttonColor = Color(0xFF334155);
  static const Color textColor = Colors.white;
  static const Color cardTextColor = Colors.teal;

  // Background Image
  static BoxDecoration backgroundImage = BoxDecoration(
    image: DecorationImage(
      image: AssetImage('lib/images/imagenFondoPantalla.png'),
      fit: BoxFit.cover,
    ),
  );

  // AppBar
  static AppBar appBar = AppBar(
    title: Text('Nuestros Productos'),
    backgroundColor: primaryColor,
  );

  // Text Styles
  static const TextStyle productTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle productPriceStyle = TextStyle(
    fontSize: 16,
    color: cardTextColor,
  );

  static const TextStyle productDetailStyle = TextStyle(
    fontSize: 14, // Ajusta el tamaño según sea necesario
    color: Colors.black, // Puedes cambiar el color si es necesario
  );

  // Card Style
  static const double cardElevation = 5.0;

  // Error Image
  static const String placeholderImage = 'lib/images/noImagenProducto.webp';
}
