import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hola_mundo_flutter/pagesCliente/historialComprasCliente.dart';
import 'package:hola_mundo_flutter/widget/appBar.dart';
import '../services/carrito_service.dart'; // Importa el servicio de carrito
import '../services/firebaseProductos_service.dart'; // Importa el servicio de productos
import '../services/firebaseUsuario_service.dart';
import '../services/firebasePagos_service.dart';
import '../styles/verCarritoCliente_style.dart';  // Importa el archivo de estilos

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();


  final Usuario usuario; // Recibe los datos del usuario

  CartScreen({required this.usuario});
}

class _CartScreenState extends State<CartScreen> with WidgetsBindingObserver {
  Map<String, int> _cartItems = {};
  Map<String, Producto> _productos = {};
  double _totalPrice = 0.0;
  final FirebaseServicioProducto _productoService = FirebaseServicioProducto();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadCart();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _clearCart();
    }
  }

  Future<void> _loadCart() async {
    final cartService = CartService();
    final cartItems = await cartService.getCart();
    final productos = await _productoService.obtenerProductos();

    final productoMap = {for (var p in productos) p.idProducto: p};

    double totalPrice = 0.0;

    setState(() {
      _cartItems = cartItems;
      _productos = productoMap;

      for (var entry in _cartItems.entries) {
        final producto = _productos[entry.key];
        if (producto != null) {
          totalPrice += entry.value * producto.precio;
        }
      }

      _totalPrice = totalPrice;
    });
  }

  Future<void> _clearCart() async {
    final cartService = CartService();
    await cartService.clearCart();
  }

  Future<void> _removeProduct(String productId) async {
    final cartService = CartService();
    await cartService.removeProduct(productId);
    _loadCart(); // Vuelve a cargar el carrito para reflejar los cambios
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConMenu(usuario:  widget.usuario, title: 'Tu Carrito'),
      body: Container(
        decoration: AppStyles.backgroundGradient,
        child: _cartItems.isEmpty
            ? Center(child: Text('Tu carrito está vacío', style: AppStyles.emptyCartTextStyle))
            : Padding(
                padding: AppStyles.paddingAll,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _cartItems.length,
                        itemBuilder: (context, index) {
                          final productId = _cartItems.keys.elementAt(index);
                          final quantity = _cartItems[productId]!;
                          final producto = _productos[productId];

                          return ListTile(
                            leading: producto != null
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(producto.foto),
                                    radius: 50,
                                  )
                                : null,
                            title: Text(producto?.nombre ?? 'Producto', style: AppStyles.itemTitleTextStyle),
                            subtitle: Text('\$${producto?.precio.toStringAsFixed(2) ?? '0.00'}', style: AppStyles.itemPriceTextStyle),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('x$quantity', style: AppStyles.quantityTextStyle),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _removeProduct(productId),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total', style: AppStyles.totalTextStyle),
                          Text('\$${_totalPrice.toStringAsFixed(2)}', style: AppStyles.totalPriceTextStyle),
                        ],
                      ),
                    ),
                    // Dentro del método onPressed del botón COMPRAR
ElevatedButton(
  onPressed: () async {
    if (_cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('El carrito está vacío')),
      );
      return;
    }

    final total = _totalPrice;
    final productos = _cartItems.entries.map((entry) {
      final producto = _productos[entry.key];
      return {
        'IDProducto': entry.key,
        'Nombre': producto?.nombre,
        'Cantidad': entry.value,
        'Precio': producto?.precio,
        'Foto': producto?.foto,
      };
    }).toList();

    final pagoService = FirebaseServicioPago();

    try {
      await pagoService.registrarPago(
        idUsuario: widget.usuario.idUsuario,
        nombreCliente: widget.usuario.nombre,
        total: total,
        productos: productos,
      );

      // Limpiar el carrito después de la compra
      await _clearCart();

      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Compra realizada exitosamente')),
      );

      // Redirigir a la página de historial de compras
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HistorialComprasPage(usuario: widget.usuario),
        ),
      );

    } catch (e) {
      print('Error al registrar el pago: $e');
      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al realizar la compra')),
      );
    }
  },
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.shopping_cart),
      SizedBox(width: 8),
      Text('COMPRAR'),
    ],
  ),
  style: ElevatedButton.styleFrom(
    foregroundColor: AppStyles.primaryColor,
    backgroundColor: AppStyles.whiteColor,
    padding: EdgeInsets.symmetric(vertical: 16),
    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  ),
),


                    SizedBox(height: 16),
                  ],
                ),
              ),
      ),
    );
  }
}
