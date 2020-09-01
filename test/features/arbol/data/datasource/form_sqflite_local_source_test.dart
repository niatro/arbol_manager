import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapparbol/core/constants/form_entity_test.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/form_local_source_sql.dart';
import 'package:flutterapparbol/features/arbol/data/models/form_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/form_entity.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:meta/meta.dart';

class MockSqflite extends Mock implements Database {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  MockSqflite mockSqflite;

  setUp(() {});

  group('Debe testear guardar data en la base de datos', () {
    final List<ClienteEntity> listaClientes = [tClienteUno, tClienteDos];
    List<Map> clientesObtenidos = tClientesListados;
  });

  group('Debe testear LEER data DE la base de datos', () {});
}
