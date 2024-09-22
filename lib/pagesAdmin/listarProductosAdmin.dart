import 'package:flutter/material.dart';
import '../services/firebaseProductos_service.dart';
import 'verYEditarProductoAdmin.dart'; // Asegúrate de importar la pantalla correcta
import '../styles/listarProductosAdmin_styles.dart'; // Importar el archivo de estilos

class ProductList extends StatelessWidget {
  final FirebaseServicioProducto firebaseServicioProducto = FirebaseServicioProducto();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppStyles.appBar,
      body: Container(
        decoration: AppStyles.imageBackground,
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

            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];

                return GestureDetector(
                  onTap: () {
                    print('Llendo a detallesProducto');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetallesProducto(idProducto: producto.idProducto),
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
                          Image.network(
                            producto.foto.isNotEmpty ? producto.foto : '',
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
