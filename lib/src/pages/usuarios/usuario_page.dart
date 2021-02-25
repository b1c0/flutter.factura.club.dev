import 'package:flutter/material.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPage createState() => _UsuariosPage();
}

class _UsuariosPage extends State<UsuariosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuarios'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, 'nuevo-usuario');
              })
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return _card();
        },
      ),
    );
  }

  Widget _card() {
    return Card(
      margin: EdgeInsets.all(5.0),
      color: Colors.blue[300],
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(children: [
        ListTile(
          leading: Icon(Icons.person, color: Colors.white, size: 40.0),
          title: Text('Punto emisión: 001', style: TextStyle(color: Colors.white)),
          subtitle: Text('Nombre usuario', style: TextStyle(color: Colors.white)),
          trailing: Icon(Icons.menu_outlined, color: Colors.white, size: 30.0),
        ),
      ]),
    );
  }
}
