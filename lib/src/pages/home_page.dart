import 'package:app_factura_club_dev/src/blocs/empresa_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:app_factura_club_dev/src/widgets/inputs_widget.dart';
import 'package:app_factura_club_dev/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InputWidget input = InputWidget();
  String _opcionSeleccionada = 'Seleccione';
  List<String> _opciones = ['Sucursal 1', 'Sucursal 2', 'Sucursal 3'];
  EmpresaBloc empresasBloc;
  @override
  Widget build(BuildContext context) {
    final Usuario usuario = ModalRoute.of(context).settings.arguments;
    empresasBloc = Provider.crearEmpresaBloc(context);
    empresasBloc.cargarEmpresas(usuario.idUser);

    return Scaffold(
      appBar: buildAppBar(),
      drawer: MenuWidget(usuario: usuario),
      floatingActionButton: opcionesFAB(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        children: [
          getEmpresas(empresasBloc, usuario.idUser),
          // _crearDropDown(),
          // SingleChildScrollView(child: Column(children: [_unionTarjetas()])),
          // SizedBox(height: 10.0),
          // Text(
          //   'Actividades recientes',
          //   style: TextStyle(fontSize: 18),
          //   textAlign: TextAlign.center,
          // ),
          // SizedBox(height: 10.0),
          // _actividadesRecientes(),
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

  Widget opcionesFAB() {
    return Container(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          height: 70.0,
          width: 70.0,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
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
                    FlatButton(
                      child: Text('Nuevo Producto'),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, 'nuevo_producto');
                      },
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.people, color: Colors.blue),
                    FlatButton(
                      child: Text('Nuevo Cliente'),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, 'nuevo-cliente');
                      },
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    Icon(Icons.paste, color: Colors.blue),
                    FlatButton(
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

  List<DropdownMenuItem<String>> getOpcionesDropDown(List<Empresa> opciones) {
    List<DropdownMenuItem<String>> lista = [];
    lista.add(DropdownMenuItem(
      child: Text('Seleccione'),
      value: 'Seleccione',
    ));
    opciones.forEach((poder) {
      lista.add(DropdownMenuItem(
        child: Text(poder.empresaNombre),
        value: poder.empresaNombre,
      ));
    });

    return lista;
  }

  Widget getEmpresas(EmpresaBloc empresaBloc, int usuarioId) {
    return StreamBuilder(
      stream: empresasBloc.empresasStream,
      builder: (BuildContext context, AsyncSnapshot<List<Empresa>> snapshot) {
        if (snapshot.hasData) {
          final empresas = snapshot.data;
          // String opcionSeleccionada = empresas[0].empresaNombre;
          List<DropdownMenuItem<String>> opciones = getOpcionesDropDown(empresas);

          return Container(
            alignment: Alignment.center,
            color: Colors.blue[400],
            margin: EdgeInsets.all(10),
            child: DropdownButton(
              value: _opcionSeleccionada,
              items: opciones,
              style: TextStyle(color: Colors.white, fontSize: 18),
              dropdownColor: Colors.blue[400],
              onChanged: (value) {
                setState(() {
                  _opcionSeleccionada = value;
                });
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _unionTarjetas() {
    return Table(
      children: [
        TableRow(children: [
          _crearTarjeta(Colors.white, Icons.shop, 'Prodctos'),
          _crearTarjeta(Colors.white, Icons.supervised_user_circle_sharp, 'Clientes'),
        ]),
        TableRow(children: [
          _crearTarjeta(Colors.white, Icons.assignment, 'Facturas'),
          _crearTarjeta(Colors.white, Icons.paste_rounded, 'Proformas'),
        ]),
      ],
    );
  }

  Widget _crearTarjeta(Color color, IconData icon, String texto) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(
          height: 150.0,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundColor: color,
                radius: 35.0,
                child: Icon(icon, color: Colors.blueAccent, size: 50.0),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('9999', style: TextStyle(color: Colors.white, fontSize: 16.0)),
                  Text(texto, style: TextStyle(color: Colors.white, fontSize: 16.0)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actividadesRecientes() {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      height: 200,
      width: double.infinity,
      color: Colors.grey,
    );
  }
}
