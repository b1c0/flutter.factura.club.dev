import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
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
                  'Cajero José',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'empresa@empresa.com',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.blue),
            title: Text('Inicio'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),
          ListTile(
              leading: Icon(Icons.category, color: Colors.blue),
              title: Text('Productos/Servicios'),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'productos-servicios');
              }),
          ListTile(
              leading: Icon(Icons.people_sharp, color: Colors.blue),
              title: Text('Clientes'),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'clientes');
                // Navigator.pop(context);
              }),
          ListTile(
              leading: Icon(Icons.paste, color: Colors.blue),
              title: Text('Facturas'),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'facturas');

                // Navigator.pop(context);
              }),
          ListTile(
              leading: Icon(Icons.arrow_back_rounded, color: Colors.blue),
              title: Text('Salir'),
              onTap: () {
                Navigator.popAndPushNamed(context, 'login');
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
