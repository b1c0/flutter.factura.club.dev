import 'package:app_factura_club_dev/src/models/Cliente.dart';
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
  Cliente cliente = Cliente();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Cliente'),
        centerTitle: true,
      ),
      body: _formulario(),
    );
  }

  ListView _formulario() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      children: [
        _crearDropDown(),
        _inputIdentificacion(),
        Divider(),
        _inputNombres(),
        Divider(),
        _inputCorreo(),
        Divider(),
        _inputDireccion(),
        Divider(),
        _inputCelular(),
        Divider(),
        _inputTelefono(),
        Divider(),
        _crearBoton(),
      ],
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

//=======================================================================INPUTS=====
  Widget _inputIdentificacion() {
    return TextFormField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Cedula, Pasaporte, o RUC',
        hintText: 'Numero de Identificacion',
      ),
      onChanged: (value) => cliente.clienteIdentificacion = value,
    );
  }

  Widget _inputNombres() {
    return TextFormField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Nombres y Apellidos',
        hintText: 'Nombres y Apellidos',
      ),
      onChanged: (value) => cliente.clienteNombres = value,
    );
  }

  Widget _inputCorreo() {
    return TextFormField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Correo',
        hintText: 'Correo',
      ),
      onChanged: (value) => cliente.clienteCorreo = value,
    );
  }

  Widget _inputDireccion() {
    return TextFormField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Dirección',
        hintText: 'Dirección',
      ),
      onChanged: (value) => cliente.clienteDireccion = value,
    );
  }

  Widget _inputCelular() {
    return TextFormField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Teléfono Celular',
        hintText: 'Teléfono Celular',
      ),
      onChanged: (value) => cliente.clienteCelular = value,
    );
  }

  Widget _inputTelefono() {
    return TextFormField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Teléfono Convencional',
        hintText: 'Teléfono Convencional',
      ),
      onChanged: (value) => cliente.clienteTelefono = value,
    );
  }
}
