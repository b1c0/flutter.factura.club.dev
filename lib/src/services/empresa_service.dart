import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/utils/utils.dart';
import 'dart:convert';

import 'package:http/io_client.dart';

class EmpresaService {
  IOClient ioClient = https();
  final Map<String, String> _headers = {'Content-Type': 'application/json'};
  final _url = 'https://192.168.1.2:44379/api/Empresa';

  Future<bool> crearNuevaEmpresa(Empresa empresa) async {
    final url = _url;
    final resp = await ioClient.post(url, body: (empresaToJsonSinId(empresa)), headers: _headers);
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<List<Empresa>> cargarEmpresas(int usuarioId) async {
    final url = '$_url/$usuarioId';
    final resp = await ioClient.get(url, headers: _headers);
    final decodeData = json.decode(resp.body);
    final empresas = new Empresas.fromJsonList(decodeData);
    return empresas.items;
  }

  Future<bool> actualizarEmpresa(Empresa empresa) async {
    final url = '$_url/${empresa.usuarioId},${empresa.empresaId}';
    final resp = await ioClient.put(url, body: (empresaToJsonSinId(empresa)), headers: _headers);
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<int> eliminarEmpresa(int empresaId, int usuarioId) async {
    final url = '$_url/$usuarioId,$empresaId';
    final resp = await ioClient.delete(url);
    print(json.decode(resp.body));
    return 1;
  }

  Future<Map<String, dynamic>> cargarEmpresaById(int empresaId) async {
    final url = '$_url/DatosEmpresa/$empresaId';
    final resp = await ioClient.get(url, headers: _headers);
    final decodeData = json.decode(resp.body);
    final empresa = new Empresa.fromJson(decodeData);
    return {'ok': true, 'empresa': empresa};
  }
}
