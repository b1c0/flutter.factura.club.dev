import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Bodega.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:rxdart/rxdart.dart';

class ArgumentosBloc {
  final _empresaController = BehaviorSubject<Empresa>();
  final _bodegaController = BehaviorSubject<Bodega>();
  final _sucursalController = BehaviorSubject<Sucursal>();
  final _argumentosController = BehaviorSubject<Argumentos>();

  Stream<Empresa> get empresaStream => _empresaController.stream;
  Stream<Bodega> get bodegaStream => _bodegaController.stream;
  Stream<Sucursal> get sucursalStream => _sucursalController.stream;
  Stream<Argumentos> get argumentosStream => _argumentosController.stream;

  void crearArgumentos(Argumentos argumentos) {
    // (Empresa empresa, Sucursal sucursal, Bodega bodega) {
    //   _empresaController.sink.add(empresa);
    //   _sucursalController.sink.add(sucursal);
    //   _bodegaController.sink.add(bodega);
    _argumentosController.sink.add(argumentos);
    // print(bodega.bodegaId);
  }

  void dispose() {
    _argumentosController?.close();
    _empresaController?.close();
    _bodegaController?.close();
    _sucursalController?.close();
  }
}
