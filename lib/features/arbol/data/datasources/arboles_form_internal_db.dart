import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/features/arbol/data/models/form_entity_modelo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:meta/meta.dart';

abstract class ArbolesFormInternalDB {
  Future<FormEntityModelo> getFormInternalDB();
  Future<SqfliteGrabarSuccess> saveFormInternalDB();
}

class ArbolesFormInternalDBImpl extends ArbolesFormInternalDB {
  final Database dataBaseForm;
  ArbolesFormInternalDBImpl({@required this.dataBaseForm});
  @override
  Future<FormEntityModelo> getFormInternalDB() {
    // TODO: implement getFormInternalDB
    throw UnimplementedError();
  }

  @override
  Future<SqfliteGrabarSuccess> saveFormInternalDB() async {
    _crearFormDB();
    return SqfliteGrabarSuccess();
    // TODO: implement saveFormInternalDB
  }

  void _crearFormDB() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'form_database.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }
}
