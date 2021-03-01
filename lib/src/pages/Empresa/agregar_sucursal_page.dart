import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/blocs/sucursal_bloc.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:flutter/material.dart';

class NuevaSucursalPage extends StatefulWidget {
  @override
  _NuevaSucursalPage createState() => _NuevaSucursalPage();
}

class _NuevaSucursalPage extends State<NuevaSucursalPage> {
  Sucursal sucursal = Sucursal();
  SucursalBloc sucursalBloc;

  @override
  Widget build(BuildContext context) {
    sucursalBloc = Provider.crearSucursalBloc(context);
    final Empresa empresa = ModalRoute.of(context).settings.arguments;
    final Usuario usuario = ModalRoute.of(context).settings.arguments;
    sucursal.empresaId = empresa.empresaId;
    sucursal.usuarioId = usuario.idUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Sucursal'),
      ),
      body: _formulario(),
    );
  }

  ListView _formulario() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      children: [
        _inputCodigoEstablecimiento(),
        Divider(),
        _inputCodigoNombreSucursal(),
        Divider(),
        _inputDireccionSucursal(),
        Divider(),
        _inputTelefonoSucursal(),
        Divider(),
        _inputCorreoSucursal(),
        Divider(),
        _inputRucSucursal(),
        Divider(),
        _crearBoton(),
      ],
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
        onPressed: () {
          _botonGuardarSucursal();
        });
  }

  void _botonGuardarSucursal() {
    //TODO: VALIDAR VACIOS

    sucursalBloc.crearNuevaSucursal(sucursal);
  }

  //================================INPUTS===========================
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

  Widget _inputCodigoNombreSucursal() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Nombre Sucursal',
        labelText: 'Nombre Sucursal',
      ),
      onChanged: (value) => sucursal.sucursalNombre = value,
    );
  }

  Widget _inputDireccionSucursal() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Dirección Sucursal',
        labelText: 'Dirección Sucursal',
      ),
      onChanged: (value) => sucursal.sucursalDireccion = value,
    );
  }

  Widget _inputTelefonoSucursal() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Teléfono Sucursal',
        labelText: 'Teléfono Sucursal',
      ),
      onChanged: (value) => sucursal.sucursalTelefono = value,
    );
  }

  Widget _inputCorreoSucursal() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Correo Sucursal',
        labelText: 'Correo Sucursal',
      ),
      onChanged: (value) => sucursal.sucursalCorreoCorporativo = value,
    );
  }

  Widget _inputRucSucursal() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'RUC Sucursal',
        labelText: 'RUC Sucursal',
      ),
      onChanged: (value) => sucursal.sucursalRuc = value,
    );
  }
}
