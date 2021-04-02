import 'package:app_factura_club_dev/src/blocs/bodega_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Bodega.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NuevaBodegaPage extends StatefulWidget {
  @override
  _NuevaBodegaPageState createState() => _NuevaBodegaPageState();
}

class _NuevaBodegaPageState extends State<NuevaBodegaPage> {
  final _formKey = GlobalKey<FormState>();
  Bodega bodega = Bodega.sinId();
  BodegaBloc bodegaBloc;

  @override
  Widget build(BuildContext context) {
    final Argumentos arg = ModalRoute.of(context).settings.arguments;
    final Usuario usuario = arg.usuario;
    final Empresa empresa = arg.empresa;
    final Bodega data = arg.bodega;
    bodegaBloc = Provider.crearBodegaBloc(context);

    bodega = data;
    bodega.usuarioId = usuario.idUser;
    bodega.empresaId = empresa.empresaId;

    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Bodega'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: _formulario(arg),
      ),
    );
  }

  //===========================================================================FORMULARIO
  Widget _formulario(Argumentos arg) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          _inputNombreBodega(),
          Divider(),
          _inputProvinciaBodega(),
          Divider(),
          _inputDireccionBodega(),
          Divider(),
          _botonGuardarBodega(arg),
        ],
      ),
    );
  }

  //===========================================================================INPUTS

  Widget _inputNombreBodega() {
    return TextFormField(
      initialValue: bodega.bodegaNombre,
      maxLength: 250,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Nombre Bodega *',
      ),
      validator: (value) {
        if (value.isNotEmpty) {
          return null;
        } else {
          return 'El nombre es obligatorio';
        }
      },
      onChanged: (value) => bodega.bodegaNombre = value,
    );
  }

  Widget _inputProvinciaBodega() {
    return TextFormField(
      initialValue: bodega.bodegaProvincia,
      maxLength: 250,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Provincia Bodega',
      ),
      onChanged: (value) => bodega.bodegaProvincia = value,
    );
  }

  Widget _inputDireccionBodega() {
    return TextFormField(
      initialValue: bodega.bodegaDireccion,
      maxLength: 250,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Direccion Bodega',
      ),
      onChanged: (value) => bodega.bodegaDireccion = value,
    );
  }

  //===========================================================================BOTONES
  Widget _botonGuardarBodega(Argumentos arg) {
    return CupertinoButton(
      child: Text('Guardar'),
      borderRadius: BorderRadius.circular(15),
      color: Colors.blueAccent,
      onPressed: () => _ingresarBodega(arg),
    );
  }

  //===========================================================================MÉTODOS
  void _ingresarBodega(Argumentos arg) {
    if (!_formKey.currentState.validate()) return;

    if (bodega.bodegaId == null) {
      print('creando');
      bodegaBloc.crearNuevaBodega(bodega);
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, 'bodega', arguments: arg);
    } else {
      print('actualizando');
      bodegaBloc.actualizarBodega(bodega);
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, 'bodega', arguments: arg);
    }
  }
}
