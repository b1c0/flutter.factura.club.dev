import 'package:app_factura_club_dev/src/blocs/empresa_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NuevaEmpresaPage extends StatefulWidget {
  @override
  _NuevaEmpresaPageState createState() => _NuevaEmpresaPageState();
}

class _NuevaEmpresaPageState extends State<NuevaEmpresaPage> {
  Empresa empresa = Empresa.sinID();
  EmpresaBloc crearEmpresaBloc;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    crearEmpresaBloc = Provider.crearEmpresaBloc(context);
    final Argumentos arg = ModalRoute.of(context).settings.arguments;
    final Usuario usuario = arg.usuario;
    final Empresa data = arg.empresa;
    if (data != null) {
      empresa = data;
      print(empresa.empresaId);
    }
    //EL ID DEL USUARIO CONECTADO
    empresa.usuarioId = usuario.idUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Datos Empresa'),
      ),
      body: _formulario(usuario),
    );
  }

  Form _formulario(Usuario usuario) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            inputNombreEmpresa(),
            inputRUCEmpresa(),
            inputCorreoEmpresa(),
            inputTelefonoEmpresa(),
            inputDireccionEmpresa(),
            inputLogoEmpresa(),
            Divider(),
            _botonGuardarEmpresa(usuario),
          ],
        ),
      ),
    );
  }

  //===========================================================================INPUTS
  Widget inputNombreEmpresa() {
    return TextFormField(
      initialValue: empresa.empresaNombre,
      maxLength: 250,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Nombre Comercial *',
        hintText: 'Nombre tal y como consta en el SRI',
      ),
      validator: (value) {
        if (value.isNotEmpty) {
          return null;
        } else {
          return 'El nombre es obligatorio';
        }
      },
      onChanged: (value) => empresa.empresaNombre = value,
    );
  }

  Widget inputCorreoEmpresa() {
    return TextFormField(
      initialValue: empresa.empresaCorreoCorporativo,
      maxLength: 100,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Correo Corporativo',
        hintText: 'Correo Electronico',
      ),
      onChanged: (value) => empresa.empresaCorreoCorporativo = value,
    );
  }

  Widget inputTelefonoEmpresa() {
    return TextFormField(
      initialValue: empresa.empresaTelefono,
      maxLength: 25,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Telefono',
        hintText: 'Telefono',
      ),
      onChanged: (value) => empresa.empresaTelefono = value,
    );
  }

  Widget inputDireccionEmpresa() {
    return TextFormField(
      initialValue: empresa.empresaDireccion,
      maxLength: 250,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Dirección',
        hintText: 'Dirección',
      ),
      onChanged: (value) => empresa.empresaDireccion = value,
    );
  }

  Widget inputLogoEmpresa() {
    return TextFormField(
      initialValue: empresa.empresaLogotipo,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Logo Empresa',
        hintText: 'Cargar imagen',
      ),
      onChanged: (value) => empresa.empresaLogotipo = value,
    );
  }

  Widget inputRUCEmpresa() {
    return TextFormField(
      initialValue: empresa.empresaRuc,
      maxLength: 13,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'RUC',
        hintText: 'RUC',
      ),
      onChanged: (value) => empresa.empresaRuc = value,
    );
  }

  //===========================================================================BOTONES
  Widget _botonGuardarEmpresa(Usuario usuario) {
    return CupertinoButton(
      child: Text('Guardar', style: TextStyle(color: Colors.white)),
      color: Colors.blueAccent,
      onPressed: () => ingresarEmpresa(usuario),
    );
  }

//===========================================================================MÉTODOS
  void ingresarEmpresa(Usuario usuario) {
    if (!_formKey.currentState.validate()) return;
    if (empresa.empresaId == null) {
      crearEmpresaBloc.crearNuevaEmpresa(empresa);
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, 'empresa', arguments: usuario);
    } else {
      crearEmpresaBloc.actualizarEmpresa(empresa);
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, 'empresa', arguments: usuario);
    }
  }
}
