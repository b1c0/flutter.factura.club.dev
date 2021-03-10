import 'package:app_factura_club_dev/src/models/Bodega.dart';
import 'package:http/io_client.dart';
import 'dart:convert';
import 'dart:io';

class BodegaService {
  Future<bool> crearNuevaBodega(Bodega bodega) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Bodega';
    final resp = await ioClient.post(
      url,
      body: (bodegaToJsonSinID(bodega)),
      headers: {'Content-Type': 'application/json'},
    );
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<List<Bodega>> cargarBodegas(int empresaId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Bodega/$empresaId';
    final resp = await ioClient.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    final decodeData = json.decode(resp.body);
    final sucursales = new Bodegas.fromJsonList(decodeData);
    return sucursales.items;
  }

  Future<bool> actualizarBodega(Bodega bodega) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Bodega/${bodega.bodegaId},${bodega.usuarioId}';
    final resp = await ioClient.put(
      url,
      body: (bodegaToJsonSinID(bodega)),
      headers: {'Content-Type': 'application/json'},
    );
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<int> eliminarBodega(int usuarioId, int bodegaId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Bodega/$usuarioId,$bodegaId';
    final resp = await ioClient.delete(url);
    print(json.decode(resp.body));
    return 1;
  }
}
