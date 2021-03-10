import 'package:app_factura_club_dev/src/models/Categoria.dart';
import 'package:app_factura_club_dev/src/services/categoria_service.dart';
import 'package:rxdart/rxdart.dart';

class CategoriaBloc {
  final _crearCategoriaStreamController = BehaviorSubject<Categoria>();
  final _categoriaService = CategoriaService();

  // Stream<List<Bodega>> get bodegasStream => _bodegasController.stream;

  void crearNuevaBodega(Categoria categoria) async {
    await _categoriaService.crearNuevaBodega(categoria);
  }

  dispose() {
    _crearCategoriaStreamController?.close();
  }
}
