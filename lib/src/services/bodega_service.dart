import 'package:app_factura_club_dev/src/models/Bodega.dart';
import 'package:app_factura_club_dev/src/utils/utils.dart';
import 'package:http/io_client.dart';
import 'dart:convert';

class BodegaService {
  final Map<String, String> _headers = {'Content-Type': 'application/json'};
  final _url = 'https://192.168.1.2:44379/api/Bodega';

  Future<bool> crearNuevaBodega(Bodega bodega) async {
    IOClient ioClient = https();
    final url = _url;
    final resp = await ioClient.post(url, body: (bodegaToJsonSinId(bodega)), headers: _headers);
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<List<Bodega>> cargarBodegas(int empresaId) async {
    IOClient ioClient = https();
    final url = '$_url/$empresaId';
    final resp = await ioClient.get(url, headers: _headers);
    final decodeData = json.decode(resp.body);
    final sucursales = new Bodegas.fromJsonList(decodeData);
    return sucursales.items;
  }

  Future<bool> actualizarBodega(Bodega bodega) async {
    IOClient ioClient = https();
    final url = '$_url/${bodega.bodegaId},${bodega.usuarioId}';
    final resp = await ioClient.put(url, body: (bodegaToJsonSinId(bodega)), headers: _headers);
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<int> eliminarBodega(int usuarioId, int bodegaId) async {
    IOClient ioClient = https();
    final url = '$_url/$usuarioId,$bodegaId';
    final resp = await ioClient.delete(url);
    print(json.decode(resp.body));
    return 1;
  }
}
