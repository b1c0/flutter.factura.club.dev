import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/blocs/sucursal_bloc.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NuevaSucursalPage extends StatefulWidget {
  @override
  _NuevaSucursalPage createState() => _NuevaSucursalPage();
}

class _NuevaSucursalPage extends State<NuevaSucursalPage> {
  final _formKey = GlobalKey<FormState>();
  Sucursal sucursal = Sucursal.sinId();
  SucursalBloc sucursalBloc;

  @override
  Widget build(BuildContext context) {
    sucursalBloc = Provider.crearSucursalBloc(context);
    final Argumentos arg = ModalRoute.of(context).settings.arguments;
    final Usuario usuario = arg.usuario;
    final Empresa empresa = arg.empresa;
    final Sucursal data = arg.sucursal;
    if (data != null) {
      sucursal = data;
    }
    sucursal.empresaId = empresa.empresaId;
    sucursal.usuarioId = usuario.idUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Sucursal'),
      ),
      body: _formulario(arg),
    );
  }

  Widget _formulario(Argumentos arg) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // _inputCodigoEstablecimiento(),
            // Divider(),
            _inputNombreSucursal(),
            Divider(),
            _inputDireccionSucursal(),
            Divider(),
            _inputTelefonoSucursal(),
            Divider(),
            _inputCorreoSucursal(),
            Divider(),
            _inputRucSucursal(),
            Divider(),
            _botonGuardarSucursal(arg),
          ],
        ),
      ),
    );
  }

  //===========================================================================INPUTS

  Widget _inputCodigoEstablecimiento() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Codigo Establecimiento',
        labelText: 'Codigo Establecimiento',
      ),
      maxLength: 3,
      onChanged: (value) => "",
    );
  }

  Widget _inputNombreSucursal() {
    return TextFormField(
      initialValue: sucursal.sucursalNombre,
      maxLength: 250,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Nombre Sucursal ',
        labelText: 'Nombre Sucursal *',
      ),
      validator: (value) {
        if (value.isNotEmpty) {
          return null;
        } else {
          return 'El nombre es obligatorio';
        }
      },
      onChanged: (value) => sucursal.sucursalNombre = value,
    );
  }

  Widget _inputDireccionSucursal() {
    return TextFormField(
      initialValue: sucursal.sucursalDireccion,
      maxLength: 250,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Dirección Sucursal',
        labelText: 'Dirección Sucursal',
      ),
      onChanged: (value) => sucursal.sucursalDireccion = value,
    );
  }

  Widget _inputTelefonoSucursal() {
    return TextFormField(
      initialValue: sucursal.sucursalTelefono,
      keyboardType: TextInputType.number,
      maxLength: 25,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Teléfono Sucursal',
        labelText: 'Teléfono Sucursal',
      ),
      onChanged: (value) => sucursal.sucursalTelefono = value,
    );
  }

  Widget _inputCorreoSucursal() {
    return TextFormField(
      initialValue: sucursal.sucursalCorreoCorporativo,
      maxLength: 250,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Correo Sucursal',
        labelText: 'Correo Sucursal',
      ),
      onChanged: (value) => sucursal.sucursalCorreoCorporativo = value,
    );
  }

  Widget _inputRucSucursal() {
    return TextFormField(
      initialValue: sucursal.sucursalRuc,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'RUC Sucursal',
        labelText: 'RUC Sucursal *',
      ),
      validator: (value) {
        if (value.isNotEmpty) {
          return null;
        } else {
          return 'El RUC es obligatorio';
        }
      },
      onChanged: (value) => sucursal.sucursalRuc = value,
    );
  }

  //===========================================================================BOTONES

  Widget _botonGuardarSucursal(Argumentos arg) {
    return CupertinoButton(
      child: Text(
        'Guardar',
        style: TextStyle(color: Colors.white),
      ),
      borderRadius: BorderRadius.circular(15),
      color: Colors.blueAccent,
      onPressed: () => _ingresarSucursal(arg),
    );
  }

  //===========================================================================MÉTODOS
  void _ingresarSucursal(Argumentos arg) {
    if (!_formKey.currentState.validate()) return;
    if (sucursal.sucursalId == null) {
      print('creando');
      sucursalBloc.crearNuevaSucursal(sucursal);
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, 'sucursales', arguments: arg);
    } else {
      print('actualizando');

      sucursalBloc.actualizarSucursal(sucursal);
      Navigator.popAndPushNamed(context, 'sucursales', arguments: arg);
    }
  }
}
