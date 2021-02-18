import 'package:app_factura_club_dev/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class TabServicios extends StatefulWidget {
  @override
  _TabServiciosState createState() => _TabServiciosState();
}

class _TabServiciosState extends State<TabServicios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servicios'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, 'nuevo_producto');
              })
        ],
      ),
      drawer: MenuWidget(),
      body: ListView.builder(
        itemCount: 5,
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
            Icons.add_business,
            color: Colors.white,
            size: 40.0,
          ),
          title: Text(
            '001',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre servicio',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '\$ 10.00',
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
