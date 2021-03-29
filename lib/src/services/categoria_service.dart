import 'dart:convert';

import 'package:app_factura_club_dev/src/models/Categoria.dart';
import 'package:app_factura_club_dev/src/utils/utils.dart';
import 'package:http/io_client.dart';

class CategoriaService {
  final Map<String, String> _headers = {'Content-Type': 'application/json'};
  final _url = 'https://192.168.1.2:44379/api/Categoria';

  Future<bool> crearNuevaCategoria(Categoria categoria) async {
    IOClient ioClient = https();
    final url = _url;
    final resp = await ioClient.post(url, body: (categoriaToJsonSinId(categoria)), headers: _headers);
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');
    return true;
  }

  Future<List<Categoria>> cargarCategorias(int empresaId) async {
    IOClient ioClient = https();
    final url = '$_url/$empresaId';
    final resp = await ioClient.get(url, headers: _headers);
    final decodeData = json.decode(resp.body);
    final categorias = new Categorias.fromJsonList(decodeData);
    return categorias.items;
  }
}
