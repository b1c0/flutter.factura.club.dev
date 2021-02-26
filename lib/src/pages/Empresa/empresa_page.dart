import 'package:app_factura_club_dev/src/blocs/empresa_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:flutter/material.dart';

class EmpresaPage extends StatefulWidget {
  @override
  _EmpresaPage createState() => _EmpresaPage();
}

class _EmpresaPage extends State<EmpresaPage> {
  @override
  Widget build(BuildContext context) {
    //id del usuario logueado
    final usuario_id = 11;
    final empresasBloc = Provider.crearEmpresaBloc(context);
    empresasBloc.cargarEmpresas(usuario_id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Empresas'),
        actions: [
          IconButton(
              icon: Icon(Icons.add_business),
              onPressed: () {
                Navigator.pushNamed(context, 'nueva-empresa');
              })
        ],
      ),
      body: _listarEmpresas(empresasBloc, usuario_id),
    );
  }

  Widget _listarEmpresas(EmpresaBloc empresasBloc, int usuario_id) {
    return StreamBuilder(
      stream: empresasBloc.empresasStream,
      builder: (BuildContext context, AsyncSnapshot<List<Empresa>> snapshot) {
        if (snapshot.hasData) {
          final empresas = snapshot.data;
          return ListView.builder(
              itemCount: empresas.length,
              itemBuilder: (context, i) {
                empresas[i].usuarioId = usuario_id;
                return _crearItem(
                  context,
                  empresasBloc,
                  empresas[i],
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, EmpresaBloc empresasBloc, Empresa empresa) {
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
        mostrarAlertaEliminar(context, empresasBloc, empresa);
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
                  trailing: Icon(Icons.more_vert, color: Colors.white, size: 30.0),
                  title: Text(empresa.empresaNombre, style: TextStyle(color: Colors.white)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(empresa.empresaRuc, style: TextStyle(color: Colors.white)),
                      Text(empresa.empresaDireccion, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  onTap: () => Navigator.pushNamed(context, 'nueva-empresa', arguments: empresa).then((value) {
                        setState(() {});
                      })),
            ),
          ],
        ),
      ),
    );
  }

  void _eliminarEmpresa(EmpresaBloc empresasBloc, Empresa empresa) {
    empresasBloc.eliminarEmpresa(empresa.empresaId, empresa.usuarioId);
  }

  void mostrarAlertaEliminar(BuildContext context, EmpresaBloc empresasBloc, Empresa empresa) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Eliminar'),
            content: Text('¿Esta seguro que desea eliminar esta empresa?'),
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
                        _eliminarEmpresa(empresasBloc, empresa),
                        Navigator.pop(context),
                        setState(() {}),
                      })
            ],
          );
        });
  }
}
