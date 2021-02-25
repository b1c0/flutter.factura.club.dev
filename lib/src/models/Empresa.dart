import 'dart:convert';

Empresa empresaFromJson(String str) => Empresa.fromJson(json.decode(str));

String empresaToJson(Empresa data) => json.encode(data.toJson());
String empresaToJsonSinID(Empresa data) => json.encode(data.toJsonSinId());

class Empresa {
  Empresa({
    this.empresaId,
    this.empresaNombre,
    this.empresaCorreoCorporativo,
    this.empresaTelefono,
    this.empresaDireccion,
    this.empresaLogotipo,
    this.empresaRuc,
    this.usuarioId,
  });
  Empresa.sinID({
    this.empresaNombre,
    this.empresaCorreoCorporativo,
    this.empresaTelefono,
    this.empresaDireccion,
    this.empresaLogotipo,
    this.empresaRuc,
    this.usuarioId,
  });

  int empresaId;
  String empresaNombre;
  String empresaCorreoCorporativo;
  String empresaTelefono;
  String empresaDireccion;
  String empresaLogotipo;
  String empresaRuc;
  int usuarioId;

  factory Empresa.fromJson(Map<String, dynamic> json) => Empresa(
        empresaId: json["empresa_id"],
        empresaNombre: json["empresa_nombre"],
        empresaCorreoCorporativo: json["empresa_correo_corporativo"],
        empresaTelefono: json["empresa_telefono"],
        empresaDireccion: json["empresa_direccion"],
        empresaLogotipo: json["empresa_logotipo"],
        empresaRuc: json["empresa_ruc"],
        usuarioId: json["usuario_ID"],
      );

  Map<String, dynamic> toJson() => {
        "empresa_id": empresaId,
        "empresa_nombre": empresaNombre,
        "empresa_correo_corporativo": empresaCorreoCorporativo,
        "empresa_telefono": empresaTelefono,
        "empresa_direccion": empresaDireccion,
        "empresa_logotipo": empresaLogotipo,
        "empresa_ruc": empresaRuc,
        "usuario_ID": usuarioId,
      };

  Map<String, dynamic> toJsonSinId() => {
        "empresa_nombre": empresaNombre,
        "empresa_correo_corporativo": empresaCorreoCorporativo,
        "empresa_telefono": empresaTelefono,
        "empresa_direccion": empresaDireccion,
        "empresa_logotipo": empresaLogotipo,
        "empresa_ruc": empresaRuc,
        "usuario_ID": usuarioId,
      };
}

class Empresas {
  List<Empresa> items = new List();
  Empresas();
  Empresas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final empresa = new Empresa.fromJson(item);
      items.add(empresa);
    }
  }
}
