import 'dart:io';

import 'package:app_factura_club_dev/src/blocs/bodega_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/empresa_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/blocs/sucursal_bloc.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Bodega.dart';
import 'package:app_factura_club_dev/src/models/Cliente.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Producto.dart';
import 'package:app_factura_club_dev/src/models/Servicio.dart';
import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:app_factura_club_dev/src/services/empresa_service.dart';
import 'package:app_factura_club_dev/src/utils/utils.dart';
import 'package:app_factura_club_dev/src/widgets/menu_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final empresaService = EmpresaService();

  String _opcionSeleccionadaEmpresa = '-1';
  String _opcionSeleccionadaSucursal = '-1';
  String _opcionSeleccionadaBodega = '-1';
  EmpresaBloc empresasBloc;
  SucursalBloc sucursalBloc;
  BodegaBloc bodegaBloc;
  Sucursal sucursal = Sucursal();
  Bodega bodega = Bodega();
  Cliente cliente = Cliente();
  Empresa empresa = Empresa();

  @override
  Widget build(BuildContext context) {
    final Usuario usuario = ModalRoute.of(context).settings.arguments;
    empresasBloc = Provider.crearEmpresaBloc(context);
    empresasBloc.cargarEmpresas(usuario.idUser);
    sucursalBloc = Provider.crearSucursalBloc(context);
    sucursalBloc.cargarSucursales(int.parse(_opcionSeleccionadaEmpresa));
    bodegaBloc = Provider.crearBodegaBloc(context);
    bodegaBloc.cargarBodegas(int.parse(_opcionSeleccionadaEmpresa));

    return Scaffold(
      appBar: buildAppBar(),
      drawer: MenuWidget(
        usuario: usuario,
        empresa: empresa,
        sucursal: sucursal,
        bodega: bodega,
      ),
      floatingActionButton: opcionesFAB(usuario, empresa),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        children: [
          getEmpresas(),
          getSucursales(),
          getBodegas(),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('factura.club'),
      actions: [
        Container(
          padding: EdgeInsets.only(right: 10.0),
          child: Row(children: [
            Text(
              '\$ 99999999',
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(width: 8),
            Container(
              height: 20,
              width: 20,
              child: Image(
                image: AssetImage('assets/img/monedas.png'),
              ),
            )
          ]),
        )
      ],
    );
  }

  Widget opcionesFAB(Usuario usuario, Empresa empresa) {
    return Container(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          height: 70.0,
          width: 70.0,
          decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: BorderRadius.circular(80.0),
          ),
          child: PopupMenuButton(
            icon: Icon(Icons.add, color: Colors.white),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.category, color: Colors.blue),
                    CupertinoButton(
                      child: Text('Nuevo Producto'),
                      onPressed: () {
                        if (validarSeleccionProducto(int.parse(_opcionSeleccionadaBodega))) {
                          empresa.empresaId = int.parse(_opcionSeleccionadaEmpresa);
                          Argumentos a = Argumentos.producto(empresa, bodega, usuario, Producto(), 'navFromHome');
                          Navigator.popAndPushNamed(context, 'nuevo_producto', arguments: a);
                        }
                      },
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.miscellaneous_services, color: Colors.blue),
                    CupertinoButton(
                      child: Text('Nuevo Servicio'),
                      onPressed: () {
                        if (validarSeleccionSucursal(int.parse(_opcionSeleccionadaEmpresa), 'SERVICIO')) {
                          Argumentos a = Argumentos.servicio(sucursal, usuario, Servicio(), 'navFromHome');
                          Navigator.popAndPushNamed(context, 'nuevo-servicio', arguments: a);
                        }
                      },
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    Icon(Icons.people, color: Colors.blue),
                    CupertinoButton(
                      child: Text('Nuevo Cliente'),
                      onPressed: () {
                        if (validarSeleccionSucursal(int.parse(_opcionSeleccionadaSucursal), 'CLIENTE')) {
                          Argumentos a = Argumentos.cliente(usuario, sucursal, Cliente(), 'navFromHome');
                          Navigator.popAndPushNamed(context, 'nuevo-cliente', arguments: a);
                        }
                      },
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 4,
                child: Row(
                  children: [
                    Icon(Icons.paste, color: Colors.blue),
                    CupertinoButton(
                      child: Text('Nueva Factura'),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, 'nueva-factura');
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getOpcionesEmpresaDropDown(List<Empresa> opciones) {
    List<DropdownMenuItem<String>> lista = [];
    lista.add(DropdownMenuItem(
      child: Center(
        child: Text(
          'Seleccione una empresa',
        ),
      ),
      value: '-1',
    ));
    opciones.forEach((item) {
      lista.add(DropdownMenuItem(
        child: Center(child: Text(item.empresaNombre)),
        value: item.empresaId.toString(),
      ));
    });

    return lista;
  }

  List<DropdownMenuItem<String>> getOpcionesSucursalDropDown(List<Sucursal> opciones) {
    List<DropdownMenuItem<String>> lista = [];
    lista.add(DropdownMenuItem(
      child: Center(child: Text('Seleccione una sucursal')),
      value: '-1',
    ));
    opciones.forEach((item) {
      lista.add(DropdownMenuItem(
        child: Center(child: Text(item.sucursalNombre)),
        value: item.sucursalId.toString(),
      ));
    });

    return lista;
  }

  List<DropdownMenuItem<String>> getOpcionesBodegaDropDown(List<Bodega> opciones) {
    List<DropdownMenuItem<String>> lista = [];
    lista.add(DropdownMenuItem(
      child: Center(child: Text('Seleccione una bodega')),
      value: '-1',
    ));
    opciones.forEach((item) {
      lista.add(DropdownMenuItem(
        child: Center(child: Text(item.bodegaNombre)),
        value: item.bodegaId.toString(),
      ));
    });

    return lista;
  }

  Widget getEmpresas() {
    return StreamBuilder(
      stream: empresasBloc.empresasStream,
      builder: (BuildContext context, AsyncSnapshot<List<Empresa>> snapshot) {
        if (snapshot.hasData) {
          final empresas = snapshot.data;
          // String opcionSeleccionada = empresas[0].empresaNombre;
          List<DropdownMenuItem<String>> opciones = getOpcionesEmpresaDropDown(empresas);

          return Container(
            // alignment: Alignment.center,
            margin: EdgeInsets.only(top: 10, right: 25, left: 25),
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blue[400],
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Icon(Icons.business, color: Colors.white, size: 80),
                  DropdownButton(
                    value: _opcionSeleccionadaEmpresa,
                    items: opciones,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    dropdownColor: Colors.blue[400],
                    onChanged: (value) {
                      setState(() {
                        _opcionSeleccionadaEmpresa = value;
                        _opcionSeleccionadaSucursal = '-1';
                        _opcionSeleccionadaBodega = '-1';
                        if (_opcionSeleccionadaBodega != '-1') {
                          obtenerEmpresaSelecionada();
                        }
                        print(_opcionSeleccionadaEmpresa);
                        // _opcionSeleccionada = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget getSucursales() {
    return StreamBuilder(
      stream: sucursalBloc.sucursalesStream,
      builder: (BuildContext context, AsyncSnapshot<List<Sucursal>> snapshot) {
        if (snapshot.hasData) {
          final sucursales = snapshot.data;
          // String opcionSeleccionada = empresas[0].empresaNombre;
          List<DropdownMenuItem<String>> opciones = getOpcionesSucursalDropDown(sucursales);

          return Container(
            margin: EdgeInsets.only(top: 10, right: 25, left: 25),
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blue[400],
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Icon(Icons.home_work, color: Colors.white, size: 80),
                  DropdownButton(
                    value: _opcionSeleccionadaSucursal,
                    items: opciones,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    dropdownColor: Colors.blue[400],
                    onChanged: (value) {
                      setState(() {
                        _opcionSeleccionadaSucursal = value;
                        sucursal.sucursalId = int.parse(_opcionSeleccionadaSucursal);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget getBodegas() {
    return StreamBuilder(
      stream: bodegaBloc.bodegasStream,
      builder: (BuildContext context, AsyncSnapshot<List<Bodega>> snapshot) {
        if (snapshot.hasData) {
          final bodegas = snapshot.data;
          // String opcionSeleccionada = empresas[0].empresaNombre;
          List<DropdownMenuItem<String>> opciones = getOpcionesBodegaDropDown(bodegas);

          return Container(
            margin: EdgeInsets.only(top: 10, right: 25, left: 25),
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blue[400],
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Icon(Icons.inventory, color: Colors.white, size: 80),
                  DropdownButton(
                    value: _opcionSeleccionadaBodega,
                    items: opciones,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    dropdownColor: Colors.blue[400],
                    onChanged: (value) {
                      setState(() {
                        _opcionSeleccionadaBodega = value;
                        bodega.bodegaId = int.parse(_opcionSeleccionadaBodega);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  bool validarSeleccionSucursal(int sucursalId, String opcion) {
    if (sucursalId < 1) {
      Navigator.pop(context);
      mostrarAlerta(context, 'Alerta', 'Debe seleccionar la Empresa y la Sucursal a la que desea agregar el $opcion!');
      return false;
    }
    return true;
  }

  bool validarSeleccionProducto(int bodegaId) {
    if (bodegaId < 1) {
      Navigator.pop(context);
      mostrarAlerta(context, 'Alerta', 'Debe seleccionar la Empresa y la Bodega a la que desea agregar el PRODUCTO!');
      return false;
    }
    return true;
  }

  void obtenerEmpresaSelecionada() async {
    Map info = await empresaService.cargarEmpresaById(int.parse(_opcionSeleccionadaEmpresa));
    Empresa miempresa = info['empresa'];
    empresa = miempresa;
  }
}
