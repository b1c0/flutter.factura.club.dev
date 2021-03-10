import 'dart:convert';
import 'dart:io';

import 'package:app_factura_club_dev/src/models/Categoria.dart';
import 'package:http/io_client.dart';

class CategoriaService {
  IOClient https() {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    return ioClient;
  }

  Future<bool> crearNuevaBodega(Categoria categoria) async {
    final url = 'https://192.168.1.2:44379/api/Categoria';
    final resp = await https().post(
      url,
      body: (categoriaToJson(categoria)),
      headers: {'Content-Type': 'application/json'},
    );
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');
    return true;
  }
}
