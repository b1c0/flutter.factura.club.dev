import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/blocs/servicio_bloc.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Servicio.dart';
import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NuevoServicioPage extends StatefulWidget {
  @override
  _NuevoServicioPageState createState() => _NuevoServicioPageState();
}

class _NuevoServicioPageState extends State<NuevoServicioPage> {
  Servicio servicio = Servicio.sinId();
  ServicioBloc servicioBloc;
  String navFrom;

  @override
  Widget build(BuildContext context) {
    servicioBloc = Provider.crearServicioBloc(context);

    final Argumentos arg = ModalRoute.of(context).settings.arguments;
    navFrom = arg.navFrom;
    final Usuario usuario = arg.usuario;
    final Sucursal sucursal = arg.sucursal;

    servicio.sucursalId = sucursal.sucursalId;
    servicio.usuarioId = usuario.idUser;
    print(servicio.sucursalId);
    print(servicio.usuarioId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Servicio'),
      ),
      body: _formulario(arg),
    );
  }

  Widget _formulario(Argumentos arg) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      children: [
        _inputDescripcionServicio(),
        Divider(),
        _inputTipoServicio(),
        Divider(),
        _inputPrecioServicio(),
        Divider(),
        _crearBoton(arg),
      ],
    );
  }

  Widget _crearBoton(Argumentos arg) {
    return CupertinoButton(
        child: Text(
          'Guardar',
          style: TextStyle(color: Colors.white),
        ),
        borderRadius: BorderRadius.circular(15),
        color: Colors.blueAccent,
        onPressed: () => _actionGuardar(arg));
  }

  void _actionGuardar(Argumentos arg) {
    print('creando');
    servicioBloc.crearNuevoServicio(servicio);
    if (navFrom == 'navFromHome') {
      Navigator.pop(context);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, 'servicios', ModalRoute.withName('sucursales'), arguments: arg);
    }
  }

  //=========================================================================INPUTS

  Widget _inputDescripcionServicio() {
    return TextFormField(
      // initialValue: servicio.servicioDescripcion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Descripción Servicio',
        labelText: 'Descripción Servicio',
      ),
      onChanged: (value) => servicio.servicioDescripcion = value,
    );
  }

  Widget _inputTipoServicio() {
    return TextFormField(
      // initialValue: servicio.servicioTipo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Tipo Servicio',
        labelText: 'Tipo Servicio',
      ),
      onChanged: (value) => servicio.servicioTipo = value,
    );
  }

  Widget _inputPrecioServicio() {
    return TextFormField(
      // initialValue: servicio.servicioTipo,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Precio Servicio',
        labelText: 'Precio Servicio',
      ),
      onChanged: (value) => servicio.sucursalServicioPrecio = double.parse(value),
    );
  }
}
