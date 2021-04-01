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
  final _formKey = GlobalKey<FormState>();
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

    final Servicio data = arg.servicio;
    if (data != null) {
      servicio = data;
    }

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
    return Form(
      key: _formKey,
      child: ListView(
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
      ),
    );
  }

  //=========================================================================INPUTS

  Widget _inputDescripcionServicio() {
    return TextFormField(
      initialValue: servicio.servicioDescripcion,
      maxLength: 250,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Descripción Servicio',
        labelText: 'Descripción Servicio',
      ),
      validator: (value) {
        if (value.isNotEmpty) {
          return null;
        } else {
          return 'El campo es obligatorio';
        }
      },
      onChanged: (value) => servicio.servicioDescripcion = value,
    );
  }

  Widget _inputTipoServicio() {
    return TextFormField(
      initialValue: servicio.servicioTipo,
      maxLength: 250,
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
      initialValue: servicio.sucursalServicioPrecio.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Precio Servicio',
        labelText: 'Precio Servicio',
      ),
      validator: (value) {
        if (value.isNotEmpty) {
          return null;
        } else {
          return 'El campo es obligatorio';
        }
      },
      onChanged: (value) => servicio.sucursalServicioPrecio = double.parse(value),
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
    if (!_formKey.currentState.validate()) return;

    if (servicio.servicioId == null) {
      print('creando');
      servicioBloc.crearNuevoServicio(servicio);
      Navigator.pop(context);
      if (navFrom == 'navFromHome') {
        Navigator.popAndPushNamed(context, 'servicios', arguments: arg);
      }
      Navigator.popAndPushNamed(context, 'servicios', arguments: arg);
    } else {
      print('actualizando');
      servicioBloc.actualizarServicio(servicio);
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, 'servicios', arguments: arg);
    }
  }
}
