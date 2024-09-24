import 'package:flutter/material.dart';
import 'package:hola_mundo_flutter/widget/appBar.dart';
import '../services/firebaseProductos_service.dart';
import '../services/firebaseUsuario_service.dart';
import '../styles/verProductoCliente_style.dart'; // Importamos el archivo de estilos
import '../services/carrito_service.dart'; // Importa el servicio de carrito
import 'dart:convert'; // Importar para usar Base64

class ProductDetailsClient extends StatefulWidget {
  final String idProducto;
  final Usuario usuario;

  const ProductDetailsClient({Key? key, required this.idProducto, required this.usuario})
      : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetailsClient> {
  Producto? producto;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    _fetchProducto();
  }

  // Método para obtener los datos del producto
  Future<void> _fetchProducto() async {
    Producto? prod = await FirebaseServicioProducto()
        .obtenerProductoPorId(widget.idProducto);
    setState(() {
      producto = prod;
    });
  }

  // Métodos para incrementar y decrementar la cantidad
  void incrementQuantity() {
    setState(() {
      quantity += 1;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) quantity -= 1;
    });
  }

  // Método para agregar producto al carrito
  void _addToCart() async {
    final cartService = CartService();
    await cartService.addProduct(widget.idProducto, quantity);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Producto agregado al carrito')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productPrice = producto?.precio ?? 0.0;
    final subtotal = quantity * productPrice;
    final String nombreProducto = producto?.nombre ?? 'Cargando...';

    return Scaffold(
      appBar: AppBarConMenu(usuario: widget.usuario, title: nombreProducto),
      body: producto == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: AppStyles.backgroundImage, // Cambiado aquí
              child: Center(
                child: Padding(
                  padding: AppStyles.paddingAll,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Mostrar imagen en formato Base64
                      _buildImage(producto!.foto),
                      const SizedBox(height: 20),
                      Text(
                        producto!.nombre,
                        style: AppStyles.titleTextStyle,
                      ),
                      const SizedBox(height: 20),
                      _buildInputField(
                        label: 'Precio',
                        value: producto!.precio.toString(),
                      ),
                      _buildInputField(
                        label: 'Descripción',
                        value: producto!.detalle,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: decrementQuantity,
                            icon: const Icon(Icons.remove, color: Colors.white),
                          ),
                          Container(
                            width: 50,
                            child: TextField(
                              textAlign: TextAlign.center,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: AppStyles.inputTextStyle,
                              controller: TextEditingController(
                                  text: quantity.toString()),
                            ),
                          ),
                          IconButton(
                            onPressed: incrementQuantity,
                            icon: const Icon(Icons.add, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Subtotal: \$${subtotal.toStringAsFixed(2)}',
                        style: AppStyles.subtotalTextStyle,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _addToCart, // Cambia esta línea
                        icon: const Icon(Icons.shopping_cart),
                        label: const Text('Agregar'),
                        style: AppStyles.buttonStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  // Widget para mostrar la imagen desde Base64
  Widget _buildImage(String base64String) {
    if (base64String.isNotEmpty) {
      // Decodificar la cadena Base64 y convertirla a una imagen
      return CircleAvatar(
        backgroundImage: MemoryImage(
          base64Decode(base64String),
        ),
        radius: 100,
      );
    } else {
      // Placeholder en caso de que no haya imagen
      return CircleAvatar(
        backgroundImage: AssetImage(AppStyles.placeholderImage),
        radius: 100,
      );
    }
  }

  // Widget para mostrar los campos de información del producto
  Widget _buildInputField({required String label, required String value}) {
    return Padding(
      padding: AppStyles.inputFieldPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppStyles.labelTextStyle,
          ),
          const SizedBox(height: 5),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: value,
              hintStyle: AppStyles.hintTextStyle,
              enabledBorder: AppStyles.enabledBorder,
              focusedBorder: AppStyles.focusedBorder,
            ),
            style: AppStyles.inputTextStyle,
          ),
        ],
      ),
    );
  }
}
