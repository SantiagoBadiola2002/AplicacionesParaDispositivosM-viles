import 'package:flutter/material.dart';
import '../services/firebaseProductos_service.dart'; // Importar el servicio que contiene la función crearProducto

class NuevoProductoScreen extends StatefulWidget {
  @override
  _NuevoProductoScreenState createState() => _NuevoProductoScreenState();
}

class _NuevoProductoScreenState extends State<NuevoProductoScreen> {
  final _nombreController = TextEditingController();
  final _precioController = TextEditingController();
  final _stockController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _fotoController = TextEditingController();

  final FirebaseServicioProducto _productoService = FirebaseServicioProducto(); // Instancia del servicio

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF318C7A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Retroceder a la pantalla anterior
          },
        ),
        title: Text('Nuevo Producto'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF318C7A), Color(0xFF1E293B)], // Fondo degradado
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add, size: 50, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Nuevo Producto',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Cambiado a blanco para que contraste
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _nombreController,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(color: Colors.white), // Texto en blanco
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _precioController,
                  decoration: InputDecoration(
                    labelText: 'Precio',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _stockController,
                  decoration: InputDecoration(
                    labelText: 'Cantidad',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _descripcionController,
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _fotoController,
                  decoration: InputDecoration(
                    labelText: 'URL Imagen',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF334155),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Sin bordes redondeados
                      ),
                      textStyle: TextStyle(color: Colors.white), // Letras blancas
                    ),
                    onPressed: () {
                      // Validamos que los campos no estén vacíos antes de enviar los datos
                      if (_nombreController.text.isNotEmpty &&
                          _precioController.text.isNotEmpty &&
                          _stockController.text.isNotEmpty &&
                          _descripcionController.text.isNotEmpty &&
                          _fotoController.text.isNotEmpty) {
                        _productoService.crearProducto(
                          nombre: _nombreController.text,
                          foto: _fotoController.text,
                          precio: double.parse(_precioController.text),
                          detalle: _descripcionController.text,
                          stock: int.parse(_stockController.text),
                        );

                        // Mostrar mensaje de éxito
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Producto creado con éxito')),
                        );
                      } else {
                        // Mostrar mensaje de error si falta algún campo
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Por favor, llena todos los campos')),
                        );
                      }
                    },
                    child: Text('Registrar Producto', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Liberar los controladores cuando el widget se elimine
    _nombreController.dispose();
    _precioController.dispose();
    _stockController.dispose();
    _descripcionController.dispose();
    _fotoController.dispose();
    super.dispose();
  }
}
