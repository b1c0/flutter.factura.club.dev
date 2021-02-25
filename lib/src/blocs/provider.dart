import 'package:app_factura_club_dev/src/blocs/empresa_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/registro_usuarios_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/sucursal_bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final _registroUsuariosBloc = RegistroUsuariosBloc();
  final _crearEmpresaBloc = EmpresaBloc();
  final _crearSucursalBloc = SucursalBloc();

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
}
