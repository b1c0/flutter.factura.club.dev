import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:app_factura_club_dev/src/services/empresa_service.dart';
import 'package:app_factura_club_dev/src/services/sucursal_service.dart';
import 'package:rxdart/subjects.dart';

class SucursalBloc {
  final _sucursalesController = BehaviorSubject<List<Sucursal>>();
  final _crearSucursalStreamController = BehaviorSubject<Sucursal>();
  final _sucursalService = SucursalService();

  Stream<List<Sucursal>> get sucursalesStream => _sucursalesController.stream;

  void crearNuevaSucursal(Sucursal sucursal) async {
    await _sucursalService.agregarNuevaSucursal(sucursal);
  }

  void cargarSucursales(int empresa_id) async {
    final empresas = await _sucursalService.cargarSucursales(empresa_id);
    _sucursalesController.sink.add(empresas);
  }

  void dispose() {
    _sucursalesController?.close();
    _crearSucursalStreamController?.close();
  }
}
