import 'dart:convert';

Sucursal sucursalFromJson(String str) => Sucursal.fromJson(json.decode(str));

String sucursalToJson(Sucursal data) => json.encode(data.toJson());

class Sucursal {
  Sucursal({
    this.sucursalNombre,
    this.sucursalCorreoCorporativo,
    this.sucursalTelefono,
    this.sucursalDireccion,
    this.sucursalRuc,
    this.empresaId,
    this.usuarioId,
  });

  String sucursalNombre;
  String sucursalCorreoCorporativo;
  String sucursalTelefono;
  String sucursalDireccion;
  String sucursalRuc;
  int empresaId;
  int usuarioId;

  factory Sucursal.fromJson(Map<String, dynamic> json) => Sucursal(
        sucursalNombre: json["sucursal_nombre"],
        sucursalCorreoCorporativo: json["sucursal_correo_corporativo"],
        sucursalTelefono: json["sucursal_telefono"],
        sucursalDireccion: json["sucursal_direccion"],
        sucursalRuc: json["sucursal_ruc"],
        empresaId: json["empresa_id"],
        usuarioId: json["usuario_id"],
      );

  Map<String, dynamic> toJson() => {
        "sucursal_nombre": sucursalNombre,
        "sucursal_correo_corporativo": sucursalCorreoCorporativo,
        "sucursal_telefono": sucursalTelefono,
        "sucursal_direccion": sucursalDireccion,
        "sucursal_ruc": sucursalRuc,
        "empresa_id": empresaId,
        "usuario_id": usuarioId,
      };
}

class Sucursales {
  List<Sucursal> items = new List();
  Sucursales();
  Sucursales.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final sucursal = new Sucursal.fromJson(item);
      items.add(sucursal);
    }
  }
}
