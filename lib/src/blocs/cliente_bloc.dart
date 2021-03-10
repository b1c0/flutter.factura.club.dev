import 'package:app_factura_club_dev/src/models/Cliente.dart';
import 'package:app_factura_club_dev/src/services/cliente_service.dart';
import 'package:rxdart/rxdart.dart';

class ClienteBloc {
  final _clientesController = BehaviorSubject<List<Cliente>>();
  final _crearClienteStreamController = BehaviorSubject<Cliente>();
  final _clienteService = ClienteService();

  Stream<List<Cliente>> get clientesStream => _clientesController.stream;

  void crearNuevoCliente(Cliente cliente) async {
    await _clienteService.crearNuevoCliente(cliente);
  }

  void cargarClientes(int sucursalId) async {
    final clientes = await _clienteService.cargarClientes(sucursalId);
    _clientesController.sink.add(clientes);
  }

  void actualizarClientes(Cliente cliente) async {
    await _clienteService.actualizarCliente(cliente);
  }

  void eliminarCliente(int clienteId, int usuarioId, int sucursalId) async {
    await _clienteService.eliminarCliente(clienteId, usuarioId, sucursalId);
  }

  void dispose() {
    _clientesController?.close();
    _crearClienteStreamController?.close();
  }
}
