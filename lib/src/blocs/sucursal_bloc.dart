import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:app_factura_club_dev/src/services/sucursal_service.dart';
import 'package:rxdart/subjects.dart';

class SucursalBloc {
  final _sucursalesController = BehaviorSubject<List<Sucursal>>();
  final _crearSucursalStreamController = BehaviorSubject<Sucursal>();
  final _sucursalService = SucursalService();

  Stream<List<Sucursal>> get sucursalesStream => _sucursalesController.stream;

  void crearNuevaSucursal(Sucursal sucursal) async {
    await _sucursalService.crearNuevaSucursal(sucursal);
  }

  void cargarSucursales(int empresaId) async {
    final sucursales = await _sucursalService.cargarSucursales(empresaId);
    _sucursalesController.sink.add(sucursales);
  }

  void actualizarSucursal(Sucursal sucursal) async {
    await _sucursalService.actualizarSucursal(sucursal);
  }

  void eliminarSucursal(int usuarioId, int sucursalId) async {
    await _sucursalService.eliminarSucursal(usuarioId, sucursalId);
  }

  void dispose() {
    _sucursalesController?.close();
    _crearSucursalStreamController?.close();
  }
}
