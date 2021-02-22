import 'package:flutter/material.dart';

class SucursalesPage extends StatefulWidget {
  @override
  _SucursalesPage createState() => _SucursalesPage();
}

class _SucursalesPage extends State<SucursalesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sucursales'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, 'nueva-sucursal');
              })
        ],
      ),
      body: ListView.builder(
        itemCount: 2,
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
          leading: Icon(Icons.add_business, color: Colors.white, size: 40.0),
          title: Text(
            '001',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dirección',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Telefono',
                style: TextStyle(color: Colors.white),
              )
            ],
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
