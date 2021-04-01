import 'dart:convert';

import 'package:app_factura_club_dev/src/models/Producto.dart';
import 'package:app_factura_club_dev/src/utils/utils.dart';
import 'package:http/io_client.dart';

class ProductoService {
  IOClient ioClient = https();
  final Map<String, String> _headers = {'Content-Type': 'application/json'};
  final _url = 'https://192.168.1.2:44379/api/Producto';

  Future<bool> crearNuevoProducto(Producto producto) async {
    final url = _url;
    final resp = await ioClient.post(url, body: (productoToJsonSinId(producto)), headers: _headers);
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<List<Producto>> cargarProductos(int bodegaId) async {
    final url = '$_url/$bodegaId';
    final resp = await ioClient.get(url, headers: _headers);
    final decodeData = json.decode(resp.body);
    final productos = new Productos.fromJsonList(decodeData);
    return productos.items;
  }

  Future<bool> actualizarProducto(Producto producto) async {
    final url = '$_url/${producto.productoBodegaId},${producto.categoriaId}';
    final resp = await ioClient.put(url, body: (productoToJsonSinId(producto)), headers: _headers);
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<int> eliminarProducto(int usuarioId, int productoId) async {
    final url = '$_url/$usuarioId,$productoId';
    final resp = await ioClient.delete(url);
    print(json.decode(resp.body));
    return 1;
  }
}
