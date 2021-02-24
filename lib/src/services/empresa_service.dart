import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';

class EmpresaService {
  // final _url = 'https://192.168.1.2:44379';

  Future<bool> agregarNuevaEmpresa(Empresa empresa) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/Empresa';
    final resp = await ioClient.post(
      url,
      body: (empresaToJsonSinID(empresa)),
      headers: {'Content-Type': 'application/json'},
    );
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<List<Empresa>> cargarEmpresas(int usuario_id) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/Empresa/$usuario_id';
    final resp = await ioClient.get(url, headers: {'Content-Type': 'application/json'});
    final decodeData = json.decode(resp.body);
    final empresas = new Empresas.fromJsonList(decodeData);
    return empresas.items;
  }
}
