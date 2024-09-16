import 'package:flutter/material.dart';
import '../services/firebaseProductos_service.dart';
import '../services/firebaseUsuario_service.dart';
import '../styles/listarProductosCliente_styles.dart'; // Importar el archivo de estilos
import './verProductoCliente.dart'; // Importar la pantalla de detalles
import '../widget/appBar.dart'; // Importar el AppBar personalizado

class ProductListCliente extends StatelessWidget {
  final FirebaseServicioProducto firebaseServicioProducto = FirebaseServicioProducto();
  final Usuario usuario; // Asegúrate de recibir el idUsuario

  ProductListCliente({required this.usuario}); // Constructor que recibe el idUsuario

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConMenu(usuario: usuario, title: 'Productos'), // Usar el AppBar personalizado
      body: Container(
        decoration: AppStyles.gradientBackground,
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

            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];

                // Envuelve el Card dentro de un GestureDetector o InkWell para detectar el clic
                return GestureDetector(
                  onTap: () {
                    // Al hacer clic, navega a ProductDetailsClient pasando el id del producto
                    print('Llendo a verProductoCliente');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsClient(usuario: usuario,idProducto: producto.idProducto),
                      ),
                    );
                  },
                  child: Card(
                    elevation: AppStyles.cardElevation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          producto.foto.isNotEmpty ? producto.foto : '',
                          height: 84,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              AppStyles.placeholderImage,
                              height: 84,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            producto.nombre,
                            style: AppStyles.productTitleStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '\$${producto.precio.toStringAsFixed(2)}',
                            style: AppStyles.productPriceStyle,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              producto.detalle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
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
