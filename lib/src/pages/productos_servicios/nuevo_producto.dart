import 'package:app_factura_club_dev/src/widgets/inputs_widget.dart';
import 'package:flutter/material.dart';

class NuevoProductoPage extends StatefulWidget {
  @override
  _NuevoProductoPage createState() => _NuevoProductoPage();
}

class _NuevoProductoPage extends State<NuevoProductoPage> {
  InputWidget input = InputWidget();
  String _opcionSeleccionada = 'Selecione impuesto Iva';
  List<String> _opciones = ['Selecione impuesto Iva', 'Iva 0%', 'Iva 12%', 'Iva 14%'];
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
        title: Text('Nuevo Producto/Servicio'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        children: [
          input.crearInputText('Código del producto', 'Modelo, SKU o código descriptivo'),
          Divider(),
          input.crearInputText('Descripcion', 'Descripcion del producto'),
          Divider(),
          input.crearInputNumber('Precio', 'Precio Unitario'),
          Divider(),
          _crearDropDown(),
          _crearCheckServicio(),
          Divider(),
          _controlStock(),
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
          child: Container(
            margin: EdgeInsets.all(10),
            child: DropdownButton(
                value: _opcionSeleccionada,
                items: input.getOpcionesDropDown(_opciones),
                onChanged: (opt) {
                  setState(() {
                    _opcionSeleccionada = opt;
                  });
                }),
          ),
        )
      ],
    );
  }

  Widget _crearCheckServicio() {
    return Row(children: [
      Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Checkbox(
            value: esServicio,
            onChanged: (value) {
              setState(() {
                esServicio = value;
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

  Widget _controlStock() {
    return TextField(
      // autofocus: true,
      enabled: !esServicio,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Número de unidades en el inventario',
        labelText: 'Stock',
      ),
    );
  }
}
