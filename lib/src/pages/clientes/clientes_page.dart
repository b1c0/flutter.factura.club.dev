import 'package:app_factura_club_dev/src/blocs/cliente_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Cliente.dart';
import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:flutter/material.dart';

class ClientesPage extends StatefulWidget {
  @override
  _ClientesPage createState() => _ClientesPage();
}

class _ClientesPage extends State<ClientesPage> {
  @override
  Widget build(BuildContext context) {
    Argumentos arg = ModalRoute.of(context).settings.arguments;
    Usuario usuario = arg.usuario;
    Sucursal sucursal = arg.sucursal;
    final clientesBloc = Provider.crearClienteBloc(context);
    clientesBloc.cargarClientes(sucursal.sucursalId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, 'nuevo-cliente');
              })
        ],
      ),
      body: _listarClientes(clientesBloc, arg),
    );
  }

  Widget _card() {
    return Card(
      margin: EdgeInsets.all(5.0),
      color: Colors.blue[300],
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(children: [
        ListTile(
          leading: Icon(
            Icons.person_pin_rounded,
            color: Colors.white,
            size: 40.0,
          ),
          title: Text(
            'Consumidor final',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            '9999999999999',
            style: TextStyle(color: Colors.white),
          ),
          trailing: Icon(
            Icons.menu_outlined,
            color: Colors.white,
            size: 30.0,
          ),
        ),
      ]),
    );
  }

  Widget _listarClientes(ClienteBloc clienteBloc, Argumentos arg) {
    return StreamBuilder(
      stream: clienteBloc.clientesStream,
      builder: (BuildContext context, AsyncSnapshot<List<Cliente>> snapshot) {
        if (snapshot.hasData) {
          final clientes = snapshot.data;
          return ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, i) {
                // sucursales[i].usuarioId = arg.usuario.idUser;
                return _crearItem(context, clienteBloc, clientes[i], arg);
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ClienteBloc clienteBloc, Cliente cliente, Argumentos arg) {
    return
        // Dismissible(
        //   key: UniqueKey(),
        //   background: Container(
        //     padding: EdgeInsets.only(right: 30),
        //     color: Colors.red,
        //     child: Align(
        //       child: Icon(Icons.delete, color: Colors.white),
        //       alignment: Alignment.centerRight,
        //     ),
        //   ),
        //   onDismissed: (direction) {
        //     mostrarAlertaEliminar(context, sucursalBloc, sucursal);
        //     setState(() {});
        //   },
        //   child:
        Card(
      margin: EdgeInsets.all(5.0),
      color: Colors.blue[300],
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: [
          Container(
            color: Colors.green,
            padding: EdgeInsets.all(5.0),
            child: ListTile(
                leading: Icon(Icons.business_sharp, color: Colors.white, size: 40.0),
                title: Text(cliente.clienteIdentificacion, style: TextStyle(color: Colors.white)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cliente.clienteDireccion, style: TextStyle(color: Colors.white)),
                  ],
                ),
                // trailing: _crearPopupMenuButton(sucursal, arg.usuario),
                onTap: () {
                  // Argumentos a = Argumentos.cliente(sucursal, arg.usuario);
                  Navigator.pushNamed(context, 'nuevo cliente').then((value) {
                    setState(() {});
                  });
                }),
          ),
        ],
      ),
      // ),
    );
  }
}
