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
    int usuario_id = 12;
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
      body: _listarEmpresas(empresasBloc),
    );
  }

  Widget _listarEmpresas(EmpresaBloc empresasBloc) {
    return StreamBuilder(
      stream: empresasBloc.empresasStream,
      builder: (BuildContext context, AsyncSnapshot<List<Empresa>> snapshot) {
        if (snapshot.hasData) {
          final empresas = snapshot.data;
          return ListView.builder(itemCount: empresas.length, itemBuilder: (context, i) => _crearItem(context, empresasBloc, empresas[i]));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _crearItem(BuildContext context, EmpresaBloc empresasBloc, Empresa empresa) {
    return Card(
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
              title: Text(empresa.empresaNombre, style: TextStyle(color: Colors.white)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(empresa.empresaRuc, style: TextStyle(color: Colors.white)),
                  Text(empresa.empresaDireccion, style: TextStyle(color: Colors.white)),
                ],
              ),
              trailing: Icon(Icons.more_vert, color: Colors.white, size: 30.0),
            ),
          ),
        ],
      ),
    );
  }
}
