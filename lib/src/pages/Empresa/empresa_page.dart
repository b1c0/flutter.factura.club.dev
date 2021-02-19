import 'package:app_factura_club_dev/src/widgets/inputs_widget.dart';
import 'package:app_factura_club_dev/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class EmpresaPage extends StatelessWidget {
  InputWidget input = InputWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos Empresa'),
      ),
      drawer: MenuWidget(),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            input.crearInputNumber('Establecimiento *', ''),
            Divider(),
            input.crearInputNumber('Punto Emisión *', ''),
            Divider(),
            input.crearInputText('Nombre Comercial *', ''),
            Divider(),
            input.crearInputNumber('RUC *', ''),
            Divider(),
            input.crearInputText('Razón Social *', ''),
            Divider(),
            input.crearInputText('Dirección', ''),
            Divider(),
            _crearBoton(),
          ],
        ),
      ),
    );
  }

  Widget _crearBoton() {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 85.0, vertical: 15.0),
          child: Text(
            'Guardar',
            style: TextStyle(fontSize: 18),
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 0.0,
        color: Colors.blueAccent,
        textColor: Colors.white,
        onPressed: () {});
  }
}
