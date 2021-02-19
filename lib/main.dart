import 'package:app_factura_club_dev/src/pages/Empresa/empresa_page.dart';
import 'package:app_factura_club_dev/src/pages/acceso/login_page.dart';
import 'package:app_factura_club_dev/src/pages/acceso/registro_page.dart';
import 'package:app_factura_club_dev/src/pages/clientes/clientes_page.dart';
import 'package:app_factura_club_dev/src/pages/clientes/nuevo_cliente.dart';
import 'package:app_factura_club_dev/src/pages/documentos/facturas/agregar_producto_factura.dart';
import 'package:app_factura_club_dev/src/pages/documentos/facturas/facturas_page.dart';
import 'package:app_factura_club_dev/src/pages/documentos/facturas/nueva_factura.dart';
import 'package:app_factura_club_dev/src/pages/home_page.dart';
import 'package:app_factura_club_dev/src/pages/productos_servicios/nuevo_producto.dart';
import 'package:app_factura_club_dev/src/pages/productos_servicios/tabs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        'productos-servicios': (BuildContext context) => TabsPage(),
        'nuevo_producto': (BuildContext context) => NuevoProductoPage(),
        'clientes': (BuildContext context) => ClientesPage(),
        'nuevo-cliente': (BuildContext context) => NuevoClientePage(),
        'facturas': (BuildContext context) => FacturasPage(),
        'nueva-factura': (BuildContext context) => NuevaFacturaPage(),
        'agregar-producto-factura': (BuildContext context) => AgregarProductoFacturaPage(),
        'empresa': (BuildContext context) => EmpresaPage(),
      },
    );
  }
}
