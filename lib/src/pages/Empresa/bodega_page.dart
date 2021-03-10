import 'package:app_factura_club_dev/src/blocs/bodega_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Bodega.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:flutter/material.dart';

class BodegaPage extends StatefulWidget {
  @override
  _BodegaPageState createState() => _BodegaPageState();
}

class _BodegaPageState extends State<BodegaPage> {
  @override
  Widget build(BuildContext context) {
    final Argumentos arg = ModalRoute.of(context).settings.arguments;
    // final Usuario usuario = arg.usuario;
    final Empresa empresa = arg.empresa;
    final bodegaBloc = Provider.crearBodegaBloc(context);
    bodegaBloc.cargarBodegas(empresa.empresaId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bodegas'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, 'nueva-bodega', arguments: arg);
              })
        ],
      ),
      body:
          // Container(),
          _listarBodegas(bodegaBloc, arg),
    );
  }

  _listarBodegas(BodegaBloc bodegaBloc, Argumentos arg) {
    return StreamBuilder(
      stream: bodegaBloc.bodegasStream,
      builder: (BuildContext context, AsyncSnapshot<List<Bodega>> snapshot) {
        if (snapshot.hasData) {
          final bodegas = snapshot.data;
          return ListView.builder(
              itemCount: bodegas.length,
              itemBuilder: (context, i) {
                bodegas[i].usuarioId = arg.usuario.idUser;
                return _crearItem(context, bodegaBloc, bodegas[i], arg);
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _crearItem(BuildContext context, BodegaBloc bodegaBloc, Bodega bodega, Argumentos arg) {
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
        mostrarAlertaEliminar(context, bodegaBloc, bodega);
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
                  leading: Icon(Icons.inventory, color: Colors.white, size: 40.0),
                  title: Text(bodega.bodegaId.toString(), style: TextStyle(color: Colors.white)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bodega.bodegaNombre, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  trailing: _crearPopupMenuButton(bodega, arg.usuario),
                  onTap: () {
                    Argumentos a = Argumentos.bodega(arg.empresa, arg.usuario, bodega);
                    Navigator.pushNamed(context, 'nueva-bodega', arguments: a).then((value) {
                      setState(() {});
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearPopupMenuButton(Bodega bodega, Usuario usuario) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
        size: 30,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(
                Icons.category,
                color: Colors.blue,
              ),
              FlatButton(
                child: Text('Ver Productos'),
                onPressed: () {
                  Argumentos arg = Argumentos.productos(bodega, usuario);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'productos', arguments: arg);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void mostrarAlertaEliminar(BuildContext context, BodegaBloc bodegaBloc, Bodega bodega) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Eliminar'),
            content: Text('¿Esta seguro que desea eliminar esta bodega?'),
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
                        _eliminarBodega(bodegaBloc, bodega),
                        Navigator.pop(context),
                        setState(() {}),
                      })
            ],
          );
        });
  }

  void _eliminarBodega(BodegaBloc bodegaBloc, Bodega bodega) {
    bodegaBloc.eliminarBodega(bodega.usuarioId, bodega.bodegaId);
  }
}
