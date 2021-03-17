import 'package:app_factura_club_dev/src/blocs/cliente_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Cliente.dart';
import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NuevoClientePage extends StatefulWidget {
  @override
  _NuevoClientePage createState() => _NuevoClientePage();
}

class _NuevoClientePage extends State<NuevoClientePage> {
  Cliente cliente = Cliente.sinId();
  ClienteBloc clienteBloc;
  String navFrom;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    clienteBloc = Provider.crearClienteBloc(context);
    final Argumentos arg = ModalRoute.of(context).settings.arguments;
    navFrom = arg.navFrom;
    Usuario usuario = arg.usuario;
    Sucursal sucursal = arg.sucursal;
    Cliente data = arg.cliente;
    if (data != null) {
      cliente = data;
    }
    cliente.usuarioId = usuario.idUser;
    cliente.sucursalId = sucursal.sucursalId;

    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Cliente'),
        centerTitle: true,
      ),
      body: _formulario(arg),
    );
  }

  ListView _formulario(Argumentos arg) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      children: [
        // _crearDropDown(),
        _inputIdentificacion(),
        Divider(),
        _inputNombres(),
        Divider(),
        _inputCorreo(),
        Divider(),
        _inputDireccion(),
        Divider(),
        _inputCelular(),
        Divider(),
        _inputTelefono(),
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
        color: Colors.blueAccent,
        onPressed: () {
          _guardarCliente(arg);
        });
  }

  void _guardarCliente(Argumentos arg) {
    if (cliente.clienteId == null) {
      print('creando');
      clienteBloc.crearNuevoCliente(cliente);
      if (navFrom == 'navFromHome') {
        Navigator.pop(context);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, 'clientes', ModalRoute.withName('sucursales'), arguments: arg);
      }
    } else {
      print('actualizando');
      clienteBloc.actualizarClientes(cliente);
      Navigator.pushNamedAndRemoveUntil(context, 'clientes', ModalRoute.withName('sucursales'), arguments: arg);
    }
  }

//=======================================================================INPUTS
  Widget _inputIdentificacion() {
    return TextFormField(
      // autofocus: true,
      initialValue: cliente.clienteIdentificacion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Cedula, Pasaporte, o RUC',
        hintText: 'Numero de Identificacion',
      ),
      onChanged: (value) => cliente.clienteIdentificacion = value,
    );
  }

  Widget _inputNombres() {
    return TextFormField(
      // autofocus: true,
      initialValue: cliente.clienteNombres,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Nombres y Apellidos',
        hintText: 'Nombres y Apellidos',
      ),
      onChanged: (value) => cliente.clienteNombres = value,
    );
  }

  Widget _inputCorreo() {
    return TextFormField(
      // autofocus: true,
      initialValue: cliente.clienteCorreo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Correo',
        hintText: 'Correo',
      ),
      onChanged: (value) => cliente.clienteCorreo = value,
    );
  }

  Widget _inputDireccion() {
    return TextFormField(
      // autofocus: true,
      initialValue: cliente.clienteDireccion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Dirección',
        hintText: 'Dirección',
      ),
      onChanged: (value) => cliente.clienteDireccion = value,
    );
  }

  Widget _inputCelular() {
    return TextFormField(
      // autofocus: true,
      initialValue: cliente.clienteCelular,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Teléfono Celular',
        hintText: 'Teléfono Celular',
      ),
      onChanged: (value) => cliente.clienteCelular = value,
    );
  }

  Widget _inputTelefono() {
    return TextFormField(
      // autofocus: true,
      initialValue: cliente.clienteTelefono,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelText: 'Teléfono Convencional',
        hintText: 'Teléfono Convencional',
      ),
      onChanged: (value) => cliente.clienteTelefono = value,
    );
  }
}
