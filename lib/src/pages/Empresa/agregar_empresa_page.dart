import 'package:app_factura_club_dev/src/blocs/empresa_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:flutter/material.dart';

class NuevaEmpresaPage extends StatefulWidget {
  @override
  _NuevaEmpresaPageState createState() => _NuevaEmpresaPageState();
}

class _NuevaEmpresaPageState extends State<NuevaEmpresaPage> {
  Empresa empresa = Empresa.sinID();
  EmpresaBloc crearEmpresaBloc;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    crearEmpresaBloc = Provider.crearEmpresaBloc(context);
    final Empresa data = ModalRoute.of(context).settings.arguments;
    if (data != null) {
      empresa = data;
    }
    //EL ID DEL USUARIO CONECTADO
    empresa.usuarioId = 11;
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos Empresa'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Divider(),
            inputNombreEmpresa(),
            Divider(),
            inputCorreoEmpresa(),
            Divider(),
            inputTelefonoEmpresa(),
            Divider(),
            inputDireccionEmpresa(),
            Divider(),
            inputLogoEmpresa(),
            Divider(),
            inputRUCEmpresa(),
            Divider(),
            _botonGuardarEmpresa(),
          ],
        ),
      ),
    );
  }

  Widget _botonGuardarEmpresa() {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 85.0, vertical: 15.0),
          child: Text('Guardar'),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: Colors.blueAccent,
        textColor: Colors.white,
        onPressed: () {
          ingresarEmpresa();
        });
  }

  void ingresarEmpresa() {
    //TODO: VALIDAR VACIOS y validar el usuario logueado
    if (empresa.empresaId == null) {
      crearEmpresaBloc.crearNuevaEmpresa(empresa);
    } else {
      crearEmpresaBloc.actualizarEmpresa(empresa);
    }
    Navigator.pop(context);
  }

  //===================================INPUTS============================
  Widget inputNombreEmpresa() {
    return TextFormField(
      // autofocus: true,
      initialValue: empresa.empresaNombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Nombre Comercial',
        hintText: 'Nombre tal y como consta en el SRI',
      ),
      onChanged: (value) => empresa.empresaNombre = value,
    );
  }

  Widget inputCorreoEmpresa() {
    return TextFormField(
      // autofocus: true,
      initialValue: empresa.empresaCorreoCorporativo,
      textCapitalization: TextCapitalization.sentences,
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
      // autofocus: true,
      initialValue: empresa.empresaTelefono,
      textCapitalization: TextCapitalization.sentences,
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
      // autofocus: true,
      initialValue: empresa.empresaDireccion,

      textCapitalization: TextCapitalization.sentences,
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
      // autofocus: true,
      initialValue: empresa.empresaLogotipo,

      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.emailAddress,
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
      // autofocus: true,
      initialValue: empresa.empresaRuc,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'RUC',
        hintText: 'RUC',
      ),
      maxLength: 13,
      onChanged: (value) => empresa.empresaRuc = value,
    );
  }
}
