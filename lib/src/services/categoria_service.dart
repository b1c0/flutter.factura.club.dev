import 'dart:convert';

import 'package:app_factura_club_dev/src/models/Categoria.dart';
import 'package:app_factura_club_dev/src/utils/utils.dart';
import 'package:http/io_client.dart';

class CategoriaService {
  IOClient ioClient = https(); // Instancia para la coneccion con https
  final Map<String, String> _headers = {'Content-Type': 'application/json'}; // header necesario para las peticiones
  final _url = 'https://192.168.1.2:44379/api/Categoria'; // endpoint del API

  //CREATE
  Future<bool> crearNuevaCategoria(Categoria categoria) async {
    final url = _url;
    final resp = await ioClient.post(url, body: (categoriaToJsonSinId(categoria)), headers: _headers);
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');
    return true;
  }

  //READ
  Future<List<Categoria>> cargarCategorias(int empresaId) async {
    final url = '$_url/$empresaId';
    final resp = await ioClient.get(url, headers: _headers);
    final decodeData = json.decode(resp.body);
    final categorias = new Categorias.fromJsonList(decodeData);
    return categorias.items;
  }

  //DELETE
  Future<int> eliminarcategoria(int categoriaId, int usuarioId) async {
    final url = '$_url/$categoriaId,$usuarioId';
    final resp = await ioClient.delete(url);
    print(json.decode(resp.body));
    return 1;
  }
}
