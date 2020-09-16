import 'package:flutter/material.dart';
import 'package:flutterapparbol/core/constants/form_entity_test.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/arboles_remote_data_source.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/form_local_source_sql.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/local_data_estructuras.dart';
import 'package:flutterapparbol/features/arbol/data/models/form_entity_modelo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

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
  http.Client client;
  FormLocalSourceSqlImpl databaseHelper = FormLocalSourceSqlImpl();

  ArbolesRemoteDataSourceImpl remoteDataSource;
  int count = 0;
  final EsquemaDataDeSQL referencia = EsquemaDataDeSQL();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    http.Client client = http.Client();
    ArbolesRemoteDataSourceImpl remoteDataSource =
        ArbolesRemoteDataSourceImpl(client: client);

    return MaterialApp(
      title: 'Modulo BD Test',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Servicios de testing'),
        ),
        body: Align(
          child: Container(
            child: Wrap(
              direction: Axis.vertical,
              children: [
                Text(""),
                FlatButton(
                  onPressed: () async {
                    print('Creando la BD....');
                    await databaseHelper.inicializarDatabase();
                    print('BD creada');
                  },
                  color: Colors.yellow,
                  child: Text('Crear BD'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    print('Checkeando la BD....');
                    List result = await databaseHelper.getFilasMapList(
                      nombreTabla: referencia.cliente.nombreTabla,
                      campoOrdenador: referencia.cliente.clienteNombre,
                    );
                    List resultZonas = await databaseHelper.getFilasMapList(
                      nombreTabla: referencia.zona.nombreTabla,
                      campoOrdenador: referencia.zona.zonaNombre,
                    );
                    print(result.toString());
                    print(resultZonas.toString());
                  },
                  color: Colors.green,
                  child: Text('Revisar BD'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    await databaseHelper.insertFila(
                      objetoFila: tClienteUnoModeloExp,
                      nombreTabla: referencia.cliente.nombreTabla,
                    );
                    await databaseHelper.insertFila(
                      objetoFila: tZonaModeloExp,
                      nombreTabla: referencia.zona.nombreTabla,
                    );
                    print('grabado');
                  },
                  color: Colors.red,
                  child: Text('Grabar'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    int nClientes = await databaseHelper.contarFilasTabla(
                      nombreTabla: referencia.cliente.nombreTabla,
                    );
                    await databaseHelper.deleteCliente(nClientes);
                    print('Borrando');
                  },
                  color: Colors.blue,
                  child: Text('Borrar'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    await databaseHelper.borrarBasedatos();
                    print('Cerrando');
                  },
                  color: Colors.orange,
                  child: Text('Borrar BD'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    ListaClienteModelo clientes =
                        await remoteDataSource.llenarObjetoListaDesdeHttp(
                            tabla: referencia.cliente.nombreTabla);

                    clientes.listaClientes.forEach((element) async {
                      await databaseHelper.insertFila(
                        objetoFila: element,
                        nombreTabla: referencia.cliente.nombreTabla,
                      );
                    });
                    List clienteEnBD = await databaseHelper.getFilasMapList(
                      nombreTabla: referencia.cliente.nombreTabla,
                      campoOrdenador: referencia.cliente.clienteNombre,
                    );
                    print('Leido de BD');
                    print(clienteEnBD.length.toString());
                    print(clienteEnBD.toString());
                  },
                  color: Colors.brown,
                  child: Text('Clientes'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    ListaPlagaModelo plaga =
                        await remoteDataSource.llenarObjetoListaDesdeHttp(
                            tabla: referencia.plagas.nombreTabla);

                    plaga.listaPlaga.forEach((element) async {
                      await databaseHelper.insertFila(
                        objetoFila: element,
                        nombreTabla: referencia.plagas.nombreTabla,
                      );
                    });
                    List tablaEnBD = await databaseHelper.getFilasMapList(
                      nombreTabla: referencia.plagas.nombreTabla,
                      campoOrdenador: referencia.plagas.plagaOrigenId,
                    );
                    print('total de registros ${tablaEnBD.length.toString()}');
                    print(tablaEnBD.toString());
                  },
                  color: Colors.brown,
                  child: Text('Plagas'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    await remoteDataSource.getDatosForm(idUsuario: 'dbaiiqqe3');
                  },
                  color: Colors.purple,
                  child: Text('Leer BD como Objeto'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    await remoteDataSource.actualizarBaseDatosFormularios();
                  },
                  color: Colors.purple,
                  child: Text('Crear toda BD'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
