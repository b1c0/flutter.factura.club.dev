import 'dart:convert';
import 'dart:io';

import 'package:app_factura_club_dev/src/models/Servicio.dart';
import 'package:http/io_client.dart';

class ServicioService {
  Future<bool> crearNuevoServicio(Servicio servicio) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Servicio';
    final resp = await ioClient.post(
      url,
      body: (servicioToJsonSinId(servicio)),
      headers: {'Content-Type': 'application/json'},
    );
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<List<Servicio>> cargarServicio(int sucursalId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Servicio/$sucursalId';
    final resp = await ioClient.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    final decodeData = json.decode(resp.body);
    final servicios = new Servicios.fromJsonList(decodeData);
    return servicios.items;
  }
}
