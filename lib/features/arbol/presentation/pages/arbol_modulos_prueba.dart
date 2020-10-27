import 'package:flutter/material.dart';
import 'package:flutterapparbol/core/constants/form_entity_test.dart';
import 'package:flutterapparbol/core/constants/lista_de_arboles_test.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/arboles_remote_data_source.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/form_local_source_sql.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/local_data_estructuras.dart';
import 'package:flutterapparbol/features/arbol/data/models/form_entity_modelo.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ArbolModulosCoordPrueba extends StatefulWidget {
  @override
  _ArbolModulosCoordPruebaState createState() =>
      _ArbolModulosCoordPruebaState();
}

void _getCurrentLocation() async {
  final position =
      await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  print(position.latitude);
}

class _ArbolModulosCoordPruebaState extends State<ArbolModulosCoordPrueba> {
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
                onPressed: () async {
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
  FormLocalSourceSqlImpl sqlDataSource = FormLocalSourceSqlImpl();

  ArbolesRemoteDataSourceImpl remoteDataSource;
  int count_arbol = 0;
  int count_enf = 0;
  List<String> imagenesArbol = [];
  List<String> imagenesEnfermedad = [];
  final EsquemaDataDeSQL referencia = EsquemaDataDeSQL();
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
  }

  Future<List<String>> tomarImagenArbol(ImagePicker picker) async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    imagenesArbol.add(pickedImage.path);
    imagenesArbol.forEach((foto) => print(foto));
    return imagenesArbol;
  }

  Future<List<String>> tomarImagenEnfermedad(ImagePicker picker) async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    imagenesEnfermedad.add(pickedImage.path);
    imagenesEnfermedad.forEach((foto) => print(foto));
    return imagenesEnfermedad;
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
                    await sqlDataSource.inicializarDatabase();
                    print('BD creada');
                  },
                  color: Colors.yellow,
                  child: Text('Crear BD'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    print('Checkeando la BD....');
                    List result = await sqlDataSource.getFilasMapList(
                      nombreTabla: referencia.cliente.nombreTabla,
                      campoOrdenador: referencia.cliente.clienteNombre,
                    );
                    List resultZonas = await sqlDataSource.getFilasMapList(
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
                    await sqlDataSource.insertFila(
                      objetoFila: tClienteUnoModeloExp,
                      nombreTabla: referencia.cliente.nombreTabla,
                    );
                    await sqlDataSource.insertFila(
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
                    int nClientes = await sqlDataSource.contarFilasTabla(
                      nombreTabla: referencia.cliente.nombreTabla,
                    );
                    await sqlDataSource.deleteCliente(nClientes);
                    print('Borrando');
                  },
                  color: Colors.blue,
                  child: Text('Borrar'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    await sqlDataSource.borrarBasedatos();
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
                      await sqlDataSource.insertFila(
                        objetoFila: element,
                        nombreTabla: referencia.cliente.nombreTabla,
                      );
                    });
                    List clienteEnBD = await sqlDataSource.getFilasMapList(
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
                      await sqlDataSource.insertFila(
                        objetoFila: element,
                        nombreTabla: referencia.plagas.nombreTabla,
                      );
                    });
                    List tablaEnBD = await sqlDataSource.getFilasMapList(
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
                    await sqlDataSource.getDatosFormSql(idUsuario: 'dbaiiqqe3');
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
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    List<String> foto = await tomarImagenEnfermedad(picker);
                    setState(() {
                      count_enf = imagenesEnfermedad.length;
                      arbolUno.fotosEnfermedad.add(foto.last);
                    });
                  },
                  color: Colors.purple,
                  child: Text('Sacar Foto Enfermedad ($count_enf)'),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    List<String> foto = await tomarImagenArbol(picker);
                    setState(() {
                      count_arbol = imagenesArbol.length;
                      arbolUno.fotosArbol.add(foto.last);
                    });
                  },
                  color: Colors.purple,
                  child: Text('Sacar Foto Arbol ($count_arbol)'),
                ),
                FlatButton(
                  onPressed: () async {
                    await remoteDataSource.grabarArboleRemoteData(
                        arbol: arbolUno);
                  },
                  color: Colors.purple,
                  child: Text('Grabar Arboles'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
