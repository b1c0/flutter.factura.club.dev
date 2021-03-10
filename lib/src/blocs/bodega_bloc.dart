import 'package:app_factura_club_dev/src/models/Bodega.dart';
import 'package:app_factura_club_dev/src/services/bodega_service.dart';
import 'package:rxdart/rxdart.dart';

class BodegaBloc {
  final _bodegasController = BehaviorSubject<List<Bodega>>();
  final _crearBodegaStreamController = BehaviorSubject<Bodega>();
  final _bodegaService = BodegaService();

  Stream<List<Bodega>> get bodegasStream => _bodegasController.stream;

  void crearNuevaBodega(Bodega bodega) async {
    await _bodegaService.crearNuevaBodega(bodega);
  }

  void cargarBodegas(int empresaId) async {
    final empresas = await _bodegaService.cargarBodegas(empresaId);
    _bodegasController.sink.add(empresas);
  }

  void actualizarBodega(Bodega bodega) async {
    await _bodegaService.actualizarBodega(bodega);
  }

  void eliminarBodega(int usuarioId, int bodegaId) async {
    await _bodegaService.eliminarBodega(usuarioId, bodegaId);
  }

  void dispose() {
    _bodegasController?.close();
    _crearBodegaStreamController?.close();
  }
}
