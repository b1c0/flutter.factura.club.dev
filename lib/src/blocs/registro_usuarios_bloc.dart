import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:app_factura_club_dev/src/services/usuarios_service.dart';
import 'package:rxdart/subjects.dart';

class RegistroUsuariosBloc {
  final _registroUsuarioStreamController = BehaviorSubject<Usuario>();
  final _usuarioService = UsuarioService();
  final _getUsuarioController = BehaviorSubject<Map<String, dynamic>>();

  void registrarUsuario(Usuario usuario) async {
    await _usuarioService.agregarNuevoUsuario(usuario);
  }

  void cargarUsuario(String correo, String nic, String clave) async {
    final usuario = await _usuarioService.login(correo, nic, clave);
    _getUsuarioController.sink.add(usuario);
  }

  void dispose() {
    _getUsuarioController?.close();
    _registroUsuarioStreamController?.close();
  }
}
