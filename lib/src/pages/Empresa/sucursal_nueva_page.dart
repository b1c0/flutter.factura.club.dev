import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/blocs/sucursal_bloc.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:flutter/material.dart';

class NuevaSucursalPage extends StatefulWidget {
  @override
  _NuevaSucursalPage createState() => _NuevaSucursalPage();
}

class _NuevaSucursalPage extends State<NuevaSucursalPage> {
  Sucursal sucursal = Sucursal.sinId();
  SucursalBloc sucursalBloc;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    sucursalBloc = Provider.crearSucursalBloc(context);
    final Argumentos arg = ModalRoute.of(context).settings.arguments;

    final Usuario usuario = arg.usuario;
    final Empresa empresa = arg.empresa;
    final Sucursal data = arg.sucursal;
    sucursal.empresaId = empresa.empresaId;
    sucursal.usuarioId = usuario.idUser;
    if (data != null) {
      sucursal = data;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Sucursal'),
      ),
      body: _formulario(arg),
    );
  }

  ListView _formulario(Argumentos arg) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      children: [
        _inputCodigoEstablecimiento(),
        Divider(),
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
        _crearBoton(arg),
      ],
    );
  }

  Widget _crearBoton(Argumentos arg) {
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
          _actionGuardarSucursal(arg);
        });
  }

  void _actionGuardarSucursal(Argumentos arg) {
    //TODO: VALIDAR VACIOS
    print('aaaaaaaaaaaaaaaaaaa');
    if (sucursal.sucursalId == null) {
      sucursalBloc.crearNuevaSucursal(sucursal);
      print('creando');
    } else {
      print('actualizando');

      sucursalBloc.actualizarSucursal(sucursal);
    }
    Navigator.pushNamedAndRemoveUntil(context, 'sucursales', ModalRoute.withName('empresa'), arguments: arg);
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

  Widget _inputNombreSucursal() {
    return TextFormField(
      initialValue: sucursal.sucursalNombre,
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
    return TextFormField(
      initialValue: sucursal.sucursalDireccion,
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
    return TextFormField(
      initialValue: sucursal.sucursalTelefono,
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
    return TextFormField(
      initialValue: sucursal.sucursalCorreoCorporativo,
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
    return TextFormField(
      initialValue: sucursal.sucursalRuc,
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
