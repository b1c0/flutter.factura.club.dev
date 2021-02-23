import 'dart:convert';

Categoria categoriaFromJson(String str) => Categoria.fromJson(json.decode(str));

String categoriaToJson(Categoria data) => json.encode(data.toJson());

class Categoria {
  Categoria({
    this.categoriaNombre,
    this.usuarioId,
  });

  String categoriaNombre;
  int usuarioId;

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        categoriaNombre: json["categoria_nombre"],
        usuarioId: json["usuario_id"],
      );

  Map<String, dynamic> toJson() => {
        "categoria_nombre": categoriaNombre,
        "usuario_id": usuarioId,
      };
}
