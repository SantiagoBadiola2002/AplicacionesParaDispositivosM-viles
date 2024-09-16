import 'package:flutter/material.dart';
import '../pagesCliente/menuCliente.dart';
import '../pagesCliente/verCarritoCliente.dart';
import '../services/firebaseUsuario_service.dart'; // Asegúrate de importar la página del menú

class AppBarConMenu extends StatelessWidget implements PreferredSizeWidget {
  final Usuario usuario;
  final String title; // Título dinámico para cada pantalla

  AppBarConMenu({required this.usuario, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF318C7A), // Color de fondo del AppBar
      title: Text(
        title,
        style: TextStyle(color: Colors.white), // Color del título
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.home, color: Colors.white), // Color del ícono
          onPressed: () {
            // Navega al menú del cliente cuando se presiona el botón de menú
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuCliente(idUsuario: usuario.idUsuario),
              ),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.white), // Color del ícono
          onPressed: () {
            // Navega al carrito de compras cuando se presiona el botón de carrito
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(usuario: usuario),
              ),
            );
          },
        ),
      ],
    );
  }

  // Este método define la altura predeterminada del AppBar
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
