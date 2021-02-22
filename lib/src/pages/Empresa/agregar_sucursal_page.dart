import 'package:app_factura_club_dev/src/widgets/inputs_widget.dart';
import 'package:flutter/material.dart';

class NuevaSucursalPage extends StatefulWidget {
  @override
  _NuevaSucursalPage createState() => _NuevaSucursalPage();
}

class _NuevaSucursalPage extends State<NuevaSucursalPage> {
  InputWidget input = InputWidget();
  bool esServicio;

  @override
  void initState() {
    super.initState();
    esServicio = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Sucursal'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        children: [
          input.crearInputText('Código establecimiento', ''),
          Divider(),
          input.crearInputText('Dirección', 'Dirección de la sucursal'),
          Divider(),
          input.crearInputNumber('Télefono', ''),
          Divider(),
          _crearBoton(),
        ],
      ),
    );
  }

  Widget _crearBoton() {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 85.0, vertical: 15.0),
          child: Text('Guardar'),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 0.0,
        color: Colors.blueAccent,
        textColor: Colors.white,
        onPressed: () {});
  }
}
