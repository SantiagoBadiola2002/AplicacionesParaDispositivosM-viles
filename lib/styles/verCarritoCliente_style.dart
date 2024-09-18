import 'package:flutter/material.dart';

class AppStyles {
  // Colores
  static const Color primaryColor = Color(0xFF318C7A);
  static const Color secondaryColor = Color(0xFF1E293B);
  static const Color whiteColor = Colors.white;

  // Textos
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: whiteColor,
  );

  static const TextStyle itemTitleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: whiteColor,
  );

  static const TextStyle itemPriceTextStyle = TextStyle(
    fontSize: 16,
    color: whiteColor,
  );

  static const TextStyle quantityTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: whiteColor,
  );

  static const TextStyle totalTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: whiteColor,
  );

  static const TextStyle totalPriceTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: whiteColor,
  );

  static const TextStyle emptyCartTextStyle = TextStyle(
    fontSize: 18,
    fontStyle: FontStyle.italic,
    color: whiteColor,
  );

  // Padding
  static const EdgeInsetsGeometry paddingAll = EdgeInsets.all(16.0);
  
  // Bordes
  static final BorderSide enabledBorder = BorderSide(
    color: whiteColor.withOpacity(0.3),
    width: 1.0,
  );

  static final BorderSide focusedBorder = BorderSide(
    color: primaryColor,
    width: 1.0,
  );

  // Fondo con imagen
  static BoxDecoration backgroundImage = BoxDecoration(
    image: DecorationImage(
      image: AssetImage('lib/images/imagenFondoPantalla.png'), // Asegúrate de que la ruta sea correcta
      fit: BoxFit.cover,
    ),
  );
}
