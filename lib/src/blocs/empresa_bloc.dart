import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/services/empresa_service.dart';
import 'package:rxdart/subjects.dart';

class EmpresaBloc {
  final _empresasController = BehaviorSubject<List<Empresa>>();
  final _crearEmpresaStreamController = BehaviorSubject<Empresa>();
  final _empresaService = EmpresaService();

  Stream<List<Empresa>> get empresasStream => _empresasController.stream;

  void crearNuevaEmpresa(Empresa empresa) async {
    await _empresaService.crearNuevaEmpresa(empresa);
  }

  void cargarEmpresas(int usuarioId) async {
    final empresas = await _empresaService.cargarEmpresas(usuarioId);
    _empresasController.sink.add(empresas);
  }

  void actualizarEmpresa(Empresa empresa) async {
    await _empresaService.actualizarEmpresa(empresa);
  }

  void eliminarEmpresa(int empresaId, int usuarioId) async {
    await _empresaService.eliminarEmpresa(empresaId, usuarioId);
  }

  void dispose() {
    _empresasController?.close();
    _crearEmpresaStreamController?.close();
  }
}
