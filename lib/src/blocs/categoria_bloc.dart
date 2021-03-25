import 'package:app_factura_club_dev/src/models/Categoria.dart';
import 'package:app_factura_club_dev/src/services/categoria_service.dart';
import 'package:rxdart/rxdart.dart';

class CategoriaBloc {
  final _categoriasController = BehaviorSubject<List<Categoria>>();

  final _crearCategoriaStreamController = BehaviorSubject<Categoria>();
  final _categoriaService = CategoriaService();

  Stream<List<Categoria>> get categoriasStream => _categoriasController.stream;

  void crearNuevaCategoria(Categoria categoria) async {
    await _categoriaService.crearNuevaCategoria(categoria);
  }

  void cargarCategorias(int empresaId) async {
    final empresas = await _categoriaService.cargarCategorias(empresaId);
    _categoriasController.sink.add(empresas);
  }

  dispose() {
    _crearCategoriaStreamController?.close();
    _categoriasController?.close();
  }
}
