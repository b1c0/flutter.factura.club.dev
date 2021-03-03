import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MenuWidget extends StatefulWidget {
  Usuario usuario;
  MenuWidget({Key key, this.usuario}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.usuario.nombreUser,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  widget.usuario.correoUser,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.blue),
            title: Text('Inicio'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, 'home', (Route<dynamic> route) => false, arguments: widget.usuario);
            },
          ),
          ListTile(
            leading: Icon(Icons.business, color: Colors.blue),
            title: Text('Empresa'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, 'menu-empresa', ModalRoute.withName('home'), arguments: widget.usuario);
            },
          ),
          ListTile(
              leading: Icon(Icons.category, color: Colors.blue),
              title: Text('Productos/Servicios'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, 'productos-servicios', ModalRoute.withName('home'));
              }),
          ListTile(
              leading: Icon(Icons.people_sharp, color: Colors.blue),
              title: Text('Clientes'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, 'clientes', ModalRoute.withName('home'));
                // Navigator.pop(context);
              }),
          ListTile(
              leading: Icon(Icons.paste, color: Colors.blue),
              title: Text('Facturas'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, 'facturas', ModalRoute.withName('home'));

                // Navigator.pop(context);
              }),
          ListTile(
              leading: Icon(Icons.arrow_back_rounded, color: Colors.blue),
              title: Text('Salir'),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'login');
              }),
          // ListTile(
          //     leading: Icon(Icons.settings, color: Colors.blue),
          //     title: Text('Configuraciones'),
          //     onTap: () {
          //       // Navigator.pop(context);
          //     }),
        ],
      ),
    );
  }
}
