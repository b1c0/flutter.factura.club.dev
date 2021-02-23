import 'dart:convert';

Bodega bodegaFromJson(String str) => Bodega.fromJson(json.decode(str));

String bodegaToJson(Bodega data) => json.encode(data.toJson());

class Bodega {
  Bodega({
    this.bodegaId,
    this.bodegaNombre,
    this.bodegaProvincia,
    this.bodegaDireccion,
    this.empresaId,
    this.usuarioId,
  });

  int bodegaId;
  String bodegaNombre;
  String bodegaProvincia;
  String bodegaDireccion;
  int empresaId;
  int usuarioId;

  factory Bodega.fromJson(Map<String, dynamic> json) => Bodega(
        bodegaId: json["bodega_id"],
        bodegaNombre: json["bodega_nombre"],
        bodegaProvincia: json["bodega_provincia"],
        bodegaDireccion: json["bodega_direccion"],
        empresaId: json["empresa_id"],
        usuarioId: json["usuario_id"],
      );

  Map<String, dynamic> toJson() => {
        "bodega_id": bodegaId,
        "bodega_nombre": bodegaNombre,
        "bodega_provincia": bodegaProvincia,
        "bodega_direccion": bodegaDireccion,
        "empresa_id": empresaId,
        "usuario_id": usuarioId,
      };
}