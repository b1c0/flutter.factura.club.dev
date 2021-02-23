import 'dart:io';

import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/io_client.dart';

class RegistroUsuarioService {
  // final _url = 'https://192.168.1.2:44379';

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
