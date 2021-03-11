import 'package:app_factura_club_dev/src/blocs/bodega_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Bodega.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:flutter/material.dart';

class NuevaBodegaPage extends StatefulWidget {
  NuevaBodegaPage({Key key}) : super(key: key);

  @override
  _NuevaBodegaPageState createState() => _NuevaBodegaPageState();
}

class _NuevaBodegaPageState extends State<NuevaBodegaPage> {
  Bodega bodega = Bodega.sinId();
  BodegaBloc bodegaBloc;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bodegaBloc = Provider.crearBodegaBloc(context);
    final Argumentos arg = ModalRoute.of(context).settings.arguments;

    final Usuario usuario = arg.usuario;
    final Empresa empresa = arg.empresa;
    final Bodega data = arg.bodega;
    if (data != null) {
      bodega = data;
    }
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

  ListView _formulario(Argumentos arg) {
    return ListView(
      children: [
        _inputNombreBodega(),
        Divider(),
        _inputProvinciaBodega(),
        Divider(),
        _inputDireccionBodega(),
        Divider(),
        _botonGuardarBodega(arg),
      ],
    );
  }

//=========================INPUTS=========================\\
  Widget _inputNombreBodega() {
    return TextFormField(
      // autofocus: true,
      initialValue: bodega.bodegaNombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Nombre Bodega',
      ),
      onChanged: (value) => bodega.bodegaNombre = value,
    );
  }

  Widget _inputProvinciaBodega() {
    return TextFormField(
      // autofocus: true,
      initialValue: bodega.bodegaProvincia,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Provincia Bodega',
      ),
      onChanged: (value) => bodega.bodegaProvincia = value,
    );
  }

  Widget _inputDireccionBodega() {
    return TextFormField(
      // autofocus: true,
      initialValue: bodega.bodegaDireccion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Direccion Bodega',
      ),
      onChanged: (value) => bodega.bodegaDireccion = value,
    );
  }

  Widget _botonGuardarBodega(Argumentos arg) {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 85.0, vertical: 15.0),
          child: Text('Guardar'),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: Colors.blueAccent,
        textColor: Colors.white,
        onPressed: () {
          _actionGuardarBodega(arg);
        });
  }

  void _actionGuardarBodega(Argumentos arg) {
    //TODO: VALIDAR VACIOS
    if (bodega.bodegaId == null) {
      bodegaBloc.crearNuevaBodega(bodega);
      print('creando');
    } else {
      print('actualizando');

      bodegaBloc.actualizarBodega(bodega);
    }
    Navigator.pushNamedAndRemoveUntil(context, 'bodega', ModalRoute.withName('empresa'), arguments: arg);
  }
}
