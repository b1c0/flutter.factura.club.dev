import 'dart:io';

import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'dart:convert';

import 'package:http/io_client.dart';

class UsuarioService {
  //login
  Future<Map<String, dynamic>> login(String email, String nic, String password) async {
    print('Correo:$email   Nick:$nic     clave:$password');

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);

    final url = 'https://192.168.1.2:44379/Usuario/$email,$nic,$password';
    final resp = await ioClient.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    print('====================${resp.body}');
    print('====================${resp.statusCode.toString()}');
    if (resp.statusCode == 200) {
      final decodeData = json.decode(resp.body);
      final usuario = new Usuario.infoCompleta(decodeData);

      print('====================${usuario.nicUsuario}');
      return {'ok': true, 'usuario': usuario};
    } else {
      return {'ok': false, 'mensaje': 'error'};
    }
  }

  //METODO PARA REGISTRAR USUARIOS PADRE(ADMINISTRADOR)
  Future<bool> agregarNuevoUsuario(Usuario usuario) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);

    final url = 'https://192.168.1.2:44379/api/UsuarioAdministrador';
    final resp = await ioClient.post(
      url,
      body: (usuarioToJson(usuario)),
      headers: {'Content-Type': 'application/json'},
    );
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }
}
