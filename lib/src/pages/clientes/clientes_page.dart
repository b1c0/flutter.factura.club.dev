import 'package:app_factura_club_dev/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class ClientesPage extends StatefulWidget {
  @override
  _ClientesPage createState() => _ClientesPage();
}

class _ClientesPage extends State<ClientesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, 'nuevo-cliente');
              })
        ],
      ),
      drawer: MenuWidget(),
      body: ListView.builder(
        itemCount: 3,
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
          leading: Icon(
            Icons.person_pin_rounded,
            color: Colors.white,
            size: 40.0,
          ),
          title: Text(
            'Consumidor final',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            '9999999999999',
            style: TextStyle(color: Colors.white),
          ),
          trailing: Icon(
            Icons.menu_outlined,
            color: Colors.white,
            size: 30.0,
          ),
        ),
      ]),
    );
  }
}
