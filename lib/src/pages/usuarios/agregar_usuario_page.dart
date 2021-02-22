import 'package:app_factura_club_dev/src/widgets/inputs_widget.dart';
import 'package:flutter/material.dart';

class NuevoUsuarioPage extends StatefulWidget {
  @override
  _NuevoUsuarioPage createState() => _NuevoUsuarioPage();
}

class _NuevoUsuarioPage extends State<NuevoUsuarioPage> {
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
        title: Text('Nuevo Usuario'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        children: [
          input.crearInputText('Código punto de emisión', ''),
          Divider(),
          input.crearInputText('Nombre de usuario', ''),
          Divider(),
          input.crearPassword2('Clave', 'Clave'),
          Divider(),
          input.crearPassword2('Confirmar Clave', 'Confirmar Clave'),
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
