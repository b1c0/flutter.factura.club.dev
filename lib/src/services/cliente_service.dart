import 'package:app_factura_club_dev/src/models/Cliente.dart';
import 'package:http/io_client.dart';
import 'dart:convert';
import 'dart:io';

class ClienteService {
  Future<bool> crearNuevoCliente(Cliente cliente) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Cliente';
    final resp = await ioClient.post(
      url,
      body: (clienteToJsonSinId(cliente)),
      headers: {'Content-Type': 'application/json'},
    );
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<List<Cliente>> cargarClientes(int sucursalId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Cliente/$sucursalId';
    final resp = await ioClient.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    final decodeData = json.decode(resp.body);
    final clientes = new Clientes.fromJsonList(decodeData);
    return clientes.items;
  }

  Future<bool> actualizarCliente(Cliente cliente) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Cliente/${cliente.clienteId},${cliente.usuarioId}';
    final resp = await ioClient.put(
      url,
      body: (clienteToJsonSinId(cliente)),
      headers: {'Content-Type': 'application/json'},
    );
    final decodedData = json.decode(resp.body);
    print(' ================================== $decodedData');

    return true;
  }

  Future<int> eliminarCliente(int clienteId, int usuarioId, int sucursalId) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);
    final url = 'https://192.168.1.2:44379/api/Cliente/$clienteId,$usuarioId,$sucursalId';
    final resp = await ioClient.delete(url);
    print(json.decode(resp.body));
    return 1;
  }
}
