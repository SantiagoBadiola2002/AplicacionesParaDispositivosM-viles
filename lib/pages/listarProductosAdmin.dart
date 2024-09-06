import 'package:flutter/material.dart';
import '../services/firebaseProductos_service.dart'; // Asegúrate de tener el servicio importado

class ProductList extends StatelessWidget {
  final FirebaseServicioProducto firebaseServicioProducto = FirebaseServicioProducto();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuestros Productos'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        // Usa un Container para aplicar el gradiente al fondo
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

            final herramientas = snapshot.data!;

            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: herramientas.length,
              itemBuilder: (context, index) {
                final herramienta = herramientas[index];

                return Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        herramienta.foto,
                        height: 84,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          herramienta.nombre,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '\$${herramienta.precio.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          herramienta.detalle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
