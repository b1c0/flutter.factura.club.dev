import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';

class SucursalService {
  // final _url = 'https://192.168.1.2:44379';

  Future<bool> agregarNuevaSucursal(Sucursal sucursal) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Sucursal';
    final resp = await ioClient.post(
      url,
      body: (sucursalToJson(sucursal)),
      headers: {'Content-Type': 'application/json'},
    );
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<List<Sucursal>> cargarSucursales(int empresa_id) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Sucursal/$empresa_id';
    final resp = await ioClient.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    final decodeData = json.decode(resp.body);
    final sucursales = new Sucursales.fromJsonList(decodeData);
    return sucursales.items;
  }
}
