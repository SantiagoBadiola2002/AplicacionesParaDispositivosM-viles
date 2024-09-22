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
        decoration: AppStyles.imageBackground,
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
                          : AssetImage(AppStyles.placeholderImage)
                              as ImageProvider, // Imagen por defecto si no hay imagen
                    ),
                    SizedBox(height: 16),
                    Text(
                      'MENÚ ADMIN',
                      style: AppStyles.titleTextStyle,
                    ),
                    SizedBox(height: 24),
                    // Botón Crear Producto con tamaño fijo
                    _buildButton(context, 'Crear Producto', () {
                      print('Crear Producto');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NuevoProductoScreen(),
                        ),
                      );
                    }),
                    SizedBox(height: 16),
                    // Botón Listar Productos con tamaño fijo
                    _buildButton(context, 'Listar Productos', () {
                      print('Llendo a listarProductosAdmin');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductList(),
                        ),
                      );
                    }),
                    SizedBox(height: 16),
                    // Botón Salir con tamaño fijo
                    _buildButton(context, 'Salir', () {
                      print('Salir');
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
        style: AppStyles.buttonStyle,
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
