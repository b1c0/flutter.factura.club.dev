import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/blocs/sucursal_bloc.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:app_factura_club_dev/src/pages/Empresa/empresa_page.dart';
import 'package:flutter/material.dart';

class SucursalesPage extends StatefulWidget {
  @override
  _SucursalesPage createState() => _SucursalesPage();
}

class _SucursalesPage extends State<SucursalesPage> {
  @override
  Widget build(BuildContext context) {
    final Argumentos arg = ModalRoute.of(context).settings.arguments;
    final Usuario usuario = arg.usuario;
    final Empresa empresa = arg.empresa;
    final empresasBloc = Provider.crearEmpresaBloc(context);
    empresasBloc.cargarEmpresas(usuario.idUser);
    final sucursalesBloc = Provider.crearSucursalBloc(context);
    sucursalesBloc.cargarSucursales(empresa.empresaId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sucursales'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, 'nueva-sucursal', arguments: arg);
              })
        ],
      ),
      body:
          // Container(height: 100, width: 100, child: _crearDropDown(empresas)),
          _listar(sucursalesBloc, arg),
    );
  }

  _listar(SucursalBloc sucursalBloc, Argumentos arg) {
    return StreamBuilder(
      stream: sucursalBloc.sucursalesStream,
      builder: (BuildContext context, AsyncSnapshot<List<Sucursal>> snapshot) {
        if (snapshot.hasData) {
          final sucursales = snapshot.data;
          return ListView.builder(
              itemCount: sucursales.length,
              itemBuilder: (context, i) {
                sucursales[i].usuarioId = arg.usuario.idUser;
                return _crearItem(context, sucursalBloc, sucursales[i], arg);
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _crearItem(BuildContext context, SucursalBloc sucursalBloc, Sucursal sucursal, Argumentos arg) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        padding: EdgeInsets.only(right: 30),
        color: Colors.red,
        child: Align(
          child: Icon(Icons.delete, color: Colors.white),
          alignment: Alignment.centerRight,
        ),
      ),
      onDismissed: (direction) {
        mostrarAlertaEliminar(context, sucursalBloc, sucursal);
        setState(() {});
      },
      child: Card(
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
                  title: Text(sucursal.sucursalNombre, style: TextStyle(color: Colors.white)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sucursal.sucursalDireccion, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  trailing: Icon(Icons.more_vert, color: Colors.white, size: 30.0),
                  onTap: () {
                    Argumentos a = Argumentos.sucursal(arg.empresa, arg.usuario, sucursal);
                    Navigator.pushNamed(context, 'nueva-sucursal', arguments: a).then((value) {
                      setState(() {});
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void mostrarAlertaEliminar(BuildContext context, SucursalBloc sucursalBloc, Sucursal sucursal) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Eliminar'),
            content: Text('¿Esta seguro que desea eliminar esta sucursal?'),
            actions: [
              FlatButton(
                onPressed: () => {
                  Navigator.pop(context),
                },
                child: Text('Cancelar'),
              ),
              FlatButton(
                  child: Text('OK'),
                  onPressed: () => {
                        _eliminarSucursal(sucursalBloc, sucursal),
                        Navigator.pop(context),
                        setState(() {}),
                      })
            ],
          );
        });
  }

  void _eliminarSucursal(SucursalBloc sucursalBloc, Sucursal sucursal) {
    sucursalBloc.eliminarSucursal(sucursal.usuarioId, sucursal.sucursalId);
  }
}
