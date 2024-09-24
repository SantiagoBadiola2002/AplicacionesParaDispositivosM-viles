import 'dart:convert'; // Para convertir la imagen a base64
import 'dart:io'; // Para manejar archivos de imágenes
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Para seleccionar imágenes
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

  final FirebaseServicioProducto _productoService = FirebaseServicioProducto(); // Instancia del servicio

  File? _imagen; // Archivo para almacenar la imagen seleccionada
  String? _imagenBase64; // String para almacenar la imagen en formato base64

  final ImagePicker _picker = ImagePicker(); // Instancia de ImagePicker

  // Método para seleccionar una imagen desde la galería
  Future<void> _seleccionarImagen() async {
    final XFile? imagenSeleccionada = await _picker.pickImage(source: ImageSource.gallery);

    if (imagenSeleccionada != null) {
      setState(() {
        _imagen = File(imagenSeleccionada.path);
        _convertirImagenABase64();
      });
    }
  }

  // Convierte la imagen seleccionada en una cadena base64
  void _convertirImagenABase64() async {
    if (_imagen != null) {
      final bytes = await _imagen!.readAsBytes();
      setState(() {
        _imagenBase64 = base64Encode(bytes);
      });
    }
  }

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
        decoration: AppStyles.imageBackground,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _seleccionarImagen, // Seleccionar imagen al hacer clic
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: AppStyles.circleBoxDecoration,
                        child: _imagen != null
                            ? ClipOval(child: Image.file(_imagen!, fit: BoxFit.cover, width: 100, height: 100))
                            : Icon(Icons.add, size: 50, color: Colors.grey[600]),
                      ),
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
                                _imagenBase64 != null) {
                              _productoService.crearProducto(
                                nombre: _nombreController.text,
                                fotoBase64: _imagenBase64!, // Enviar imagen en base64
                                precio: double.parse(_precioController.text),
                                detalle: _descripcionController.text,
                                stock: int.parse(_stockController.text),
                              );

                              // Mostrar mensaje de éxito
                              print('Producto creado con éxito');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Producto creado con éxito')),
                              );

                              // Limpiar campos después de crear el producto
                              _nombreController.clear();
                              _precioController.clear();
                              _stockController.clear();
                              _descripcionController.clear();
                              setState(() {
                                _imagen = null;
                                _imagenBase64 = null;
                              });
                            } else {
                              // Mostrar mensaje de error si falta algún campo
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Por favor, llena todos los campos y selecciona una imagen')),
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
    super.dispose();
  }
}
