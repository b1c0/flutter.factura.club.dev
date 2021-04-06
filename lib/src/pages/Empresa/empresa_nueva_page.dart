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
  final _formKey = GlobalKey<FormState>();
  Empresa empresa = Empresa.sinId();
  EmpresaBloc crearEmpresaBloc;

  @override
  Widget build(BuildContext context) {
    final Argumentos arg = ModalRoute.of(context).settings.arguments;
    final Usuario usuario = arg.usuario;
    final Empresa data = arg.empresa;
    crearEmpresaBloc = Provider.crearEmpresaBloc(context);

    empresa = data;
    empresa.usuarioId = usuario.idUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Datos Empresa'),
      ),
      body: Container(child: _formulario(usuario)),
    );
  }

  //===========================================================================FORMULARIO
  Form _formulario(Usuario usuario) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _inputNombreEmpresa(),
            _inputRUCEmpresa(),
            _inputCorreoEmpresa(),
            _inputTelefonoEmpresa(),
            _inputDireccionEmpresa(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _inputLogoEmpresa(),
                IconButton(
                  icon: Icon(
                    Icons.upload_file,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {},
                ),
                // inputLogoEmpresa(),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _inputFirmaEmpresa(),
                IconButton(
                  icon: Icon(
                    Icons.upload_file,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {},
                ),
                // inputLogoEmpresa(),
              ],
            ),
            Divider(),
            _botonGuardarEmpresa(usuario),
          ],
        ),
      ),
    );
  }

  //===========================================================================INPUTS
  Widget _inputNombreEmpresa() {
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

  Widget _inputCorreoEmpresa() {
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

  Widget _inputTelefonoEmpresa() {
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

  Widget _inputDireccionEmpresa() {
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

  Widget _inputLogoEmpresa() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.75,
      child: TextFormField(
        // initialValue: empresa.empresaLogotipo,
        enabled: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: 'LOGO',
          // hintText: 'Cargar imagen',
        ),
        // onChanged: (value) => empresa.empresaLogotipo = value,
      ),
    );
  }

  Widget _inputFirmaEmpresa() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.75,
      child: TextFormField(
        // initialValue: empresa.empresaLogotipo,
        enabled: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: 'Archivo p12',
          // hintText: 'Cargar imagen',
        ),
        // onChanged: (value) => empresa.empresaLogotipo = value,
      ),
    );
  }

  Widget _inputRUCEmpresa() {
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
      onPressed: () => _ingresarEmpresa(usuario),
    );
  }

//===========================================================================MÉTODOS
  void _ingresarEmpresa(Usuario usuario) {
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
