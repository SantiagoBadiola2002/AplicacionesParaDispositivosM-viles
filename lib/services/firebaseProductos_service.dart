import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServicioProducto {
  // Referencia a la colección "Herramienta" en Firestore
  final CollectionReference productoCollection = FirebaseFirestore.instance.collection('Herramienta');

  // Método para obtener una lista de herramientas desde Firestore
  Future<List<Producto>> obtenerProductos() async {
    try {
      QuerySnapshot snapshot = await productoCollection.get();

      // Convertimos los documentos obtenidos en una lista de objetos Herramienta
      return snapshot.docs.map((doc) {
        return Producto.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print('Error al obtener productos: $e');
      return [];
    }
  }
}

// Modelo de datos de Herramienta
class Producto {
  final String idProducto;
  final String nombre;
  final String foto;
  final double precio;
  final String detalle;
  final int stock;

  Producto({
    required this.idProducto,
    required this.nombre,
    required this.foto,
    required this.precio,
    required this.detalle,
    required this.stock,
  });

  // Método para convertir un documento de Firestore en un objeto Herramienta
  factory Producto.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Producto(
      idProducto: data['IDProducto'] ?? '',
      nombre: data['Nombre'] ?? '',
      foto: data['Foto'] ?? '',
      precio: data['Precio'] != null ? data['Precio'].toDouble() : 0.0,
      detalle: data['Detalle'] ?? '',
      stock: data['Stock'] ?? 0,
    );
  }
}
