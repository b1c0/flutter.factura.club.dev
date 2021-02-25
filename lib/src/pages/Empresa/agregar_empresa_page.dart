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
  @override
  Widget build(BuildContext context) {
    crearEmpresaBloc = Provider.crearEmpresaBloc(context);
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
    print('a veeeeeeeeeeeeeeeeeeeeeeeeeeer');
    crearEmpresaBloc.crearNuevaEmpresa(empresa);
  }

  //===================================INPUTS============================

  Widget inputNombreEmpresa() {
    return TextField(
      // autofocus: true,
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
    return TextField(
      // autofocus: true,
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
    return TextField(
      // autofocus: true,
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
    return TextField(
      // autofocus: true,
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
    return TextField(
      // autofocus: true,
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
    return TextField(
      // autofocus: true,
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
