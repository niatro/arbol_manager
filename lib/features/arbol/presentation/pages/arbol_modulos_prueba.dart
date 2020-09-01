import 'package:flutter/material.dart';
import 'package:flutterapparbol/core/constants/form_entity_test.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/form_local_source_sql.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/local_data_estructuras.dart';
import 'package:flutterapparbol/features/arbol/data/models/form_entity_modelo.dart';
import 'package:geolocator/geolocator.dart';

class ArbolModulosNfcPrueba extends StatefulWidget {
  @override
  _ArbolModulosNfcPruebaState createState() => _ArbolModulosNfcPruebaState();
}

void _getCurrentLocation() async {
  final position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print(position);
}

class _ArbolModulosNfcPruebaState extends State<ArbolModulosNfcPrueba> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modulo NFC test',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Servicios de testing'),
        ),
        body: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(""),
              FlatButton(
                onPressed: () {
                  _getCurrentLocation();
                },
                color: Colors.green,
                child: Text('Conseguir Coordenadas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArbolModuloSQLDosPrueba extends StatefulWidget {
  @override
  _ArbolModuloSQLDosPruebaState createState() =>
      _ArbolModuloSQLDosPruebaState();
}

class _ArbolModuloSQLDosPruebaState extends State<ArbolModuloSQLDosPrueba> {
  FormLocalSourceSqlImpl databaseHelper = FormLocalSourceSqlImpl();
  List<ClienteModelo> clienteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (clienteList == null) {
      clienteList = List<ClienteModelo>();
    }
    return MaterialApp(
      title: 'Modulo BD Test',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Servicios de testing'),
        ),
        body: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(""),
              FlatButton(
                onPressed: () async {
                  print('Creando la BD....');
                  await databaseHelper.initializeDatabase();
                  print('BD creada');
                },
                color: Colors.yellow,
                child: Text('Crear BD'),
              ),
              SizedBox(height: 10.0),
              FlatButton(
                onPressed: () async {
                  print('Checkeando la BD....');
                  List result = await databaseHelper.getTablesMapList(
                      nombreTabla: TABLAS_BD['TABLA_CLIENTE']['NOMBRE_TABLA'],
                      campoOrdenador: TABLAS_BD['TABLA_CLIENTE']
                          ['CLIENTE_NOMBRE']);
                  List resultZonas = await databaseHelper.getTablesMapList(
                      nombreTabla: TABLAS_BD['TABLA_ZONA']['NOMBRE_TABLA'],
                      campoOrdenador: TABLAS_BD['TABLA_ZONA']['CLIENTE_ONA']);
                  print(result.toString() + " " + resultZonas.toString());
                },
                color: Colors.green,
                child: Text('Que hay en la DB'),
              ),
              SizedBox(height: 10.0),
              FlatButton(
                onPressed: () async {
                  await databaseHelper.insertCliente(
                    objetoTabla: tClienteUnoModeloExp,
                    nombreTabla: TABLAS_BD['TABLA_CLIENTE']['NOMBRE_TABLA'],
                  );
                  await databaseHelper.insertCliente(
                    objetoTabla: tZonaModeloExp,
                    nombreTabla: TABLAS_BD['TABLA_ZONA']['NOMBRE_TABLA'],
                  );
                  print('grabado');
                },
                color: Colors.red,
                child: Text('Grabar Clientes'),
              ),
              SizedBox(height: 10.0),
              FlatButton(
                onPressed: () async {
                  int nClientes = await databaseHelper.contarClientes();
                  await databaseHelper.deleteCliente(nClientes);
                  print('Borrando');
                },
                color: Colors.blue,
                child: Text('Borrar elemento'),
              ),
              SizedBox(height: 10.0),
              FlatButton(
                onPressed: () async {
                  int nClientes = await databaseHelper.contarClientes();
                  await databaseHelper.cerrarBasedatos();
                  print('Cerrando');
                },
                color: Colors.orange,
                child: Text('Cerrar BD'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
