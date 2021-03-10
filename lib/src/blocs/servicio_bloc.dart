import 'package:app_factura_club_dev/src/models/Servicio.dart';
import 'package:app_factura_club_dev/src/services/servicio_service.dart';
import 'package:rxdart/rxdart.dart';

class ServicioBloc {
  final _serviciosController = BehaviorSubject<List<Servicio>>();
  final _crearServiciosStreamController = BehaviorSubject<Servicio>();
  final _servicioService = ServicioService();

  Stream<List<Servicio>> get serviciosStream => _serviciosController.stream;

  void crearNuevoServicio(Servicio servicio) async {
    await _servicioService.crearNuevoServicio(servicio);
  }

  void cargarServicios(int sucursalId) async {
    final servicios = await _servicioService.cargarServicio(sucursalId);
    _serviciosController.sink.add(servicios);
  }

  disposse() {
    _serviciosController?.close();
    _crearServiciosStreamController?.close();
  }
}
