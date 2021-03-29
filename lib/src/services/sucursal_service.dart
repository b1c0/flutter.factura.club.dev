import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:app_factura_club_dev/src/utils/utils.dart';
import 'package:http/io_client.dart';
import 'dart:convert';

class SucursalService {
  final Map<String, String> _headers = {'Content-Type': 'application/json'};
  final _url = 'https://192.168.1.2:44379/api/Sucursal';

  Future<bool> crearNuevaSucursal(Sucursal sucursal) async {
    IOClient ioClient = https();
    final url = _url;
    final resp = await ioClient.post(url, body: (sucursalToJsonSinId(sucursal)), headers: _headers);
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<List<Sucursal>> cargarSucursales(int empresaId) async {
    IOClient ioClient = https();
    final url = '$_url/$empresaId';
    final resp = await ioClient.get(url, headers: _headers);
    final decodeData = json.decode(resp.body);
    final sucursales = new Sucursales.fromJsonList(decodeData);
    return sucursales.items;
  }

  Future<bool> actualizarSucursal(Sucursal sucursal) async {
    IOClient ioClient = https();

    final url = '$_url/${sucursal.usuarioId},${sucursal.sucursalId}';
    final resp = await ioClient.put(url, body: (sucursalToJsonSinId(sucursal)), headers: _headers);
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<int> eliminarSucursal(int usuarioId, int sucursalId) async {
    IOClient ioClient = https();
    final url = '$_url/$usuarioId,$sucursalId';
    final resp = await ioClient.delete(url);
    print(json.decode(resp.body));
    return 1;
  }
}
