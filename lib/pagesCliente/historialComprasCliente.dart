import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hola_mundo_flutter/widget/appBar.dart';
import 'package:intl/intl.dart';
import '../services/firebasePagos_service.dart';
import '../services/firebaseUsuario_service.dart';
import '../styles/historialComprasProducto_style.dart'; // Importa los estilos

class HistorialComprasPage extends StatefulWidget {
  final Usuario usuario;
  

  const HistorialComprasPage({Key? key, required this.usuario})
      : super(key: key);

  @override
  _HistorialComprasPageState createState() => _HistorialComprasPageState();
}

class _HistorialComprasPageState extends State<HistorialComprasPage> {
  final FirebaseServicioPago _firebaseServicioPago = FirebaseServicioPago();
  List<Map<String, dynamic>> _purchaseHistory = [];
  List<bool> _isOpen = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _obtenerHistorialPagosCliente();
  }

  Future<void> _obtenerHistorialPagosCliente() async {
    try {
      List<Map<String, dynamic>> historial = await _firebaseServicioPago
          .obtenerHistorialPagosCliente(widget.usuario.idUsuario);

      setState(() {
        _purchaseHistory = historial;
        _isOpen = List<bool>.filled(historial.length, false);
        _isLoading = false;
      });
    } catch (e) {
      print('Error al obtener el historial de pagos: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBarConMenu(usuario: widget.usuario, title: 'Historial de Compras'),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppStyles.backgroundGradient,
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _purchaseHistory.isEmpty
                ? const Center(child: Text('No hay historial de compras disponible.'))
                : ListView.builder(
                    padding: AppStyles.listPadding,
                    itemCount: _purchaseHistory.length,
                    itemBuilder: (context, index) {
                      var purchase = _purchaseHistory[index];
                      var products = purchase['Productos'] as List<dynamic>;

                      return Container(
                        margin: AppStyles.cardMargin,
                        child: Card(
                          elevation: 3,
                          color: AppStyles.cardColor,
                          child: ExpansionPanelList(
                            elevation: 1,
                            expandedHeaderPadding: EdgeInsets.zero,
                            expansionCallback: (panelIndex, isExpanded) {
                              setState(() {
                                _isOpen[index] = !_isOpen[index];
                              });
                            },
                            children: [
                              ExpansionPanel(
                                isExpanded: _isOpen[index],
                                headerBuilder: (context, isExpanded) {
                                  return Container(
                                    color: AppStyles.headerColor,
                                    child: ListTile(
                                      title: Text(
                                        'ID: ${purchase['ID']} | Fecha: ${DateFormat('yyyy-MM-dd').format((purchase['Fecha'] as Timestamp).toDate())} | Total: \$${purchase['Total'].toStringAsFixed(2)}',
                                        style: AppStyles.headerTextStyle,
                                      ),
                                    ),
                                  );
                                },
                                body: Container(
                                  color: AppStyles.bodyColor,
                                  child: Column(
                                    children: products.map<Widget>((product) {
                                      return ListTile(
                                        leading: Image.network(
                                          product['Foto'] ?? '',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              'lib/images/noImagenProducto.webp',
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                        title: Text(product['Nombre']),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Precio: \$${product['Precio'].toStringAsFixed(2)}'),
                                            Text('Cantidad: ${product['Cantidad']}'),
                                            Text(
                                              'Subtotal: \$${(product['Precio'] * product['Cantidad']).toStringAsFixed(2)}',
                                              style: AppStyles.subtotalTextStyle,
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
