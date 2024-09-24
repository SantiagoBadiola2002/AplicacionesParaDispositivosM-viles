import 'dart:convert'; // Para decodificar la imagen base64
import 'package:flutter/material.dart';
import '../services/firebaseUsuario_service.dart';
import 'listarProductosAdmin.dart';
import 'crearProductoAdmin.dart';
import '../styles/menuAdmin_styles.dart';
import '../pages/Intro.dart';

class MenuAdmin extends StatefulWidget {
  final String idUsuario; // Recibe el ID del usuario

  const MenuAdmin({Key? key, required this.idUsuario}) : super(key: key);

  @override
  _MenuAdminState createState() => _MenuAdminState();
}

class _MenuAdminState extends State<MenuAdmin> {
  Usuario? usuario; // Almacena los datos del usuario

  @override
  void initState() {
    super.initState();
    _cargarUsuario();
  }

  Future<void> _cargarUsuario() async {
    FirebaseServicioUsuario usuarioService = FirebaseServicioUsuario();
    Usuario? userData =
        await usuarioService.obtenerUsuarioPorId(widget.idUsuario);

    setState(() {
      usuario = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppStyles.imageBackground, // Fondo personalizado
        child: usuario == null
            ? const Center(
                child: CircularProgressIndicator(), // Indicador de carga
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Imagen de perfil del usuario
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: usuario != null && usuario!.imagen.isNotEmpty
                          ? _obtenerImagenUsuario(usuario!.imagen)
                          : AssetImage(AppStyles.placeholderImage) as ImageProvider,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'MENÚ ADMIN',
                      style: AppStyles.titleTextStyle, // Estilo del título
                    ),
                    const SizedBox(height: 24),
                    // Botón Crear Producto con tamaño fijo
                    _buildButton(context, 'Crear Producto', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NuevoProductoScreen(),
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                    // Botón Listar Productos con tamaño fijo
                    _buildButton(context, 'Listar Productos', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductList(),
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                    // Botón Salir con tamaño fijo
                    _buildButton(context, 'Salir', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Intro()),
                      );
                    }),
                  ],
                ),
              ),
      ),
    );
  }

  // Método para crear botones con tamaño fijo
  Widget _buildButton(BuildContext context, String text, VoidCallback onPressed) {
    return SizedBox(
      width: 200,  // Establece un ancho constante
      height: 50,  // Establece una altura constante
      child: ElevatedButton(
        style: AppStyles.buttonStyle, // Estilo de botón personalizado
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  // Método para manejar la imagen del usuario
  ImageProvider _obtenerImagenUsuario(String imagen) {
    if (imagen.startsWith('http')) {
      // Si la imagen es una URL (por ejemplo, desde Firebase Storage)
      return NetworkImage(imagen);
    } else {
      // Si la imagen es una cadena base64
      final decodedBytes = base64Decode(imagen);
      return MemoryImage(decodedBytes);
    }
  }
}
