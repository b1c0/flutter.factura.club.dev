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

  void cargarSucursales(int empresa_id) async {
    final sucursales = await _sucursalService.cargarSucursales(empresa_id);
    _sucursalesController.sink.add(sucursales);
  }

  void actualizarSucursal(Sucursal sucursal) async {
    await _sucursalService.actualizarSucursal(sucursal);
  }

  void eliminarSucursal(int usuario_id, int sucursal_id) async {
    await _sucursalService.eliminarSucursal(usuario_id, sucursal_id);
  }

  void dispose() {
    _sucursalesController?.close();
    _crearSucursalStreamController?.close();
  }
}
