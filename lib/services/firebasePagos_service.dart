import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FirebaseServicioPago {
  final CollectionReference pagosCollection = FirebaseFirestore.instance.collection('Pago');

  // Registrar un nuevo pago
  Future<void> registrarPago({
    required String idUsuario,
    required String nombreCliente,
    required double total,
    required List<Map<String, dynamic>> productos, // Lista de productos con IDProducto, Nombre, Cantidad y Precio
  }) async {
    try {
      await pagosCollection.add({
        'IDUsuario': idUsuario,
        'NombreCliente': nombreCliente,
        'Fecha': Timestamp.now(),  // Fecha actual del pago
        'Total': total,
        'Productos': productos,  // Array de productos comprados
      });
      print('Pago registrado exitosamente.');
    } catch (e) {
      print('Error al registrar pago: $e');
    }
  }

  // Obtener el historial de pagos de un cliente específico
  Future<List<Map<String, dynamic>>> obtenerHistorialPagosCliente(String idUsuario) async {
    try {
      QuerySnapshot snapshot = await pagosCollection.where('IDUsuario', isEqualTo: idUsuario).get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error al obtener historial de pagos del cliente: $e');
      return [];
    }
  }

 // Obtener el historial de compras de un producto específico
Future<List<Map<String, dynamic>>> obtenerHistorialComprasProducto(String idProducto) async {
  try {
    print('Obteniendo historial de compras para el producto con ID: $idProducto');
    
    // Obtener todos los documentos de la colección 'Pagos'
    QuerySnapshot snapshot = await pagosCollection.get();

    List<Map<String, dynamic>> historial = [];

    // Formateador de fecha
    final DateFormat dateFormatter = DateFormat('dd/MM/yyyy HH:mm'); // Formato que prefieras

    // Recorrer todos los documentos
    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('Productos')) {
        final productos = data['Productos'] as List<dynamic>;

        if (productos is List) {
          for (var producto in productos) {
            if (producto['IDProducto'] == idProducto) {
              // Convertir Timestamp a DateTime y luego a un formato legible
              final Timestamp timestamp = data['Fecha'];
              final DateTime dateTime = timestamp.toDate();
              final String fechaFormateada = dateFormatter.format(dateTime);

              // Añadir al historial
              historial.add({
                'Fecha': fechaFormateada,  // Usamos la fecha formateada
                'NombreCliente': data['NombreCliente'],
                'Cantidad': producto['Cantidad'],
                'NombreProducto': producto['Nombre'],
                'Precio': producto['Precio'],
              });
            }
          }
        } else {
          print('El campo "Productos" no es una lista en el documento con ID: ${doc.id}');
        }
      } else {
        print('El campo "Productos" no existe o los datos son nulos en el documento con ID: ${doc.id}');
      }
    }

    print('Historial obtenido: $historial');

    return historial;
  } catch (e) {
    print('Error al obtener historial de compras del producto: $e');
    return [];
  }
}




}

