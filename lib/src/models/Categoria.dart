import 'dart:convert';

Categoria categoriaFromJson(String str) => Categoria.fromJson(json.decode(str));

String categoriaToJson(Categoria data) => json.encode(data.toJson());

String categoriaToJsonSinId(Categoria data) => json.encode(data.toJsonSinId());

class Categoria {
  int categoriaId;
  String categoriaNombre;
  int usuarioId;
  int empresaId;

  Categoria({
    this.categoriaId,
    this.categoriaNombre,
    this.usuarioId,
    this.empresaId,
  });

  //CONSTRUCTOR PARA CREAR CATEGORIA EN EL API
  Categoria.sinId({
    this.categoriaNombre,
    this.usuarioId,
    this.empresaId,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        categoriaId: json["categoria_id"],
        categoriaNombre: json["categoria_nombre"],
        usuarioId: json["usuario_id"],
        empresaId: json["empresa_id"],
      );

  Map<String, dynamic> toJson() => {
        "categoria_id": categoriaId,
        "categoria_nombre": categoriaNombre,
        "usuario_id": usuarioId,
        "empresa_id": empresaId,
      };
  Map<String, dynamic> toJsonSinId() => {
        "categoria_nombre": categoriaNombre,
        "usuario_id": usuarioId,
        "empresa_id": empresaId,
      };
}

//CLASE PARA LISTAR CATEGORIAS
class Categorias {
  List<Categoria> items = [];
  Categorias();
  Categorias.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final categoria = new Categoria.fromJson(item);
      items.add(categoria);
    }
  }
}
