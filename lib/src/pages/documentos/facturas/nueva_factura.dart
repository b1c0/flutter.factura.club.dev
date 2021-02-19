import 'package:app_factura_club_dev/src/widgets/inputs_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NuevaFacturaPage extends StatefulWidget {
  @override
  _NuevaFacturaPage createState() => _NuevaFacturaPage();
}

class _NuevaFacturaPage extends State<NuevaFacturaPage> {
  String _opcionSeleccionada = 'Pago';
  List<String> _opciones = ['Pago', 'Efectivo', 'Tarjeta Débito', 'Tarjeta Crédito'];
  InputWidget input = InputWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Factura'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        children: [
          _numeroFact(),
          _inputsFact(),
          _detalleFact(),
          _finalFact(),
          _crearBoton(),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _numeroFact() {
    return Card(
        margin: EdgeInsets.all(5.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Text(
              'Factura Nro: 001-001-123456789',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ));
  }

  Widget _inputCliente(String texto, String hint) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: TextField(
        // autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: hint,
          labelText: texto,
        ),
      ),
    );
  }

  Widget _inputsFact() {
    return Card(
        margin: EdgeInsets.all(5.0),
        elevation: 10.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Row(
              children: [
                _inputCliente('Cliente', ''),
                IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'agregar-producto-factura');
                    }),
              ],
            ),
            Divider(),
            input.crearInputText('Fecha', ''),
            Divider(),
            _crearDropDown(),
          ]),
        ));
  }

  Widget _detalleFact() {
    return Card(
        margin: EdgeInsets.all(5.0),
        elevation: 10.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Agregar Productos', style: TextStyle(fontSize: 16)),
                  IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.blueAccent,
                    onPressed: () {
                      Navigator.pushNamed(context, 'agregar-producto-factura');
                    },
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return _productos();
                },
              ),
            ],
          ),
        ));
  }

  Widget _finalFact() {
    return Card(
        margin: EdgeInsets.all(5.0),
        elevation: 10.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal 0%', style: TextStyle(fontSize: 16)),
                Text('\$0.00', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal 12%', style: TextStyle(fontSize: 16)),
                Text('\$0.00', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal No Objeto IVA', style: TextStyle(fontSize: 16)),
                Text('\$0.00', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal Exento IVA', style: TextStyle(fontSize: 16)),
                Text('\$0.00', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal', style: TextStyle(fontSize: 16)),
                Text('\$0.00', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Descuento', style: TextStyle(fontSize: 16)),
                Text('\$0.00', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('IVA 12%', style: TextStyle(fontSize: 16)),
                Text('\$0.00', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('TOTAL:', style: TextStyle(fontSize: 24)),
                Text('\$00.00', style: TextStyle(fontSize: 24, color: Colors.green)),
              ],
            ),
          ]),
        ));
  }

  Widget _crearDropDown() {
    return Row(
      children: [
        SizedBox(width: 10),
        Expanded(
          child: DropdownButton(
              value: _opcionSeleccionada,
              items: input.getOpcionesDropDown(_opciones),
              onChanged: (opt) {
                setState(() {
                  _opcionSeleccionada = opt;
                });
              }),
        ),
      ],
    );
  }

  Widget _productos() {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(children: [Text('Cant'), Text('2')]),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('Item'), Text('Camiseta')],
                  ),
                ],
              ),
              Column(children: [Text('Subtotal'), Text('\$10.50')]),
            ],
          ),
        ));
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
