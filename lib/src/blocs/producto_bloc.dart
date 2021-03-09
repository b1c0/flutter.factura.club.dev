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

  void cargarProductos(int bodega_id) async {
    final clientes = await _productoService.cargarProductos(bodega_id);
    _productosController.sink.add(clientes);
  }

  // void actualizarProducto(Producto producto) async {
  //   await _productoService.actualizarProducto(producto);
  // }

  // void eliminarProducto(int usuario_id, int producto_id) async {
  //   await _productoService.eliminarProducto(usuario_id, producto_id);
  // }

  disposse() {
    _productosController?.close();
    _crearProductosStreamController?.close();
  }
}
