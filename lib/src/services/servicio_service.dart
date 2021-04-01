import 'dart:convert';

import 'package:app_factura_club_dev/src/models/Servicio.dart';
import 'package:app_factura_club_dev/src/utils/utils.dart';
import 'package:http/io_client.dart';

class ServicioService {
  IOClient ioClient = https();
  final Map<String, String> _headers = {'Content-Type': 'application/json'};
  final _url = 'https://192.168.1.2:44379/api/Servicio';

  Future<bool> crearNuevoServicio(Servicio servicio) async {
    final url = _url;
    final resp = await ioClient.post(url, body: (servicioToJsonSinId(servicio)), headers: _headers);
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');
    return true;
  }

  Future<List<Servicio>> cargarServicio(int sucursalId) async {
    final url = '$_url/$sucursalId';
    final resp = await ioClient.get(url, headers: _headers);
    final decodeData = json.decode(resp.body);
    final servicios = new Servicios.fromJsonList(decodeData);
    return servicios.items;
  }

  Future<bool> actualizarServicio(Servicio servicio) async {
    final url = '$_url/${servicio.servicioId},${servicio.usuarioId}';
    final resp = await ioClient.put(url, body: (servicioToJsonSinId(servicio)), headers: _headers);
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<int> eliminarServicio(int servicioId, int usuarioId) async {
    final url = '$_url/$servicioId,$usuarioId';
    final resp = await ioClient.delete(url);
    print(json.decode(resp.body));
    return 1;
  }
}
