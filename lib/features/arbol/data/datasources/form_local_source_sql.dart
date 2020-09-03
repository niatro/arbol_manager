import 'dart:io';

import 'package:flutterapparbol/core/constants/form_entity_test.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/features/arbol/data/models/form_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/form_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:meta/meta.dart';

import 'local_data_estructuras.dart';

abstract class FormLocalSourceSql {
  Future<Database> inicializarDatabase();
  Future<int> contarFilasTabla({String nombreTabla});
  Future<List<Map<String, dynamic>>> getFilasMapList({String nombreTabla});
  Future<List<ObjetoFila>> getFormEntityDeTabla({String nombreTabla});
  Future<int> deleteCliente(int clienteId);
  Future<int> updateCliente(String nombreTabla, ClienteModelo cliente);
  Future<int> insertFila({ObjetoFila objetoFila, String nombreTabla});
  Future<void> cerrarBasedatos();
}

//OJO: Implementacion version 3 abajo 👀

class FormLocalSourceSqlImpl extends FormLocalSourceSql {
  static FormLocalSourceSqlImpl _databaseHelper; // Singleton por eso es static
  static Database _database;
  final EsquemaDataDeSQL referencia = EsquemaDataDeSQL();

  FormLocalSourceSqlImpl._createInstance(); // Named constructor para crear una instancia de DatabaseHelper
  factory FormLocalSourceSqlImpl() {
    if (_databaseHelper == null) {
      _databaseHelper = FormLocalSourceSqlImpl._createInstance();
    }
    return _databaseHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      return await inicializarDatabase();
    } else {
      return _database;
    }
  }

  @override
  Future<Database> inicializarDatabase() async {
    String directory = await getDatabasesPath();
    String path = directory + 'form.db';
    var formDatabase = openDatabase(path, version: 1, onCreate: _createDB);
    return formDatabase;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute('''
    CREATE TABLE ${referencia.cliente.nombreTabla} (
    ${referencia.cliente.clienteId} INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT, 
    ${referencia.cliente.clienteNombre} TEXT
    )''');
    await db.execute('''
    CREATE TABLE ${referencia.zona.nombreTabla} (
    ${referencia.zona.zonaId} INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    ${referencia.zona.zonaNombre} TEXT,
    ${referencia.zona.foreignKey} INTEGER,
    FOREIGN KEY (${referencia.zona.foreignKey}) REFERENCES ${referencia.cliente.nombreTabla}(${referencia.cliente.clienteId})
    )''');
    await db.execute('''
    CREATE TABLE ${referencia.calle.nombreTabla} (
    ${referencia.calle.calleId} INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    ${referencia.calle.calleZonaId} TEXT,
    ${referencia.calle.calleNombre} TEXT,
    ${referencia.calle.foreignKey} INTEGER,
    FOREIGN KEY (${referencia.calle.foreignKey}) REFERENCES ${referencia.cliente.nombreTabla}(${referencia.cliente.clienteId})
    )''');
    await db.execute('''
    CREATE TABLE ${referencia.calleEsquina.nombreTabla} (
    ${referencia.calleEsquina.calleEsquinaId} INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    ${referencia.calleEsquina.calleEsquinaZonaId} TEXT,
    ${referencia.calleEsquina.calleEsquinaNombre} TEXT,
    ${referencia.calleEsquina.foreignKey} INTEGER,
    FOREIGN KEY (${referencia.calleEsquina.foreignKey}) REFERENCES ${referencia.cliente.nombreTabla}(${referencia.cliente.clienteId})
    )''');
    await db.execute('''
    CREATE TABLE ${referencia.especie.nombreTabla} (
    ${referencia.especie.especieId} INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    ${referencia.especie.especieNombreComun} TEXT,
    ${referencia.especie.especieNombreCientifico} TEXT,
    ${referencia.especie.especieOrden} INTEGER,
    ${referencia.especie.especieIcono} TEXT,
    ${referencia.especie.especieHojaGenerica} TEXT,
    ${referencia.especie.especieFotoGenerica} TEXT,
    ${referencia.especie.especieDescripcion} TEXT
    )''');
    await db.execute('''
    CREATE TABLE ${referencia.estadoGeneral.nombreTabla} (
    ${referencia.estadoGeneral.estadoGeneralId} INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    ${referencia.estadoGeneral.estadoGeneralIdDesc} TEXT
    )''');
    await db.execute('''
    CREATE TABLE ${referencia.estadoSanitario.nombreTabla} (
    ${referencia.estadoSanitario.estadoSanitarioId} INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    ${referencia.estadoSanitario.estadoSanitarioDesc} TEXT
    )''');
    await db.execute('''
    CREATE TABLE ${referencia.inclinacionTronco.nombreTabla} (
    ${referencia.inclinacionTronco.inclinacionTroncoId} INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    ${referencia.inclinacionTronco.inclinacionDesc} TEXT
    )''');
    await db.execute('''
    CREATE TABLE ${referencia.orientacionInclinacion.nombreTabla} (
    ${referencia.orientacionInclinacion.orientacionInclinacionId} INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    ${referencia.orientacionInclinacion.orientacionInclinacionDesc} TEXT
    )''');
    await db.execute('''
    CREATE TABLE ${referencia.accionObs.nombreTabla} (
    ${referencia.accionObs.accionObsId} INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    ${referencia.accionObs.accionObsDesc} TEXT,
    ${referencia.accionObs.accionObsOrden} INTEGER
    )''');
    await db.execute('''
    CREATE TABLE ${referencia.usuario.nombreTabla} (
        ${referencia.usuario.usuarioId} INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        ${referencia.usuario.usuarioGUI} TEXT,
        ${referencia.usuario.usuarioRol} TEXT,
        ${referencia.usuario.usuarioNombre} TEXT,
        ${referencia.usuario.usuarioApellido} TEXT,
        ${referencia.usuario.usuarioEmail} TEXT,
        ${referencia.usuario.usuarioCreacion} TEXT,
        ${referencia.usuario.usuarioActividad} TEXT,
        ${referencia.usuario.foreignKey} INTEGER,
        FOREIGN KEY (${referencia.usuario.foreignKey}) REFERENCES ${referencia.cliente.nombreTabla}(${referencia.cliente.clienteId})
    )''');
    //TODO: falta tabla para agente patogeno 😱
    //TODO: falta tabla  para lugar plaga 😱
    //TODO: falta tabla  para  plaga 😱
  }

  //Fetch Operation: Get all forms from database 👌
  @override
  Future<List<Map<String, dynamic>>> getFilasMapList(
      {@required String nombreTabla, @required String campoOrdenador}) async {
    Database db = await this.database;
//    var result = await db
//        .rawQuery('SELECT * FROM $TABLA_CLIENTE order by $CLIENTE_NOMBRE ASC');
    var result = await db.query(nombreTabla, orderBy: '$campoOrdenador ');
    return result;
  }

// Insert Operation:
  @override
  Future<int> insertFila({ObjetoFila objetoFila, String nombreTabla}) async {
    Database db = await this.database;
    var result = await db.insert(nombreTabla, objetoFila.toMap());
    return result;
  }

// Update Operation:
  //TODO: Esta operación requiere ser implementada en futuro, para cualquier tabla esta a medio implementar
  @override
  Future<int> updateCliente(String nombreTabla, ObjetoFila objetoTabla) async {
    Database db = await this.database;
    var result = await db.update(nombreTabla, objetoTabla.toMap(),
        where: '$CLIENTE_ID = ?', whereArgs: [objetoTabla.idFila]);
    return result;
  }

// Delete Operation:
  @override
  Future<int> deleteCliente(int clienteId) async {
    Database db = await this.database;
    var result = await db
        .rawDelete('DELETE FROM $TABLA_CLIENTE WHERE $CLIENTE_ID = $clienteId');
    return result;
  }

// Get number 👌
  @override
  Future<int> contarFilasTabla({@required String nombreTabla}) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $nombreTabla');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  @override
  Future<void> cerrarBasedatos() async {
    Database db = await this.database;
    db.close();
  }

  @override
  Future<List<ObjetoFila>> getFormEntityDeTabla({String nombreTabla}) {
    // TODO: implement getFormEntityDeTabla
    throw UnimplementedError();
  }
}
