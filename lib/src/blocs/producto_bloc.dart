import 'package:app_factura_club_dev/src/models/Producto.dart';
import 'package:app_factura_club_dev/src/services/producto_service.dart';
import 'package:rxdart/rxdart.dart';

class ProductoBloc {
  final _productosController = BehaviorSubject<List<Producto>>();
  final _cargandoController = BehaviorSubject<bool>();
  final _crearProductosStreamController = BehaviorSubject<Producto>();
  final _productoService = ProductoService();

  Stream<List<Producto>> get productosStream => _productosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void crearNuevoProducto(Producto producto) async {
    _cargandoController.sink.add(true);
    await _productoService.crearNuevoProducto(producto);
    _cargandoController.sink.add(false);
  }

  void cargarProductos(int bodegaId) async {
    _cargandoController.sink.add(true);
    final clientes = await _productoService.cargarProductos(bodegaId);
    _productosController.sink.add(clientes);
    _cargandoController.sink.add(false);
  }

  void actualizarProducto(Producto producto) async {
    _cargandoController.sink.add(true);
    await _productoService.actualizarProducto(producto);
    _cargandoController.sink.add(false);
  }

  void eliminarProducto(int usuarioId, int productoId) async {
    await _productoService.eliminarProducto(usuarioId, productoId);
  }

  disposse() {
    _productosController?.close();
    _cargandoController?.close();
    _crearProductosStreamController?.close();
  }
}
