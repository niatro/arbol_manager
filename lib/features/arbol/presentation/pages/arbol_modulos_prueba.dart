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
                    ListaZonaModelo zonas =
                        await remoteDataSource.llenarObjetoListaDesdeHttp(
                            tabla: referencia.zona.nombreTabla);

                    zonas.listaZona.forEach((element) async {
                      await databaseHelper.insertFila(
                        objetoFila: element,
                        nombreTabla: referencia.zona.nombreTabla,
                      );
                    });
                    List clienteEnBD = await databaseHelper.getFilasMapList(
                      nombreTabla: referencia.zona.nombreTabla,
                      campoOrdenador: referencia.zona.zonaOrigenId,
                    );
                    print('Se leyo BD tabla zonas');
                    print(
                        'total de registros ${clienteEnBD.length.toString()}');
                    print(clienteEnBD.toString());
                  },
                  color: Colors.brown,
                  child: Text('Zonas'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    ListaCalleModelo calles =
                        await remoteDataSource.llenarObjetoListaDesdeHttp(
                            tabla: referencia.calle.nombreTabla);

                    calles.listaCalle.forEach((element) async {
                      await databaseHelper.insertFila(
                        objetoFila: element,
                        nombreTabla: referencia.calle.nombreTabla,
                      );
                    });
                    List tablaEnBD = await databaseHelper.getFilasMapList(
                      nombreTabla: referencia.calle.nombreTabla,
                      campoOrdenador: referencia.calle.calleZonaId,
                    );
                    print('Se leyo BD tabla calle');
                    print('total de registros ${tablaEnBD.length.toString()}');
                    print(tablaEnBD.toString());
                  },
                  color: Colors.brown,
                  child: Text('Calles'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    ListaCalleEsquinaModelo callesEsquina =
                        await remoteDataSource.llenarObjetoListaDesdeHttp(
                            tabla: referencia.calleEsquina.nombreTabla);

                    callesEsquina.listaCalleEsquina.forEach((element) async {
                      await databaseHelper.insertFila(
                        objetoFila: element,
                        nombreTabla: referencia.calleEsquina.nombreTabla,
                      );
                    });
                    List tablaEnBD = await databaseHelper.getFilasMapList(
                      nombreTabla: referencia.calleEsquina.nombreTabla,
                      campoOrdenador:
                          referencia.calleEsquina.calleEsquinaZonaId,
                    );
                    print('Se leyo BD tabla calle');
                    print('total de registros ${tablaEnBD.length.toString()}');
                    print(tablaEnBD.toString());
                  },
                  color: Colors.brown,
                  child: Text('Esquina'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    ListaEstadoGeneralModelo estadoGeneral =
                        await remoteDataSource.llenarObjetoListaDesdeHttp(
                            tabla: referencia.estadoGeneral.nombreTabla);

                    estadoGeneral.listaEstadoGeneral.forEach((element) async {
                      await databaseHelper.insertFila(
                        objetoFila: element,
                        nombreTabla: referencia.estadoGeneral.nombreTabla,
                      );
                    });
                    List tablaEnBD = await databaseHelper.getFilasMapList(
                      nombreTabla: referencia.estadoGeneral.nombreTabla,
                      campoOrdenador:
                          referencia.estadoGeneral.estadoGeneralOrigenId,
                    );
                    print('total de registros ${tablaEnBD.length.toString()}');
                    print(tablaEnBD.toString());
                  },
                  color: Colors.brown,
                  child: Text('Estado General'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    ListaEstadoSanitarioModelo estadoSanitario =
                        await remoteDataSource.llenarObjetoListaDesdeHttp(
                            tabla: referencia.estadoSanitario.nombreTabla);

                    estadoSanitario.listaEstadoSanitario
                        .forEach((element) async {
                      await databaseHelper.insertFila(
                        objetoFila: element,
                        nombreTabla: referencia.estadoSanitario.nombreTabla,
                      );
                    });
                    List tablaEnBD = await databaseHelper.getFilasMapList(
                      nombreTabla: referencia.estadoSanitario.nombreTabla,
                      campoOrdenador:
                          referencia.estadoSanitario.estadoSanitarioOrigenId,
                    );
                    print('total de registros ${tablaEnBD.length.toString()}');
                    print(tablaEnBD.toString());
                  },
                  color: Colors.brown,
                  child: Text('Sanitario'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    ListaInclinacionTroncoModelo inclinacionTronco =
                        await remoteDataSource.llenarObjetoListaDesdeHttp(
                            tabla: referencia.inclinacionTronco.nombreTabla);

                    inclinacionTronco.listaInclinacionTronco
                        .forEach((element) async {
                      await databaseHelper.insertFila(
                        objetoFila: element,
                        nombreTabla: referencia.inclinacionTronco.nombreTabla,
                      );
                    });
                    List tablaEnBD = await databaseHelper.getFilasMapList(
                      nombreTabla: referencia.inclinacionTronco.nombreTabla,
                      campoOrdenador:
                          referencia.inclinacionTronco.inclinacionTroncoId,
                    );
                    print('total de registros ${tablaEnBD.length.toString()}');
                    print(tablaEnBD.toString());
                  },
                  color: Colors.brown,
                  child: Text('Inclinacion'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    ListaOrientacionInclinacionModelo orientacionInclinacion =
                        await remoteDataSource.llenarObjetoListaDesdeHttp(
                            tabla:
                                referencia.orientacionInclinacion.nombreTabla);

                    orientacionInclinacion.listaOrientacionInclinacion
                        .forEach((element) async {
                      await databaseHelper.insertFila(
                        objetoFila: element,
                        nombreTabla:
                            referencia.orientacionInclinacion.nombreTabla,
                      );
                    });
                    List tablaEnBD = await databaseHelper.getFilasMapList(
                      nombreTabla:
                          referencia.orientacionInclinacion.nombreTabla,
                      campoOrdenador: referencia.orientacionInclinacion
                          .orientacionInclinacionOrigenId,
                    );
                    print('total de registros ${tablaEnBD.length.toString()}');
                    print(tablaEnBD.toString());
                  },
                  color: Colors.brown,
                  child: Text('Orientacion'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    ListaAccionObsModelo accionObs =
                        await remoteDataSource.llenarObjetoListaDesdeHttp(
                            tabla: referencia.accionObs.nombreTabla);

                    accionObs.listaAccionObs.forEach((element) async {
                      await databaseHelper.insertFila(
                        objetoFila: element,
                        nombreTabla: referencia.accionObs.nombreTabla,
                      );
                    });
                    List tablaEnBD = await databaseHelper.getFilasMapList(
                      nombreTabla: referencia.accionObs.nombreTabla,
                      campoOrdenador: referencia.accionObs.accionObsOrden,
                    );
                    print('total de registros ${tablaEnBD.length.toString()}');
                    print(tablaEnBD.toString());
                  },
                  color: Colors.brown,
                  child: Text('Accion'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    ListaUsuarioModelo usuario =
                        await remoteDataSource.llenarObjetoListaDesdeHttp(
                            tabla: referencia.usuario.nombreTabla);

                    usuario.listaUsuario.forEach((element) async {
                      await databaseHelper.insertFila(
                        objetoFila: element,
                        nombreTabla: referencia.usuario.nombreTabla,
                      );
                    });
                    List tablaEnBD = await databaseHelper.getFilasMapList(
                      nombreTabla: referencia.usuario.nombreTabla,
                      campoOrdenador: referencia.usuario.usuarioOrigenId,
                    );
                    print('total de registros ${tablaEnBD.length.toString()}');
                    print(tablaEnBD.toString());
                  },
                  color: Colors.brown,
                  child: Text('Usuario'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    ListaAgentePatogenoModelo agentePatogeno =
                        await remoteDataSource.llenarObjetoListaDesdeHttp(
                            tabla: referencia.agentesPatogenos.nombreTabla);

                    agentePatogeno.listaAgentePatogeno.forEach((element) async {
                      await databaseHelper.insertFila(
                        objetoFila: element,
                        nombreTabla: referencia.agentesPatogenos.nombreTabla,
                      );
                    });
                    List tablaEnBD = await databaseHelper.getFilasMapList(
                      nombreTabla: referencia.agentesPatogenos.nombreTabla,
                      campoOrdenador:
                          referencia.agentesPatogenos.agentePatogenoOrigenId,
                    );
                    print('total de registros ${tablaEnBD.length.toString()}');
                    print(tablaEnBD.toString());
                  },
                  color: Colors.brown,
                  child: Text('Patogeno'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    ListaLugarPlagaModelo lugarPlaga =
                        await remoteDataSource.llenarObjetoListaDesdeHttp(
                            tabla: referencia.lugarPlaga.nombreTabla);

                    lugarPlaga.listaLugarPlaga.forEach((element) async {
                      await databaseHelper.insertFila(
                        objetoFila: element,
                        nombreTabla: referencia.lugarPlaga.nombreTabla,
                      );
                    });
                    List tablaEnBD = await databaseHelper.getFilasMapList(
                      nombreTabla: referencia.lugarPlaga.nombreTabla,
                      campoOrdenador: referencia.lugarPlaga.lugarPlagaOrigenId,
                    );
                    print('total de registros ${tablaEnBD.length.toString()}');
                    print(tablaEnBD.toString());
                  },
                  color: Colors.brown,
                  child: Text('Lugar'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
