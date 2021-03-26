import 'package:app_factura_club_dev/src/models/Bodega.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:rxdart/rxdart.dart';

class AgumentosBloc {
  final _empresaController = BehaviorSubject<Empresa>();
  final _bodegaController = BehaviorSubject<Bodega>();
  final _sucursalController = BehaviorSubject<Sucursal>();

  Stream<Empresa> get empresaStream => _empresaController.stream;
  Stream<Bodega> get bodegaStream => _bodegaController.stream;
  Stream<Sucursal> get sucursalStream => _sucursalController.stream;

  void pickItem(Empresa empresa, Sucursal sucursal, Bodega, bodega) {
    _empresaController.sink.add(empresa);
    _sucursalController.sink.add(sucursal);
    _bodegaController.sink.add(bodega);
  }

  void dispose() {
    _empresaController?.close();
    _bodegaController?.close();
    _sucursalController?.close();
  }
}
