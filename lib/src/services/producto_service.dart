import 'dart:convert';
import 'dart:io';

import 'package:app_factura_club_dev/src/models/Producto.dart';
import 'package:http/io_client.dart';

class ProductoService {
  Future<bool> crearNuevoProducto(Producto producto) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Producto';
    final resp = await ioClient.post(
      url,
      body: (productoToJsonSinId(producto)),
      headers: {'Content-Type': 'application/json'},
    );
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<List<Producto>> cargarProductos(int bodega_id) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Producto/$bodega_id';
    final resp = await ioClient.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    final decodeData = json.decode(resp.body);
    final productos = new Productos.fromJsonList(decodeData);
    return productos.items;
  }
}
