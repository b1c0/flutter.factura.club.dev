import 'package:app_factura_club_dev/src/blocs/provider.dart';
import 'package:app_factura_club_dev/src/pages/Empresa/empresa_page.dart';
import 'package:app_factura_club_dev/src/pages/acceso/login_page.dart';
import 'package:app_factura_club_dev/src/pages/acceso/registro_page.dart';
import 'package:app_factura_club_dev/src/pages/categoria/categoria_nueva.dart';
import 'package:app_factura_club_dev/src/pages/categoria/categoria_page.dart';
import 'package:app_factura_club_dev/src/pages/clientes/clientes_page.dart';
import 'package:app_factura_club_dev/src/pages/clientes/nuevo_cliente.dart';
import 'package:app_factura_club_dev/src/pages/documentos/facturas/agregar_producto_factura.dart';
import 'package:app_factura_club_dev/src/pages/documentos/facturas/facturas_page.dart';
import 'package:app_factura_club_dev/src/pages/documentos/facturas/nueva_factura.dart';
import 'package:app_factura_club_dev/src/pages/bodega/bodega_nueva_page.dart';
import 'package:app_factura_club_dev/src/pages/bodega/bodega_page.dart';
import 'package:app_factura_club_dev/src/pages/empresa/empresa_nueva_page.dart';
import 'package:app_factura_club_dev/src/pages/sucursal/sucursal_nueva_page.dart';
import 'package:app_factura_club_dev/src/pages/sucursal/sucursales_page.dart';
import 'package:app_factura_club_dev/src/pages/home_page.dart';
import 'package:app_factura_club_dev/src/pages/producto/nuevo_producto.dart';
import 'package:app_factura_club_dev/src/pages/servicio/nuevo_servicio.dart';
import 'package:app_factura_club_dev/src/pages/producto/productos_page.dart';
import 'package:app_factura_club_dev/src/pages/servicio/servicios_page.dart';
import 'package:app_factura_club_dev/src/pages/usuarios/agregar_usuario_page.dart';
import 'package:app_factura_club_dev/src/pages/usuarios/permisos_page.dart';
import 'package:app_factura_club_dev/src/pages/usuarios/usuario_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('es', ''), // Spanish, no country code
          const Locale('en', 'US'), // English, no country code
        ],
        debugShowCheckedModeBanner: false,
        title: 'factura.club',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'registro': (BuildContext context) => RegistroPage(),
          'home': (BuildContext context) => HomePage(),
          'empresa': (BuildContext context) => EmpresaPage(),
          'nueva-empresa': (BuildContext context) => NuevaEmpresaPage(),
          'sucursales': (BuildContext context) => SucursalesPage(),
          'nueva-sucursal': (BuildContext context) => NuevaSucursalPage(),
          'bodega': (BuildContext context) => BodegaPage(),
          'nueva-bodega': (BuildContext context) => NuevaBodegaPage(),
          'clientes': (BuildContext context) => ClientesPage(),
          'nuevo-cliente': (BuildContext context) => NuevoClientePage(),
          'productos': (BuildContext context) => ProductosPage(),
          'nuevo_producto': (BuildContext context) => NuevoProductoPage(),
          'servicios': (BuildContext context) => ServiciosPage(),
          'nuevo-servicio': (BuildContext context) => NuevoServicioPage(),
          'categoria': (BuildContext context) => CategoriaPage(),
          'nueva-categoria': (BuildContext context) => NuevaCategoriaPage(),
          //
          'usuarios': (BuildContext context) => UsuariosPage(),
          'nuevo-usuario': (BuildContext context) => NuevoUsuarioPage(),
          'facturas': (BuildContext context) => FacturasPage(),
          'nueva-factura': (BuildContext context) => NuevaFacturaPage(),
          'agregar-producto-factura': (BuildContext context) => AgregarProductoFacturaPage(),
          'permisos-usuarios': (BuildContext context) => PermisosUsuarioPage(),
        },
      ),
    );
  }
}
