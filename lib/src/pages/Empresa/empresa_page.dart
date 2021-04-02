import 'package:app_factura_club_dev/src/blocs/empresa_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmpresaPage extends StatefulWidget {
  @override
  _EmpresaPage createState() => _EmpresaPage();
}

class _EmpresaPage extends State<EmpresaPage> {
  @override
  Widget build(BuildContext context) {
    final Usuario usuario = ModalRoute.of(context).settings.arguments;
    final empresasBloc = Provider.crearEmpresaBloc(context);
    empresasBloc.cargarEmpresas(usuario.idUser);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Empresas'),
        actions: [
          IconButton(
              icon: Icon(Icons.add_business),
              onPressed: () {
                Argumentos arg = Argumentos(Empresa(), usuario);
                Navigator.pushNamed(context, 'nueva-empresa', arguments: arg).then((value) {
                  setState(() {});
                });
              })
        ],
      ),
      body: _listarEmpresas(empresasBloc, usuario),
    );
  }

  //===========================================================================WIDGETS

  Widget _listarEmpresas(EmpresaBloc empresasBloc, Usuario usuario) {
    return StreamBuilder(
      stream: empresasBloc.empresasStream,
      builder: (BuildContext context, AsyncSnapshot<List<Empresa>> snapshot) {
        if (snapshot.hasData) {
          final empresas = snapshot.data;
          return ListView.builder(
              itemCount: empresas.length,
              itemBuilder: (context, i) {
                empresas[i].usuarioId = usuario.idUser;
                return _crearItem(context, empresasBloc, empresas[i], usuario);
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, EmpresaBloc empresasBloc, Empresa empresa, Usuario usuario) {
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
        _mostrarAlertaEliminar(context, empresasBloc, empresa);
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
              padding: EdgeInsets.all(5.0),
              child: ListTile(
                  leading: Icon(Icons.business_sharp, color: Colors.white, size: 40.0),
                  trailing: _crearPopUpMenuButton(empresa, usuario),
                  title: Text(empresa.empresaNombre, style: TextStyle(color: Colors.white)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(empresa.empresaRuc, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  onTap: () {
                    Argumentos arg = Argumentos(empresa, usuario);
                    Navigator.pushNamed(context, 'nueva-empresa', arguments: arg).then((value) {
                      setState(() {});
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearPopUpMenuButton(Empresa empresa, Usuario usuario) {
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
              Icon(Icons.home_work_sharp, color: Colors.blue),
              CupertinoButton(
                child: Text('Ver Sucursales'),
                onPressed: () {
                  Argumentos arg = Argumentos(empresa, usuario);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'sucursales', arguments: arg);
                },
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(Icons.inventory, color: Colors.blue),
              CupertinoButton(
                child: Text('Ver Bodegas'),
                onPressed: () {
                  Argumentos arg = Argumentos(empresa, usuario);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'bodega', arguments: arg);
                },
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              Icon(Icons.menu_book, color: Colors.blue),
              CupertinoButton(
                child: Text('Ver Categorias Productos'),
                onPressed: () {
                  Argumentos arg = Argumentos(empresa, usuario);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'categoria', arguments: arg);
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  //===========================================================================MÉTODOS
  void _eliminarEmpresa(EmpresaBloc empresasBloc, Empresa empresa) {
    empresasBloc.eliminarEmpresa(empresa.empresaId, empresa.usuarioId);
  }

  void _mostrarAlertaEliminar(BuildContext context, EmpresaBloc empresasBloc, Empresa empresa) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Eliminar'),
            content: Text('¿Esta seguro que desea eliminar esta Empresa: "${empresa.empresaNombre}"'),
            actions: [
              CupertinoButton(
                onPressed: () => {
                  Navigator.pop(context),
                },
                child: Text('Cancelar'),
              ),
              CupertinoButton(
                  child: Text('OK'),
                  onPressed: () => {
                        _eliminarEmpresa(empresasBloc, empresa),
                        Navigator.pop(context),
                        setState(() {}),
                      })
            ],
          );
        });
  }
}
