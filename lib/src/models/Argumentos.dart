import 'package:app_factura_club_dev/src/models/Bodega.dart';
import 'package:app_factura_club_dev/src/models/Cliente.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Producto.dart';
import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';

class Argumentos {
  Empresa empresa;
  Usuario usuario;
  Sucursal sucursal;
  Bodega bodega;
  Cliente cliente;
  Producto producto;

  Argumentos(this.empresa, this.usuario);
  Argumentos.sucursal(this.empresa, this.usuario, this.sucursal);
  Argumentos.bodega(this.empresa, this.usuario, this.bodega);
  Argumentos.cliente(this.sucursal, this.usuario);
  Argumentos.modificarCliente(this.cliente, this.usuario, this.sucursal);
  Argumentos.productos(this.bodega, this.usuario);
  Argumentos.modificarProductos(this.bodega, this.usuario, this.producto);
}
