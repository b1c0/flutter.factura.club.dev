import 'package:app_factura_club_dev/src/blocs/empresa_bloc.dart';
import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/blocs/sucursal_bloc.dart';
import 'package:app_factura_club_dev/src/models/Empresa.dart';
import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:flutter/material.dart';

class SucursalesPage extends StatefulWidget {
  @override
  _SucursalesPage createState() => _SucursalesPage();
}

class _SucursalesPage extends State<SucursalesPage> {
  String _opcionSeleccionada = '';
  List<String> _opciones = ['Pago', 'Efectivo', 'Tarjeta Débito', 'Tarjeta Crédito'];
  @override
  Widget build(BuildContext context) {
    int empresa_id = 9;
    int usuario_id = 11;
    final empresasBloc = Provider.crearEmpresaBloc(context);
    empresasBloc.cargarEmpresas(usuario_id);
    final sucursalesBloc = Provider.crearSucursalBloc(context);
    sucursalesBloc.cargarSucursales(empresa_id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sucursales'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, 'nueva-sucursal');
              })
        ],
      ),
      body: Column(children: [
        // Container(height: 100, width: 100, child: _crearDropDown(empresas)),
        // _listar(sucursalesBloc),
      ]),
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
          leading: Icon(Icons.add_business, color: Colors.white, size: 40.0),
          title: Text(
            '001',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dirección',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Telefono',
                style: TextStyle(color: Colors.white),
              )
            ],
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

  _listar(SucursalBloc sucursalBloc) {
    return StreamBuilder(
      stream: sucursalBloc.sucursalesStream,
      builder: (BuildContext context, AsyncSnapshot<List<Sucursal>> snapshot) {
        if (snapshot.hasData) {
          final sucursales = snapshot.data;
          return ListView.builder(
            itemCount: sucursales.length,
            itemBuilder: (context, i) => _crearItem(context, sucursalBloc, sucursales[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _crearItem(BuildContext context, SucursalBloc sucursalBloc, Sucursal sucursal) {
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
              title: Text(sucursal.sucursalNombre, style: TextStyle(color: Colors.white)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sucursal.sucursalDireccion, style: TextStyle(color: Colors.white)),
                  Text(sucursal.sucursalTelefono, style: TextStyle(color: Colors.white)),
                ],
              ),
              trailing: Icon(Icons.more_vert, color: Colors.white, size: 30.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearDropDown(List<DropdownMenuItem<String>> empresas) {
    _opcionSeleccionada = empresas[0].toString();
    print(_opcionSeleccionada);
    return Row(
      children: [
        SizedBox(width: 10),
        Expanded(
          child: DropdownButton(
              value: _opcionSeleccionada,
              items: empresas,
              onChanged: (opt) {
                setState(() {
                  _opcionSeleccionada = opt;
                });
              }),
        ),
      ],
    );
  }
}
