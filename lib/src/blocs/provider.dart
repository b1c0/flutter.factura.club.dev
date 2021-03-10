import 'package:app_factura_club_dev/src/blocs/bodega_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/categoria_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/cliente_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/empresa_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/producto_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/registro_usuarios_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/servicio_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/sucursal_bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final _registroUsuariosBloc = RegistroUsuariosBloc();
  final _crearEmpresaBloc = EmpresaBloc();
  final _crearSucursalBloc = SucursalBloc();
  final _crearBodegaBloc = BodegaBloc();
  final _crearClienteBloc = ClienteBloc();
  final _crearProductoBloc = ProductoBloc();
  final _crearServicioBloc = ServicioBloc();
  final _crearCategoriaBloc = CategoriaBloc();

  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static RegistroUsuariosBloc registroUsuarioBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>()._registroUsuariosBloc);
  }

  static EmpresaBloc crearEmpresaBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>()._crearEmpresaBloc);
  }

  static SucursalBloc crearSucursalBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>()._crearSucursalBloc);
  }

  static BodegaBloc crearBodegaBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>()._crearBodegaBloc);
  }

  static ClienteBloc crearClienteBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>()._crearClienteBloc);
  }

  static ProductoBloc crearProductoBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>()._crearProductoBloc);
  }

  static CategoriaBloc crearCategoriaBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>()._crearCategoriaBloc);
  }

  static ServicioBloc crearServicioBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>()._crearServicioBloc);
  }
}
