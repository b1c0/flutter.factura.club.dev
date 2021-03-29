import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJson(Cliente data) => json.encode(data.toJson());

String clienteToJsonSinId(Cliente data) => json.encode(data.toJsonSinId());

class Cliente {
  int clienteId;
  int sucursalId;
  String clienteIdentificacion;
  String clienteNombres;
  String clienteCelular;
  String clienteTelefono;
  String clienteCorreo;
  String clienteDireccion;
  int usuarioId;

  Cliente({
    this.clienteId,
    this.sucursalId,
    this.clienteIdentificacion,
    this.clienteNombres,
    this.clienteCelular,
    this.clienteTelefono,
    this.clienteCorreo,
    this.clienteDireccion,
    this.usuarioId,
  });

  //CONSTRUCTOR PARA CREAR CLIENTE EN EL API
  Cliente.sinId({
    this.sucursalId,
    this.clienteIdentificacion,
    this.clienteNombres,
    this.clienteCelular,
    this.clienteTelefono,
    this.clienteCorreo,
    this.clienteDireccion,
    this.usuarioId,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        clienteId: json["cliente_id"],
        sucursalId: json["sucursal_id"],
        clienteIdentificacion: json["cliente_identificacion"],
        clienteNombres: json["cliente_nombres"],
        clienteCelular: json["cliente_celular"],
        clienteTelefono: json["cliente_telefono"],
        clienteCorreo: json["cliente_correo"],
        clienteDireccion: json["cliente_direccion"],
        usuarioId: json["usuario_id"],
      );

  Map<String, dynamic> toJson() => {
        "cliente_id": clienteId,
        "sucursal_id": sucursalId,
        "cliente_identificacion": clienteIdentificacion,
        "cliente_nombres": clienteNombres,
        "cliente_celular": clienteCelular,
        "cliente_telefono": clienteTelefono,
        "cliente_correo": clienteCorreo,
        "cliente_direccion": clienteDireccion,
        "usuario_id": usuarioId,
      };
  Map<String, dynamic> toJsonSinId() => {
        "sucursal_id": sucursalId,
        "cliente_identificacion": clienteIdentificacion,
        "cliente_nombres": clienteNombres,
        "cliente_celular": clienteCelular,
        "cliente_telefono": clienteTelefono,
        "cliente_correo": clienteCorreo,
        "cliente_direccion": clienteDireccion,
        "usuario_id": usuarioId,
      };
}

//CLASE PARA LISTAR CLIENTES
class Clientes {
  List<Cliente> items = [];
  Clientes();
  Clientes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final cliente = new Cliente.fromJson(item);
      items.add(cliente);
    }
  }
}
