import 'package:app_factura_club_dev/src/models/Producto.dart';
import 'package:app_factura_club_dev/src/services/producto_service.dart';
import 'package:rxdart/rxdart.dart';

class ProductoBloc {
  final _productosController = BehaviorSubject<List<Producto>>();
  final _crearProductosStreamController = BehaviorSubject<Producto>();
  final _productoService = ProductoService();

  Stream<List<Producto>> get productosStream => _productosController.stream;

  void crearNuevoProducto(Producto producto) async {
    await _productoService.crearNuevoProducto(producto);
  }

  void cargarProductos(int bodegaId) async {
    final clientes = await _productoService.cargarProductos(bodegaId);
    _productosController.sink.add(clientes);
  }

  void actualizarProducto(Producto producto) async {
    await _productoService.actualizarProducto(producto);
  }

  void eliminarProducto(int usuarioId, int productoId) async {
    await _productoService.eliminarProducto(usuarioId, productoId);
  }

  disposse() {
    _productosController?.close();
    _crearProductosStreamController?.close();
  }
}
