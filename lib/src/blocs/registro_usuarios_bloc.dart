import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:app_factura_club_dev/src/services/registro_usuarios_service.dart';
import 'package:rxdart/subjects.dart';

class RegistroUsuariosBloc {
  final _registroUsuarioStreamController = BehaviorSubject<Usuario>();
  final _registroUsuarioService = RegistroUsuarioService();

  void registrarUsuario(Usuario usuario) async {
    await _registroUsuarioService.agregarNuevoUsuario(usuario);
  }

  void dispose() {
    _registroUsuarioStreamController?.close();
  }
}
