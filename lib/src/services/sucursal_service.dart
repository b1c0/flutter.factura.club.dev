import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:http/io_client.dart';
import 'dart:convert';
import 'dart:io';

class SucursalService {
  Future<bool> crearNuevaSucursal(Sucursal sucursal) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Sucursal';
    final resp = await ioClient.post(
      url,
      body: (sucursalToJsonSinID(sucursal)),
      headers: {'Content-Type': 'application/json'},
    );
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<List<Sucursal>> cargarSucursales(int empresaId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Sucursal/$empresaId';
    final resp = await ioClient.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    final decodeData = json.decode(resp.body);
    final sucursales = new Sucursales.fromJsonList(decodeData);
    return sucursales.items;
  }

  Future<bool> actualizarSucursal(Sucursal sucursal) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Sucursal/${sucursal.usuarioId},${sucursal.sucursalId}';
    final resp = await ioClient.put(
      url,
      body: (sucursalToJsonSinID(sucursal)),
      headers: {'Content-Type': 'application/json'},
    );
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<int> eliminarSucursal(int usuarioId, int sucursalId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Sucursal/$usuarioId,$sucursalId';
    final resp = await ioClient.delete(url);
    print(json.decode(resp.body));
    return 1;
  }
}
