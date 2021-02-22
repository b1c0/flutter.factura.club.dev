import 'package:app_factura_club_dev/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class MenuEmpresaPage extends StatelessWidget {
  const MenuEmpresaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empresa'),
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: [
          ListTile(
            title: Text('Datos Empresa'),
            leading: Icon(Icons.business, color: Colors.blue),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
            onTap: () {
              Navigator.pushNamed(context, 'empresa');
            },
          ),
          ListTile(
            title: Text('Sucursales'),
            leading: Icon(Icons.add_business, color: Colors.blue),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
            onTap: () {
              Navigator.pushNamed(context, 'sucursales');
            },
          ),
          ListTile(
            title: Text('Usuarios'),
            leading: Icon(Icons.person, color: Colors.blue),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
            onTap: () {
              Navigator.pushNamed(context, 'usuarios');
            },
          ),
        ],
      ),
    );
  }
}
