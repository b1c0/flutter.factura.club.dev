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
  String _opcionSeleccionada = 'Sucursal 1';
  List<String> _opciones = ['Sucursal 1', 'Sucursal 2', 'Sucursal 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: MenuWidget(),
      floatingActionButton: opcionesFAB(),
      body: Column(
        children: [
          _crearDropDown(),
          SingleChildScrollView(child: Column(children: [_unionTarjetas()])),
          SizedBox(height: 10.0),
          Text('Actividades recientes', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10.0),
          _actividadesRecientes(),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('factura.club'),
      actions: [
        Container(
          padding: EdgeInsets.only(right: 5.0),
          child: Row(children: [
            Text(
              '\$ 99999999',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(width: 10),
            Container(
              height: 30,
              width: 30,
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

  Widget _crearDropDown() {
    return Container(
      alignment: Alignment.center,
      color: Colors.blue[400],
      margin: EdgeInsets.all(10),
      child: DropdownButton(
        value: _opcionSeleccionada,
        items: input.getOpcionesDropDown(_opciones),
        style: TextStyle(color: Colors.white, fontSize: 18),
        dropdownColor: Colors.blue[400],
        onChanged: (value) {
          setState(() {
            _opcionSeleccionada = value;
          });
        },
      ),
    );
  }

  Widget _unionTarjetas() {
    return Table(
      children: [
        TableRow(children: [
          _crearTarjeta(Colors.white, Icons.shop, 'Prodctos'),
          _crearTarjeta(Colors.white, Icons.supervised_user_circle_sharp, 'Clientes'),
          _crearTarjeta(Colors.white, Icons.supervised_user_circle_sharp, 'Clientes'),
        ]),
        TableRow(children: [
          _crearTarjeta(Colors.white, Icons.assignment, 'Facturas'),
          _crearTarjeta(Colors.white, Icons.paste_rounded, 'Proformas'),
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
      height: 100,
      width: double.infinity,
      color: Colors.grey,
    );
  }
}
