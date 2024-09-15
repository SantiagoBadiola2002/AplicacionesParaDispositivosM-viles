import 'package:flutter/material.dart';
import '../services/firebaseProductos_service.dart'; // Importar el servicio que contiene la función crearProducto
import '../styles/crearProductoAdmin_styles.dart';

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
        backgroundColor: AppStyles.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Retroceder a la pantalla anterior
          },
        ),
        title: Text('Nuevo Producto'),
      ),
      body: Container(
        decoration: AppStyles.gradientBackground,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: AppStyles.circleBoxDecoration,
                      child: Icon(Icons.add, size: 50, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 16),
                    Text('Nuevo Producto', style: AppStyles.titleStyle),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _nombreController,
                        decoration: AppStyles.inputDecoration.copyWith(labelText: 'Nombre'),
                        style: AppStyles.inputTextStyle,
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _precioController,
                        decoration: AppStyles.inputDecoration.copyWith(labelText: 'Precio'),
                        style: AppStyles.inputTextStyle,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _stockController,
                        decoration: AppStyles.inputDecoration.copyWith(labelText: 'Cantidad'),
                        style: AppStyles.inputTextStyle,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _descripcionController,
                        decoration: AppStyles.inputDecoration.copyWith(labelText: 'Descripción'),
                        style: AppStyles.inputTextStyle,
                        maxLines: 3,
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _fotoController,
                        decoration: AppStyles.inputDecoration.copyWith(labelText: 'URL Imagen'),
                        style: AppStyles.inputTextStyle,
                      ),
                      SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: AppStyles.buttonStyle,
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
                              print('Producto creado con éxito');
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
            ],
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
