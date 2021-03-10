import 'dart:convert';

Servicio servicioFromJson(String str) => Servicio.fromJson(json.decode(str));

String servicioToJson(Servicio data) => json.encode(data.toJson());
String servicioToJsonSinId(Servicio data) => json.encode(data.toJsonSinId());

class Servicio {
  Servicio({
    this.servicioId,
    this.servicioDescripcion,
    this.servicioTipo,
    this.sucursalId,
    this.sucursalServicioPrecio,
    this.usuarioId,
  });

  Servicio.sinId({
    this.servicioDescripcion,
    this.servicioTipo,
    this.sucursalId,
    this.sucursalServicioPrecio,
    this.usuarioId,
  });

  int servicioId;
  String servicioDescripcion;
  String servicioTipo;
  int sucursalId;
  double sucursalServicioPrecio;
  int usuarioId;

  factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
        servicioId: json["servicio_id"],
        servicioDescripcion: json["servicio_descripcion"],
        servicioTipo: json["servicio_tipo"],
        sucursalId: json["sucursal_id"],
        sucursalServicioPrecio: json["sucursal_servicio_precio"].toDouble(),
        usuarioId: json["usuario_id"],
      );

  Map<String, dynamic> toJson() => {
        "servicio_id": servicioId,
        "servicio_descripcion": servicioDescripcion,
        "servicio_tipo": servicioTipo,
        "sucursal_id": sucursalId,
        "sucursal_servicio_precio": sucursalServicioPrecio,
        "usuario_id": usuarioId,
      };

  Map<String, dynamic> toJsonSinId() => {
        "servicio_descripcion": servicioDescripcion,
        "servicio_tipo": servicioTipo,
        "sucursal_id": sucursalId,
        "sucursal_servicio_precio": sucursalServicioPrecio,
        "usuario_id": usuarioId,
      };
}

class Servicios {
  List<Servicio> items = new List();
  Servicios();
  Servicios.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final servicio = new Servicio.fromJson(item);
      items.add(servicio);
    }
  }
}
