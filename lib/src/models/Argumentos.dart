import 'package:app_factura_club_dev/src/models/Bodega.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';

class Argumentos {
  Empresa empresa;
  Usuario usuario;
  Sucursal sucursal;
  Bodega bodega;

  Argumentos(this.empresa, this.usuario);
  Argumentos.sucursal(this.empresa, this.usuario, this.sucursal);
  Argumentos.bodega(this.empresa, this.usuario, this.bodega);
}
