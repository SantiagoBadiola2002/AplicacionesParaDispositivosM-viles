import 'dart:convert'; // Para decodificar la imagen base64
import 'package:flutter/material.dart';
import '../services/firebaseUsuario_service.dart';
import '../styles/menuCliente_styles.dart'; // Importa el archivo de estilos
import '../pages/Intro.dart'; // Importa el archivo que contiene el componente Intro
import '../pagesCliente/listarProductosCliente.dart';
import './verCarritoCliente.dart';
import '../pagesCliente/historialComprasCliente.dart';

class MenuCliente extends StatefulWidget {
  final String idUsuario; // Recibe el ID del usuario

  MenuCliente({required this.idUsuario});

  @override
  _MenuClienteState createState() => _MenuClienteState();
}

class _MenuClienteState extends State<MenuCliente> {
  Usuario? usuario; // Variable para almacenar los datos del usuario
  bool isLoading = true; // Variable para controlar el estado de carga

  @override
  void initState() {
    super.initState();
    _cargarDatosUsuario();
  }

  // Método para cargar los datos del usuario
  Future<void> _cargarDatosUsuario() async {
    final firebaseServicio = FirebaseServicioUsuario();
    try {
      Usuario? user =
          await firebaseServicio.obtenerUsuarioPorId(widget.idUsuario);
      setState(() {
        usuario = user;
        isLoading = false;
      });
    } catch (e) {
      print('Error al cargar los datos del usuario: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Indicador de carga
          : Container(
              decoration: MenuClienteStyles
                  .backgroundDecoration, // Aplicar la decoración de fondo
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Imagen de perfil
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: usuario != null && usuario!.imagen.isNotEmpty
                          ? _decodificarImagenBase64(usuario!.imagen)
                          : AssetImage(MenuClienteStyles.placeholderImage)
                              as ImageProvider,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    // Título "MENU"
                    Text(
                      'MENU',
                      style: MenuClienteStyles
                          .titleTextStyle, // Aplicar el estilo del título
                    ),
                    const SizedBox(height: 24),
                    // Botones
                    _buildButton(context, 'Listar Productos', () {
                      print('Llendo a listarProductosCliente');
                      if (usuario != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductListCliente(
                              usuario:
                                  usuario!, // Pasas el usuario que ya fue cargado
                            ),
                          ),
                        );
                      } else {
                        print('Error: usuario es null');
                      }
                    }),
                    _buildButton(context, 'Carrito', () {
                      print('Llendo a verCarritoCliente');
                      if (usuario != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartScreen(
                                usuario:
                                    usuario!), // Pasar el objeto completo si está disponible
                          ),
                        );
                      } else {
                        print('Error: usuario es null');
                      }
                    }),
                    _buildButton(context, 'Historial de Pagos', () {
                      print('Yendo a historialComprasCliente');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistorialComprasPage(
                              usuario: usuario!), // Enviar solo el idUsuario
                        ),
                      );
                    }),
                    _buildButton(context, 'Salir', () {
                      print('Salir');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Intro()), // Regresar a la pantalla de intro
                      );
                    }),
                  ],
                ),
              ),
            ),
    );
  }

  // Método para crear los botones
  Widget _buildButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: 200, // Establece el mismo ancho para todos los botones
        height: 53, // Establece la misma altura para todos los botones
        child: ElevatedButton(
          style: MenuClienteStyles.buttonStyle, // Aplicar el estilo del botón
          onPressed: onPressed,
          child: Text(
            text,
            style: MenuClienteStyles
                .buttonTextStyle, // Aplicar el estilo del texto del botón
          ),
        ),
      ),
    );
  }

  // Método para decodificar la imagen en base64 y devolver un MemoryImage
  MemoryImage _decodificarImagenBase64(String base64String) {
    final decodedBytes = base64Decode(base64String);
    return MemoryImage(decodedBytes);
  }
}
