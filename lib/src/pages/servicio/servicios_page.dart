import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/blocs/servicio_bloc.dart';
import 'package:app_factura_club_dev/src/models/Argumentos.dart';
import 'package:app_factura_club_dev/src/models/Servicio.dart';
import 'package:app_factura_club_dev/src/models/Sucursal.dart';
import 'package:flutter/material.dart';

class ServiciosPage extends StatefulWidget {
  @override
  _ServiciosPageState createState() => _ServiciosPageState();
}

class _ServiciosPageState extends State<ServiciosPage> {
  @override
  Widget build(BuildContext context) {
    final Argumentos arg = ModalRoute.of(context).settings.arguments;
    final Sucursal sucursal = arg.sucursal;
    final servicioBloc = Provider.crearServicioBloc(context);
    servicioBloc.cargarServicios(sucursal.sucursalId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Servicios'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Argumentos a = Argumentos.servicio(arg.sucursal, arg.usuario, Servicio(), 'navFromServicio');
                Navigator.pushNamed(context, 'nuevo-servicio', arguments: a).then((value) {
                  setState(() {});
                });
              })
        ],
      ),
      body: _listarServicios(servicioBloc, arg),
    );
  }

  //===========================================================================WIDGETS
  Widget _listarServicios(ServicioBloc servicioBloc, Argumentos arg) {
    return StreamBuilder(
      stream: servicioBloc.serviciosStream,
      builder: (BuildContext context, AsyncSnapshot<List<Servicio>> snapshot) {
        if (snapshot.hasData) {
          final servicios = snapshot.data;
          return ListView.builder(
              itemCount: servicios.length,
              itemBuilder: (context, i) {
                servicios[i].usuarioId = arg.usuario.idUser;
                return _crearItem(context, servicioBloc, servicios[i], arg);
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _crearItem(BuildContext context, ServicioBloc servicioBloc, Servicio servicio, Argumentos arg) {
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
        //     mostrarAlertaEliminar(context, productoBloc, producto);
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
            color: Colors.cyan,
            padding: EdgeInsets.all(5.0),
            child: ListTile(
                leading: Icon(Icons.miscellaneous_services, color: Colors.white, size: 40.0),
                title: Text(servicio.servicioDescripcion.toString(), style: TextStyle(color: Colors.white)),
                subtitle: Text(servicio.sucursalServicioPrecio.toString(), style: TextStyle(color: Colors.white)),
                onTap: () {
                  Argumentos a = Argumentos.servicio(arg.sucursal, arg.usuario, servicio, 'navFromServicio');
                  Navigator.pushNamed(context, 'nuevo-servicio', arguments: a).then((value) {
                    setState(() {});
                  });
                }),
          ),
        ],
      ),
      // ),
    );
  }
  //===========================================================================MÉTODOS

}
