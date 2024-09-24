import 'dart:convert'; // Para decodificar la imagen base64
import 'package:flutter/material.dart';
import '../services/firebaseProductos_service.dart';
import '../services/firebaseUsuario_service.dart';
import '../styles/listarProductosAdmin_styles.dart'; // Reutilizamos los estilos del admin
import './verProductoCliente.dart'; // Importar la pantalla de detalles
import '../widget/appBar.dart'; // Importar el AppBar personalizado

class ProductListCliente extends StatelessWidget {
  final FirebaseServicioProducto firebaseServicioProducto = FirebaseServicioProducto();
  final Usuario usuario;

  ProductListCliente({required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConMenu(usuario: usuario, title: 'Productos'), // Usar el AppBar personalizado
      body: Container(
        decoration: AppStyles.imageBackground, // Reutilizar el fondo de imagen
        child: FutureBuilder<List<Producto>>(
          future: firebaseServicioProducto.obtenerProductos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error al obtener los productos'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No hay productos disponibles'));
            }

            final productos = snapshot.data!;

            // ListView para mostrar los productos de manera similar al admin
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsClient(usuario: usuario, idProducto: producto.idProducto),
                      ),
                    );
                  },
                  child: Card(
                    elevation: AppStyles.cardElevation,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Mostrar la imagen usando Image.memory para base64
                          producto.foto.isNotEmpty
                              ? Image.memory(
                                  base64Decode(producto.foto),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      AppStyles.placeholderImage,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Image.asset(
                                  AppStyles.placeholderImage,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                          SizedBox(width: 12), // Espaciado entre la imagen y los textos
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  producto.nombre,
                                  style: AppStyles.productTitleStyle,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '\$${producto.precio.toStringAsFixed(2)}',
                                  style: AppStyles.productPriceStyle,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  producto.detalle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyles.productDetailStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
