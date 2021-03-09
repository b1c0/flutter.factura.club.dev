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

  Future<List<Producto>> cargarProductos(int bodegaId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Producto/$bodegaId';
    final resp = await ioClient.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    final decodeData = json.decode(resp.body);
    final productos = new Productos.fromJsonList(decodeData);
    return productos.items;
  }

  Future<bool> actualizarProducto(Producto producto) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Producto/${producto.productoBodegaId}';
    final resp = await ioClient.put(
      url,
      body: (productoToJsonSinId(producto)),
      headers: {'Content-Type': 'application/json'},
    );
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<int> eliminarProducto(int usuarioId, int productoId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Producto/$usuarioId,$productoId';
    final resp = await ioClient.delete(url);
    print(json.decode(resp.body));
    return 1;
  }
}
