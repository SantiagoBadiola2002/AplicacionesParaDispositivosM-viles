import 'package:flutter/material.dart';

class AppStyles {
  // Colores
  static const Color primaryColor = Color(0xFF318C7A);
  static const Color secondaryColor = Color(0xFF1E293B);
  static const Color buttonColor = Color(0xFF334155);
  static const Color textColor = Colors.white;

  // Gradiente
  static const LinearGradient gradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // AppBar
  static AppBar appBar = AppBar(
    backgroundColor: primaryColor,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: textColor),
      onPressed: null, // Acción a definir
    ),
    title: Text(
      'Detalles del Producto',
      style: TextStyle(color: textColor),
    ),
  );

  // Text Styles
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle labelTextStyle = TextStyle(
    color: textColor,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textFieldTextStyle = TextStyle(
    color: textColor,
  );

  // Botón Estilo
  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    foregroundColor: textColor,
    backgroundColor: buttonColor,
    padding: EdgeInsets.symmetric(vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    textStyle: TextStyle(fontSize: 14),
  );

  // Imagen de perfil por defecto
  static const String placeholderImage = 'https://via.placeholder.com/150';
}
