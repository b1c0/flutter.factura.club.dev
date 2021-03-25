import 'dart:convert';
import 'dart:io';

import 'package:app_factura_club_dev/src/models/Categoria.dart';
import 'package:http/io_client.dart';

class CategoriaService {
  Future<bool> crearNuevaCategoria(Categoria categoria) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Categoria';
    final resp = await ioClient.post(
      url,
      body: (categoriaToJsonSinId(categoria)),
      headers: {'Content-Type': 'application/json'},
    );
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');
    return true;
  }

  Future<List<Categoria>> cargarCategorias(int empresaId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Categoria/$empresaId';
    final resp = await ioClient.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    final decodeData = json.decode(resp.body);
    final categorias = new Categorias.fromJsonList(decodeData);
    return categorias.items;
  }
}
