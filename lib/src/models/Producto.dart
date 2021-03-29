import 'dart:convert';

Producto productoFromJson(String str) => Producto.fromJson(json.decode(str));

String productoToJson(Producto data) => json.encode(data.toJson());

String productoToJsonSinId(Producto data) => json.encode(data.toJsonSinId());

class Producto {
  int productoBodegaId;
  String productoNombre;
  String productoMarca;
  double productoPeso;
  String productoUnidadMedida;
  int categoriaId;
  int usuarioId;
  int bodegaId;
  bool productoBodegaIva;
  bool productoBodegaIce;
  int productoBodegaStock;
  double productoBodegaPrecio;
  String productoBodegaEstado;

  Producto({
    this.productoBodegaId,
    this.productoNombre,
    this.productoMarca,
    this.productoPeso,
    this.productoUnidadMedida,
    this.categoriaId,
    this.usuarioId,
    this.bodegaId,
    this.productoBodegaIva,
    this.productoBodegaIce,
    this.productoBodegaStock,
    this.productoBodegaPrecio,
    this.productoBodegaEstado,
  });

  //CONSTRUCTOR PARA CREAR PRODUCTO EN EL API
  Producto.sinId({
    this.productoNombre,
    this.productoMarca,
    this.productoPeso,
    this.productoUnidadMedida,
    this.categoriaId,
    this.usuarioId,
    this.bodegaId,
    this.productoBodegaIva,
    this.productoBodegaIce,
    this.productoBodegaStock,
    this.productoBodegaPrecio,
    this.productoBodegaEstado,
  });

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        productoBodegaId: json["producto_bodega_id"],
        productoNombre: json["producto_nombre"],
        productoMarca: json["producto_marca"],
        productoPeso: json["producto_peso"].toDouble(),
        productoUnidadMedida: json["producto_unidad_medida"],
        categoriaId: json["categoria_id"],
        usuarioId: json["usuario_id"],
        bodegaId: json["bodega_id"],
        productoBodegaIva: json["producto_bodega_iva"],
        productoBodegaIce: json["producto_bodega_ice"],
        productoBodegaStock: json["producto_bodega_stock"],
        productoBodegaPrecio: json["producto_bodega_precio"].toDouble(),
        productoBodegaEstado: json["producto_bodega_estado"],
      );

  Map<String, dynamic> toJson() => {
        "producto_bodega_id": productoBodegaId,
        "producto_nombre": productoNombre,
        "producto_marca": productoMarca,
        "producto_peso": productoPeso,
        "producto_unidad_medida": productoUnidadMedida,
        "categoria_id": categoriaId,
        "usuario_id": usuarioId,
        "bodega_id": bodegaId,
        "producto_bodega_iva": productoBodegaIva,
        "producto_bodega_ice": productoBodegaIce,
        "producto_bodega_stock": productoBodegaStock,
        "producto_bodega_precio": productoBodegaPrecio,
        "producto_bodega_estado": productoBodegaEstado,
      };

  Map<String, dynamic> toJsonSinId() => {
        "producto_nombre": productoNombre,
        "producto_marca": productoMarca,
        "producto_peso": productoPeso,
        "producto_unidad_medida": productoUnidadMedida,
        "categoria_id": categoriaId,
        "usuario_id": usuarioId,
        "bodega_id": bodegaId,
        "producto_bodega_iva": productoBodegaIva,
        "producto_bodega_ice": productoBodegaIce,
        "producto_bodega_stock": productoBodegaStock,
        "producto_bodega_precio": productoBodegaPrecio,
        "producto_bodega_estado": productoBodegaEstado,
      };
}

//CLASE PARA LISTAR PRODUCTOS
class Productos {
  List<Producto> items = [];
  Productos();
  Productos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final producto = new Producto.fromJson(item);
      items.add(producto);
    }
  }
}
