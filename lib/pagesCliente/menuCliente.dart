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
              decoration: BoxDecoration(
                gradient: MenuClienteStyles
                    .backgroundGradient, // Aplicar el gradiente
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Imagen de perfil
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          usuario != null && usuario!.imagen.isNotEmpty
                              ? NetworkImage(usuario!.imagen)
                              : AssetImage(MenuClienteStyles.placeholderImage)
                                  as ImageProvider,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    // Título "MENU"
                    Text(
                      'MENU',
                      style: MenuClienteStyles.titleTextStyle,
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
                              usuario:
                                  usuario!), // Enviar solo el idUsuario
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
      child: ElevatedButton(
        style: MenuClienteStyles.buttonStyle,
        onPressed: onPressed,
        child: Text(
          text,
          style: MenuClienteStyles.buttonTextStyle,
        ),
      ),
    );
  }
}
