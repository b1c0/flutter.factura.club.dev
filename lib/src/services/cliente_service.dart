import 'package:app_factura_club_dev/src/models/Cliente.dart';
import 'package:app_factura_club_dev/src/utils/utils.dart';
import 'package:http/io_client.dart';
import 'dart:convert';

class ClienteService {
  final Map<String, String> _headers = {'Content-Type': 'application/json'};
  final _url = 'https://192.168.1.2:44379/api/Cliente';

  Future<bool> crearNuevoCliente(Cliente cliente) async {
    IOClient ioClient = https();
    final url = _url;
    final resp = await ioClient.post(url, body: (clienteToJsonSinId(cliente)), headers: _headers);
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');
    return true;
  }

  Future<List<Cliente>> cargarClientes(int sucursalId) async {
    IOClient ioClient = https();
    final url = '$_url/$sucursalId';
    final resp = await ioClient.get(url, headers: _headers);
    final decodeData = json.decode(resp.body);
    final clientes = new Clientes.fromJsonList(decodeData);
    return clientes.items;
  }

  Future<bool> actualizarCliente(Cliente cliente) async {
    IOClient ioClient = https();
    final url = '$_url/${cliente.clienteId},${cliente.usuarioId}';
    final resp = await ioClient.put(url, body: (clienteToJsonSinId(cliente)), headers: _headers);
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');
    return true;
  }

  Future<int> eliminarCliente(int clienteId, int usuarioId, int sucursalId) async {
    IOClient ioClient = https();
    final url = '$_url/$clienteId,$usuarioId,$sucursalId';
    final resp = await ioClient.delete(url);
    print(json.decode(resp.body));
    return 1;
  }
}
