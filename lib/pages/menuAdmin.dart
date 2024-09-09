import 'package:flutter/material.dart';
import '../services/firebaseUsuario_service.dart'; // Importa el servicio que creaste
import './listarProductosAdmin.dart';
import './crearProductoAdmin.dart';

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
      appBar: AppBar(
        title: Text('Menú Admin'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        // Usamos Container para aplicar el fondo gradiente
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF318C7A), Color(0xFF1E293B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: usuario == null
            ? Center(
                child:
                    CircularProgressIndicator(), // Muestra un cargando si no hay datos
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Imagen de perfil del usuario
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: usuario!.imagen.isNotEmpty
                          ? NetworkImage(
                              usuario!.imagen) // Cargar la imagen desde la URL
                          : AssetImage('lib/images/placeholder.png')
                              as ImageProvider, // Imagen por defecto si no hay imagen
                    ),
                    SizedBox(height: 16),
                    Text(
                      'MENÚ ADMIN',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 24),
                    // Botón Crear Producto
                    ElevatedButton(
                      onPressed: () {
                        print('Crear Producto');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NuevoProductoScreen()), // Navegar a NuevoProductoScreen
                        );
                      },
                      child: Text('Crear Producto'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF1E293B), // Color del texto
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.zero, // Botones sin redondear
                        ),
                      ),
                    ),

                    SizedBox(height: 16),
                    // Botón Listar Productos
                    ElevatedButton(
                      onPressed: () {
                        print('Listar Productos');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductList()), // Navegar a la pantalla de ProductList
                        );
                      },
                      child: Text('Listar Productos'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF1E293B), // Color del texto
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.zero, // Botones sin redondear
                        ),
                      ),
                    ),

                    SizedBox(height: 16),
                    // Botón Salir
                    ElevatedButton(
                      onPressed: () {
                        print('Salir');
                      },
                      child: Text('Salir'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF1E293B), // Color del texto
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.zero, // Botones sin redondear
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
