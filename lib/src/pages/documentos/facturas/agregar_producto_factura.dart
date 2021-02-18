import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgregarProductoFacturaPage extends StatefulWidget {
  @override
  _AgregarProductoFacturaPage createState() => _AgregarProductoFacturaPage();
}

class _AgregarProductoFacturaPage extends State<AgregarProductoFacturaPage> {
  String _nombre = '';
  String _email = '';
  String _fecha = '';
  bool esServicio = false;
  String _opcionSeleccionada = 'Selecione impuesto Iva';

  List<String> _poderes = ['Selecione impuesto Iva', 'Iva 0%', 'Iva 12%', 'Iva 14%'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Agregar Producto'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        children: [
          _crearInput('Seleccione un producto o servicio', ''),
          Divider(),
          _crearInput('Cantidad', ''),
          Divider(),
          _crearPrecio('Precio', ''),
          Divider(),
          _crearPrecio('Descuento', ''),
          Divider(),
          Center(
            child: Text(
              'Subtotal: \$00.00',
              style: TextStyle(fontSize: 24, color: Colors.green),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _crearBoton(),
        ],
      ),
    );
  }

  Widget _crearInput(String texto, String hint) {
    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: hint,
        labelText: texto,
      ),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
    );
  }

  Widget _crearPrecio(String texto, String hint) {
    return TextField(
      // autofocus: true,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: hint,
        labelText: texto,
      ),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
    );
  }

  Widget _crearStock(String texto, String hint) {
    return TextField(
      enabled: esServicio,
      // autofocus: true,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: hint,
        labelText: texto,
      ),
      onChanged: (valor) {
        setState(() {});
      },
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropDown() {
    List<DropdownMenuItem<String>> lista = List();

    _poderes.forEach((poder) {
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));
    });
    return lista;
  }

  Widget _crearDropDown() {
    return Row(
      children: [
        SizedBox(width: 10.0),
        Expanded(
          child: DropdownButton(
              value: _opcionSeleccionada,
              items: getOpcionesDropDown(),
              onChanged: (opt) {
                setState(() {
                  _opcionSeleccionada = opt;
                });
              }),
        )
      ],
    );
  }

  _crearCheckServicio() {
    return Row(children: [
      Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Checkbox(
            value: esServicio,
            onChanged: (value) {
              setState(() {
                esServicio = value;
                print(esServicio);
              });
            },
          )),
      Text('¿Es un servicio?')
    ]);
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

  Widget _crearPersona() {
    return ListTile(
      title: Text('Nombre es: $_nombre'),
      subtitle: Text('Email: $_email'),
    );
  }
}
