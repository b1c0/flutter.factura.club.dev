import 'dart:convert';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:app_factura_club_dev/src/utils/utils.dart';

import 'package:http/io_client.dart';

class UsuarioService {
  final Map<String, String> _headers = {'Content-Type': 'application/json'};
  final _url = 'https://192.168.1.2:44379/Usuario';

  //login
  Future<Map<String, dynamic>> login(String email, String nic, String password) async {
    IOClient ioClient = https();
    final url = '$_url/$email,$nic,$password';
    final resp = await ioClient.get(url, headers: _headers);
    if (resp.statusCode == 200) {
      final decodeData = json.decode(resp.body);
      final usuario = new Usuario.infoCompleta(decodeData);
      print('====================${usuario.nicUsuario}');
      return {'ok': true, 'usuario': usuario};
    } else {
      return {'ok': false, 'mensaje': 'Usuario o contraseña incorrecto'};
    }
  }

  //METODO PARA REGISTRAR USUARIOS PADRE(ADMINISTRADOR)
  Future<Map<String, dynamic>> agregarNuevoUsuario(Usuario usuario) async {
    IOClient ioClient = https();
    final url = 'https://192.168.1.2:44379/api/UsuarioAdministrador';
    final resp = await ioClient.post(url, body: (usuarioToJson(usuario)), headers: _headers);
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');
    return {'ok': decodedData['exito'], 'mensaje': decodedData['mensaje']};
  }
}
