import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServicioProducto {
  // Referencia a la colección "Herramienta" en Firestore
  final CollectionReference productoCollection = FirebaseFirestore.instance.collection('Herramienta');

  // Método para obtener una lista de herramientas desde Firestore
  Future<List<Producto>> obtenerProductos() async {
    try {
      QuerySnapshot snapshot = await productoCollection.get();

      // Convertimos los documentos obtenidos en una lista de objetos Producto
      return snapshot.docs.map((doc) {
        return Producto.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print('Error al obtener productos: $e');
      return [];
    }
  }

  // Método para obtener un producto específico por ID
  Future<Producto?> obtenerProductoPorId(String id) async {
    try {
      DocumentSnapshot doc = await productoCollection.doc(id).get();

      if (doc.exists) {
        return Producto.fromFirestore(doc);
      } else {
        print('Producto con ID $id no encontrado');
        return null;
      }
    } catch (e) {
      print('Error al obtener producto por ID: $e');
      return null;
    }
  }

  // Método para crear un nuevo producto con ID autogenerado
  Future<void> crearProducto({
    required String nombre,
    required String foto,
    required double precio,
    required String detalle,
    required int stock,
  }) async {
    try {
      // Creamos un nuevo producto sin ID, Firestore lo autogenera
      DocumentReference docRef = await productoCollection.add({
        'Nombre': nombre,
        'Foto': foto,
        'Precio': precio,
        'Detalle': detalle,
        'Stock': stock,
      });

      // El ID autogenerado se puede obtener de docRef.id si es necesario
      print('Producto creado con ID: ${docRef.id}');
    } catch (e) {
      print('Error al crear producto: $e');
    }
  }

  // Método para actualizar un producto por su ID (sin modificar el ID)
  Future<void> actualizarProducto({
    required String idProducto,
    required String nombre,
    required double precio,
    required String detalle,
    required int stock,
  }) async {
    try {
      // Actualizamos solo los campos especificados, sin cambiar el ID
      await productoCollection.doc(idProducto).update({
        'Nombre': nombre,
        'Precio': precio,
        'Detalle': detalle,
        'Stock': stock,
      });
      print('Producto con ID $idProducto actualizado exitosamente.');
    } catch (e) {
      print('Error al actualizar el producto: $e');
    }
  }
}

// Modelo de datos de Producto
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

  // Método para convertir un documento de Firestore en un objeto Producto
  factory Producto.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Producto(
      idProducto: doc.id,  // Usamos el ID del documento autogenerado por Firestore
      nombre: data['Nombre'] ?? '',
      foto: data['Foto'] ?? '',
      precio: data['Precio'] != null ? data['Precio'].toDouble() : 0.0,
      detalle: data['Detalle'] ?? '',
      stock: data['Stock'] ?? 0,
    );
  }
}
