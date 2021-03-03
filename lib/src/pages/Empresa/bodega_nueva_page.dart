import 'package:flutter/material.dart';

class NuevaBodegaPage extends StatefulWidget {
  NuevaBodegaPage({Key key}) : super(key: key);

  @override
  _NuevaBodegaPageState createState() => _NuevaBodegaPageState();
}

class _NuevaBodegaPageState extends State<NuevaBodegaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Bodega'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _inputNombreBodega(),
            Divider(),
            _inputProvinciaBodega(),
            Divider(),
            _inputDireccionBodega(),
            // Divider(),
            // inputDireccionEmpresa(),
            // Divider(),
            // inputLogoEmpresa(),
            // Divider(),
            // inputRUCEmpresa(),
            // Divider(),
            // _botonGuardarEmpresa(usuario),
          ],
        ),
      ),
    );
  }

//=========================INPUTS=========================\\
  Widget _inputNombreBodega() {
    return TextFormField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Nombre Bodega',
      ),
      // onChanged: (value) => empresa.empresaNombre = value,
    );
  }

  Widget _inputProvinciaBodega() {
    return TextFormField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Provincia Bodega',
      ),
      // onChanged: (value) => empresa.empresaNombre = value,
    );
  }

  Widget _inputDireccionBodega() {
    return TextFormField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Direccion Bodega',
      ),
      // onChanged: (value) => empresa.empresaNombre = value,
    );
  }
}
