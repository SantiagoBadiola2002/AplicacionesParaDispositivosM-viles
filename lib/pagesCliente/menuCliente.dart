import 'package:flutter/material.dart';
import '../services/firebaseUsuario_service.dart';
import '../styles/menuCliente_styles.dart'; // Importa el archivo de estilos
import '../pages/Intro.dart'; // Importa el archivo que contiene el componente Into
import '../pagesCliente/listarProductosCliente.dart';
import './verCarritoCliente.dart';

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
    Usuario? user =
        await firebaseServicio.obtenerUsuarioPorId(widget.idUsuario);

    setState(() {
      usuario = user;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MenuClienteStyles.appBarColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: MenuClienteStyles.textColor),
          onPressed: () {
            Navigator.of(context).pop(); // Función para retroceder
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Indicador de carga
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
                      backgroundImage: usuario != null &&
                              usuario!.imagen.isNotEmpty
                          ? NetworkImage(usuario!.imagen)
                          : AssetImage(MenuClienteStyles.placeholderImage)
                              as ImageProvider, // Imagen por defecto si no tiene una imagen de usuario
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 16),
                    // Título "MENU"
                    Text(
                      'MENU',
                      style: MenuClienteStyles.titleTextStyle,
                    ),
                    SizedBox(height: 24),
                    // Botones
                    _buildButton(context, 'Listar Productos', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductListCliente()), // Navegar a la pantalla de ProductList
                      );
                    }),
                    _buildButton(context, 'Carrito', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(usuario: usuario!),
                        ),
                      );
                    }),
                    _buildButton(context, 'Historial de Pagos', () {}),
                    _buildButton(context, 'Salir', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Intro()), // Navegar a la pantalla de ProductList
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
