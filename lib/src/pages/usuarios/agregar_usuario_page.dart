import 'package:app_factura_club_dev/src/widgets/inputs_widget.dart';
import 'package:flutter/material.dart';

class NuevoUsuarioPage extends StatefulWidget {
  @override
  _NuevoUsuarioPage createState() => _NuevoUsuarioPage();
}

class _NuevoUsuarioPage extends State<NuevoUsuarioPage> {
  bool esServicio;
  String _opcionSeleccionada = 'Perfiles';
  List<String> _opciones = ['Perfiles', 'nuevo'];
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
          // input.crearInputText('Código punto de emisión', ''),
          // Divider(),
          // input.crearInputText('Nombre de usuario', ''),
          // Divider(),
          // _inputPerfil(),
          // Divider(),
          // input.crearPassword2('Clave', 'Clave'),
          // Divider(),
          // input.crearPassword2('Confirmar Clave', 'Confirmar Clave'),
          // Divider(),
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
        onPressed: () {
          Navigator.pushNamed(context, '');
        });
  }

  Widget _inputPerfil() {
    return Container(
      child: Row(
        children: [
          _dropDownPerfiles(),
          Container(
            child: IconButton(
                icon: Icon(Icons.add_circle, color: Colors.blueAccent),
                onPressed: () {
                  Navigator.pushNamed(context, 'permisos-usuarios');
                }),
          ),
        ],
      ),
    );
  }

  Widget _dropDownPerfiles() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Row(
        children: [
          SizedBox(width: 10),
          Expanded(
            child: DropdownButton(
                value: _opcionSeleccionada,
                items: getOpcionesDropDown(_opciones),
                onChanged: (opt) {
                  setState(() {
                    _opcionSeleccionada = opt;
                  });
                }),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropDown(List<String> opciones) {
    List<DropdownMenuItem<String>> lista = List();
    opciones.forEach((poder) {
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));
    });
    return lista;
  }
}
