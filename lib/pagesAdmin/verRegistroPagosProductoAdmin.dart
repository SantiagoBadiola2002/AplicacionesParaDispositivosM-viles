import 'package:flutter/material.dart';
import '../services/firebasePagos_service.dart'; // Importa tu servicio de Firebase

class HistorialCompras extends StatefulWidget {
  final String idProducto; // Recibe el ID del producto

  const HistorialCompras({Key? key, required this.idProducto}) : super(key: key);

  @override
  _HistorialComprasState createState() => _HistorialComprasState();
}

class _HistorialComprasState extends State<HistorialCompras> {
  late Future<List<Map<String, dynamic>>> _historialComprasFuture;
  FirebaseServicioPago _servicioPagos = FirebaseServicioPago();

  @override
void initState() {
  super.initState();
  
  // Imprimir el ID del producto en la consola
  print('Inicializando el historial de compras para el producto con ID: ${widget.idProducto}');
  
  // Obtener el historial de compras
  _historialComprasFuture = _servicioPagos.obtenerHistorialComprasProducto(widget.idProducto);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Compras'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
  future: _historialComprasFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return const Center(child: Text('Error al cargar el historial de compras'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Center(child: Text('No hay historial de compras disponible'));
    }

    // Datos del historial de compras
    final comprasHistoricas = snapshot.data!;

    return ListView.builder(
      itemCount: comprasHistoricas.length,
      itemBuilder: (context, index) {
        final compra = comprasHistoricas[index];
        return Card(
          child: ListTile(
            title: Text('Cliente: ${compra['NombreCliente']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fecha: ${compra['Fecha']}'),
                Text('Cantidad: ${compra['Cantidad']}'),
              ],
            ),
          ),
        );
      },
    );
  },
),

    );
  }
}
