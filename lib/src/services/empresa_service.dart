import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';

class EmpresaService {
  // final _url = 'https://192.168.1.2:44379';

  Future<bool> crearNuevaEmpresa(Empresa empresa) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Empresa';
    final resp = await ioClient.post(
      url,
      body: (empresaToJsonSinID(empresa)),
      headers: {'Content-Type': 'application/json'},
    );
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<List<Empresa>> cargarEmpresas(int usuarioId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Empresa/$usuarioId';
    final resp = await ioClient.get(url, headers: {'Content-Type': 'application/json'});
    final decodeData = json.decode(resp.body);
    final empresas = new Empresas.fromJsonList(decodeData);
    return empresas.items;
  }

  Future<bool> actualizarEmpresa(Empresa empresa) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Empresa/${empresa.usuarioId},${empresa.empresaId}';
    final resp = await ioClient.put(
      url,
      body: (empresaToJsonSinID(empresa)),
      headers: {'Content-Type': 'application/json'},
    );
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<int> eliminarEmpresa(int empresaId, int usuarioId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Empresa/$usuarioId,$empresaId';
    final resp = await ioClient.delete(url);
    print(json.decode(resp.body));
    return 1;
  }

  Future<Map<String, dynamic>> cargarEmpresaById(int empresaId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Empresa/DatosEmpresa/$empresaId';
    final resp = await ioClient.get(url, headers: {'Content-Type': 'application/json'});
    final decodeData = json.decode(resp.body);
    // print(decodeData);
    final empresa = new Empresa.fromJson(decodeData);

    return {'ok': true, 'empresa': empresa};
  }
}
