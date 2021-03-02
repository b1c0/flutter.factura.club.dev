import 'package:flutter/material.dart';

class BodegaPage extends StatefulWidget {
  BodegaPage({Key key}) : super(key: key);

  @override
  _BodegaPageState createState() => _BodegaPageState();
}

class _BodegaPageState extends State<BodegaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bodegas'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, 'nueva-bodega');
              })
        ],
      ),
      body: Container(),
    );
  }
}
