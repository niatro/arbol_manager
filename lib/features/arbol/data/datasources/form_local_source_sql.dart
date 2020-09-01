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
  Future<Database> initializeDatabase();
  Future<int> contarClientes();
  Future<List<Map<String, dynamic>>> getTablesMapList({String nombreTabla});
  Future<int> deleteCliente(int clienteId);
  Future<int> updateCliente(ClienteModelo cliente);
  Future<int> insertCliente({ObjetoTabla objetoTabla, String nombreTabla});
  Future<void> cerrarBasedatos();
}

//OJO: Implementacion version 3 abajo 👀

class FormLocalSourceSqlImpl extends FormLocalSourceSql {
  static FormLocalSourceSqlImpl _databaseHelper; // Singleton por eso es static
  static Database _database;

  FormLocalSourceSqlImpl._createInstance(); // Named constructor para crear una instancia de DatabaseHelper
  factory FormLocalSourceSqlImpl() {
    if (_databaseHelper == null) {
      _databaseHelper = FormLocalSourceSqlImpl._createInstance();
    }
    return _databaseHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      return await initializeDatabase();
    } else {
      return _database;
    }
  }

  @override
  Future<Database> initializeDatabase() async {
    String directory = await getDatabasesPath();
    String path = directory + 'form.db';
    var formDatabase = openDatabase(path, version: 1, onCreate: _createDB);
    return formDatabase;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute('''
    CREATE TABLE ${TABLAS_BD['TABLA_CLIENTE']['NOMBRE_TABLA']} (
    ${TABLAS_BD['TABLA_CLIENTE']['CLIENTE_ID']} INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT, 
    ${TABLAS_BD['TABLA_CLIENTE']['CLIENTE_NOMBRE']} TEXT
    )''');
    await db.execute('''
    CREATE TABLE $TABLA_ZONA (
    $ZONA_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    $ZONA_NOMBRE TEXT,
    $CLIENTE_ID INTEGER,
    FOREIGN KEY ($CLIENTE_ID) REFERENCES $TABLA_CLIENTE($CLIENTE_ID)
    )''');
  }

  //Fetch Operation: Get all forms from database
  @override
  Future<List<Map<String, dynamic>>> getTablesMapList(
      {@required String nombreTabla, @required String campoOrdenador}) async {
    Database db = await this.database;
//    var result = await db
//        .rawQuery('SELECT * FROM $TABLA_CLIENTE order by $CLIENTE_NOMBRE ASC');
    var result = await db.query(nombreTabla, orderBy: '$campoOrdenador ');
    return result;
  }

// Insert Operation:
  @override
  Future<int> insertCliente(
      {ObjetoTabla objetoTabla, String nombreTabla}) async {
    Database db = await this.database;
    var result = await db.insert(nombreTabla, objetoTabla.toMap());
    return result;
  }

// Update Operation:
  @override
  Future<int> updateCliente(ClienteModelo cliente) async {
    Database db = await this.database;
    var result = await db.update(TABLA_CLIENTE, cliente.toMap(),
        where: '$CLIENTE_ID = ?', whereArgs: [cliente.clienteId]);
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

// Get number
  @override
  Future<int> contarClientes() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $TABLA_CLIENTE');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  @override
  Future<void> cerrarBasedatos() async {
    Database db = await this.database;
    db.close();
  }
}
