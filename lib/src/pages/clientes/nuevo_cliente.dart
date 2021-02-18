import 'package:app_factura_club_dev/src/widgets/inputs_widget.dart';
import 'package:flutter/material.dart';

class NuevoClientePage extends StatefulWidget {
  @override
  _NuevoClientePage createState() => _NuevoClientePage();
}

class _NuevoClientePage extends State<NuevoClientePage> {
  InputWidget input = InputWidget();
  String _opcionSeleccionada = 'Tipo de identificación';
  List<String> _opciones = ['Tipo de identificación', 'CÉDULA', 'RUC', 'PASAPORTE'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Cliente'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        children: [
          _crearDropDown(),
          input.crearInputText('Identificacion', 'Cédula, RUC o Pasaporte'),
          Divider(),
          input.crearInputText('Nombre o Empresa', ''),
          Divider(),
          input.crearInputText('Razón Social', ''),
          Divider(),
          input.crearInputText('Direccion', ''),
          Divider(),
          input.crearInputText('Correo', ''),
          Divider(),
          input.crearInputNumber('Telefono', ''),
          Divider(),
          _crearBoton(),
        ],
      ),
    );
  }

  Widget _crearDropDown() {
    return Row(
      children: [
        SizedBox(width: 10.0),
        Expanded(
          child: DropdownButton(
              value: _opcionSeleccionada,
              items: input.getOpcionesDropDown(_opciones),
              onChanged: (opt) {
                setState(() {
                  _opcionSeleccionada = opt;
                });
              }),
        )
      ],
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
