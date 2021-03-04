import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJsonSinId(Cliente data) => json.encode(data.toJson());

class Cliente {
  Cliente({
    this.sucursalId,
    this.clienteIdentificacion,
    this.clienteNombres,
    this.clienteCelular,
    this.clienteTelefono,
    this.clienteCorreo,
    this.clienteDireccion,
    this.usuarioId,
  });

  int sucursalId;
  String clienteIdentificacion;
  String clienteNombres;
  String clienteCelular;
  String clienteTelefono;
  String clienteCorreo;
  String clienteDireccion;
  int usuarioId;

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
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

class Clientes {
  List<Cliente> items = new List();
  Clientes();
  Clientes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final sucursal = new Cliente.fromJson(item);
      items.add(sucursal);
    }
  }
}
