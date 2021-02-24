import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgregarProductoFacturaPage extends StatefulWidget {
  @override
  _AgregarProductoFacturaPage createState() => _AgregarProductoFacturaPage();
}

class _AgregarProductoFacturaPage extends State<AgregarProductoFacturaPage> {
  bool esServicio = false;

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
        setState(() {});
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
        setState(() {});
      },
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
