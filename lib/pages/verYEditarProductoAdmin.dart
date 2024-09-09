import 'package:flutter/material.dart';
import '../services/firebaseProductos_service.dart'; // Asegúrate de tener el servicio importado

class DetallesProducto extends StatefulWidget {
  final String idProducto; // Recibe solo el ID del producto

  DetallesProducto({required this.idProducto});

  @override
  _DetallesProductoState createState() => _DetallesProductoState();
}

class _DetallesProductoState extends State<DetallesProducto> {
  late Future<Producto?> _productoFuture;

  @override
  void initState() {
    super.initState();
    _productoFuture = FirebaseServicioProducto().obtenerProductoPorId(widget.idProducto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF318C7A), // Fondo del AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(), // Acción para retroceder
        ),
        title: Text(
          'Detalles del Producto',
          style: TextStyle(color: Colors.white),
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
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF318C7A), // Color #318C7A
                  Color(0xFF1E293B), // Color #1E293B
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(maxWidth: 600),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF318C7A), // Color #318C7A
                        Color(0xFF1E293B), // Color #1E293B
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [ // Añade una sombra para un mejor efecto visual
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
                                    : 'https://via.placeholder.com/150',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          margin: EdgeInsets.only(bottom: 16),
                        ),
                      ),
                      Text(
                        'Detalles del Producto',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Color del texto del encabezado
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      _buildTextField('ID', producto.idProducto, false), // Solo lectura
                      _buildTextField('Nombre', producto.nombre, true),
                      _buildTextField('Precio', producto.precio.toString(), true),
                      _buildTextField('Cantidad en Stock', producto.stock.toString(), true),
                      _buildTextField('Descripción', producto.detalle, true),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildButton('EDITAR'),
                          _buildButton('HISTORIAL'),
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

  Widget _buildTextField(String label, String value, bool isEditable) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white, // Color del texto de las etiquetas
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.white, width: 1), // Borde blanco
            ),
            child: TextField(
              controller: TextEditingController(text: value),
              enabled: isEditable,
              decoration: InputDecoration(
                fillColor: Colors.transparent, // Fondo transparente para el campo de texto
                filled: true,
                border: InputBorder.none, // Sin borde por defecto
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              style: TextStyle(color: Colors.white), // Color del texto en el campo
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          // Acción para editar o historial
        },
        child: Text(text),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF334155), // Color del botón
          padding: EdgeInsets.symmetric(vertical: 12), // Ajusta el padding para hacerlo más pequeño
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          textStyle: TextStyle(fontSize: 14), // Ajusta el tamaño del texto
        ),
      ),
    );
  }
}
