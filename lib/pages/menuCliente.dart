import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebaseUsuario_service.dart'; // Asegúrate de ajustar la ruta correcta de tu servicio

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
    Usuario? user = await firebaseServicio.obtenerUsuarioPorId(widget.idUsuario);

    setState(() {
      usuario = user;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(); // Función para retroceder
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Indicador de carga
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF318C7A), Color(0xFF1E293B)],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Imagen de perfil
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: usuario != null && usuario!.imagen.isNotEmpty
                          ? NetworkImage(usuario!.imagen)
                          : AssetImage('assets/placeholder.png') as ImageProvider, // Imagen por defecto si no tiene una imagen de usuario
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 16),
                    // Título "MENU"
                    Text(
                      'MENU',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 24),
                    // Botones
                    _buildButton(context, 'Listar Productos', () {
                      print('Listar Productos');
                    }),
                    _buildButton(context, 'Carrito', () {
                      print('Carrito');
                    }),
                    _buildButton(context, 'Historial de Pagos', () {
                      print('Historial de Pagos');
                    }),
                    _buildButton(context, 'Salir', () {
                      print('Salir');
                    }),
                  ],
                ),
              ),
            ),
    );
  }

  // Método para crear los botones
  Widget _buildButton(BuildContext context, String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Color(0xFF1E293B),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
