import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/services/empresa_service.dart';
import 'package:rxdart/subjects.dart';

class EmpresaBloc {
  final _empresasController = BehaviorSubject<List<Empresa>>();
  final _crearEmpresaStreamController = BehaviorSubject<Empresa>();
  final _empresaService = EmpresaService();

  Stream<List<Empresa>> get empresasStream => _empresasController.stream;

  void crearNuevaEmpresa(Empresa empresa) async {
    await _empresaService.agregarNuevaEmpresa(empresa);
  }

  void cargarEmpresas(int usuario_id) async {
    final empresas = await _empresaService.cargarEmpresas(usuario_id);
    _empresasController.sink.add(empresas);
  }

  void actualizarEmpresa(Empresa empresa) async {
    await _empresaService.actualizarEmpresa(empresa);
  }

  void eliminarEmpresa(int empresa_id, int usuario_id) async {
    await _empresaService.eliminarEmpresa(empresa_id, usuario_id);
  }

  void dispose() {
    _empresasController?.close();
    _crearEmpresaStreamController?.close();
  }
}
