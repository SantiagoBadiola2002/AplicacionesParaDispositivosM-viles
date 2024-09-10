import 'package:flutter/material.dart';
import '../services/firebaseProductos_service.dart';
import '../styles/verYEditarProductoAdmin_styles.dart'; // Importar el archivo de estilos

class DetallesProducto extends StatefulWidget {
  final String idProducto; // Recibe solo el ID del producto

  DetallesProducto({required this.idProducto});

  @override
  _DetallesProductoState createState() => _DetallesProductoState();
}

class _DetallesProductoState extends State<DetallesProducto> {
  late Future<Producto?> _productoFuture;
  late TextEditingController _nombreController;
  late TextEditingController _precioController;
  late TextEditingController _stockController;
  late TextEditingController _detalleController;

  @override
  void initState() {
    super.initState();
    _productoFuture = FirebaseServicioProducto().obtenerProductoPorId(widget.idProducto);
  }

  // Método para inicializar los controladores con los valores del producto
  void _initializeControllers(Producto producto) {
    _nombreController = TextEditingController(text: producto.nombre);
    _precioController = TextEditingController(text: producto.precio.toString());
    _stockController = TextEditingController(text: producto.stock.toString());
    _detalleController = TextEditingController(text: producto.detalle);
  }

  // Método para guardar los cambios (editar el producto)
  Future<void> _guardarCambios() async {
    try {
      await FirebaseServicioProducto().actualizarProducto(
        idProducto: widget.idProducto,
        nombre: _nombreController.text,
        precio: double.parse(_precioController.text),
        detalle: _detalleController.text,
        stock: int.parse(_stockController.text),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto actualizado exitosamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar el producto')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppStyles.textColor),
          onPressed: () => Navigator.of(context).pop(), // Acción para retroceder
        ),
        title: Text(
          'Detalles del Producto',
          style: TextStyle(color: AppStyles.textColor),
        ),
      ),
      body: FutureBuilder<Producto?>(
        future: _productoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('Error al cargar el producto'));
          }

          final producto = snapshot.data!;
          // Inicializamos los controladores una vez que obtenemos los datos del producto
          _initializeControllers(producto);

          return Container(
            decoration: BoxDecoration(
              gradient: AppStyles.gradient, // Aplicar el gradiente
            ),
            child: SafeArea(
              child: Center(
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(maxWidth: 600),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: AppStyles.gradient, // Aplicar el gradiente
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                producto.foto.isNotEmpty
                                    ? producto.foto
                                    : AppStyles.placeholderImage,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          margin: EdgeInsets.only(bottom: 16),
                        ),
                      ),
                      Text(
                        'Detalles del Producto',
                        style: AppStyles.titleTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      _buildTextField('ID', producto.idProducto, false, TextEditingController(text: producto.idProducto)),
                      _buildTextField('Nombre', _nombreController.text, true, _nombreController),
                      _buildTextField('Precio', _precioController.text, true, _precioController),
                      _buildTextField('Cantidad en Stock', _stockController.text, true, _stockController),
                      _buildTextField('Descripción', _detalleController.text, true, _detalleController),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildButton('EDITAR', _guardarCambios),
                          _buildButton('HISTORIAL', () {
                            // Acción para historial
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(String label, String value, bool isEditable, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppStyles.labelTextStyle,
          ),
          SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppStyles.textColor, width: 1),
            ),
            child: TextField(
              controller: controller,
              enabled: isEditable,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              style: AppStyles.textFieldTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: AppStyles.buttonStyle,
      ),
    );
  }
}
