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

  void cargarBodegas(int empresa_id) async {
    final empresas = await _bodegaService.cargarBodegas(empresa_id);
    _bodegasController.sink.add(empresas);
  }

  void actualizarBodega(Bodega bodega) async {
    await _bodegaService.actualizarBodega(bodega);
  }

  void eliminarBodega(int usuario_id, int bodega_id) async {
    await _bodegaService.eliminarBodega(usuario_id, bodega_id);
  }

  void dispose() {
    _bodegasController?.close();
    _crearBodegaStreamController?.close();
  }
}
