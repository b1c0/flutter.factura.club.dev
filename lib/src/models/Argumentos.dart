import 'package:app_factura_club_dev/src/models/Bodega.dart';
import 'package:app_factura_club_dev/src/models/Categoria.dart';
import 'package:app_factura_club_dev/src/models/Cliente.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Producto.dart';
import 'package:app_factura_club_dev/src/models/Servicio.dart';
import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';

class Argumentos {
  Empresa empresa;
  Usuario usuario;
  Sucursal sucursal;
  Bodega bodega;
  Cliente cliente;
  Producto producto;
  Servicio servicio;
  Categoria categoria;
  String navFrom; //campo que indica desde que vista se envía la información para validar la navegación

  //CONSTRUCTORES
  Argumentos(this.empresa, this.usuario);
  Argumentos.menu(this.empresa, this.sucursal, this.bodega);
  Argumentos.sucursal(this.empresa, this.usuario, this.sucursal);
  Argumentos.bodega(this.empresa, this.usuario, this.bodega);
  Argumentos.categoria(this.empresa, this.usuario, this.categoria);
  Argumentos.cliente(this.usuario, this.sucursal, this.cliente, this.navFrom);
  Argumentos.producto(this.empresa, this.bodega, this.usuario, this.producto, this.navFrom);
  Argumentos.servicio(this.sucursal, this.usuario, this.servicio, this.navFrom);
}
