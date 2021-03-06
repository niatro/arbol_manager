import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapparbol/core/constants/lista_de_arboles_test.dart';
import 'package:flutterapparbol/core/constants/server_prueba.dart';
import 'package:flutterapparbol/core/error/exceptions.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/arboles_remote_data_source.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/form_local_source_sql.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/local_data_estructuras.dart';
import 'package:flutterapparbol/features/arbol/data/models/arboles_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/data/models/user_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockEsquema extends Mock implements EsquemaDataDeSQL {}

class MockDataBaseHelper extends Mock implements FormLocalSourceSqlImpl {}

class MockFormLocalSourceSqlImpl extends Mock
    implements FormLocalSourceSqlImpl {}

void main() {
  ArbolesRemoteDataSourceImpl remoteDataSource;
  MockHttpClient mockHttpClient;
  MockEsquema esquemaDatos;
  MockDataBaseHelper dataBaseHelper;

  setUp(() {
    mockHttpClient = MockHttpClient();
    esquemaDatos = MockEsquema();
    dataBaseHelper = MockDataBaseHelper();
    remoteDataSource = ArbolesRemoteDataSourceImpl(
        client: mockHttpClient, referencia: esquemaDatos);
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  final EsquemaDataDeSQL referencia = EsquemaDataDeSQL();
  final String _url = urlPruebas;

  void setUpMockHttpSuccess200(String file) {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response(fixture(file), 200));
  }

  void setUpMockHttpJustSuccess200() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response("", 200));
  }

  void setUpMockHttpFailure404() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('algo salio mal', 404));
  }

  group('getArbolesCercanos', () {
    final LatLng coordenadasTest =
        LatLng(-33.40022111646666, -70.59898554630922);

    final List<Map> jsonMaped =
        List<Map<String, dynamic>>.from(json.decode(fixture('arboles.json')));
    final List<Map> jsonMapedServer = List<Map<String, dynamic>>.from(
        json.decode(fixture('arboles_server.json')));
    final tArbolesTestModelo =
        ArbolesEntityModelo.fromJson(parsedListMapFromJson: jsonMaped);
    final tArbolesTestModeloServer = ArbolesEntityModelo.fromJsonImportServer(
        parsedListMapFromJson: jsonMapedServer);
    final int distancia = 30;
    test('''DEBERIA hacer un request al URL con las coordenadas y
    recibir arboles cercanos  en un radio por definir''', () async {
      // arrange
      setUpMockHttpSuccess200('arboles_server.json');

      // act
      remoteDataSource.getArbolesCercanosRemoteData(
          coordenadas: coordenadasTest, distancia: distancia);

      // assert
      verify(mockHttpClient.post(
        _url + "/bd/getArbolPorCoordenadas.php",
        body: {
          "latitud": coordenadasTest.latitude.toString(),
          "longitud": coordenadasTest.longitude.toString(),
          "distancia": distancia.toString(),
        },
      ));
    });
    test('DEBERIA retornar un ArbolEntity CUANDO recibe um JSON plano',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(fixture('arboles.json'), 200));
      // act
      final List<Map> jsonMaped =
          List<Map<String, dynamic>>.from(json.decode(fixture('arboles.json')));

      final ArbolesEntityModelo arbolesEntityModelo =
          ArbolesEntityModelo.fromJson(parsedListMapFromJson: jsonMaped);
      expect(arbolesEntityModelo, tArbolesTestModelo);
    });
    test(
        '''DEBERIA retornar ArbolEntityModelo cuando el codigo de respuesta es 200''',
        () async {
      // arrange
      setUpMockHttpSuccess200('arboles_server.json');
      // act
      final ArbolesEntityModelo result =
          await remoteDataSource.getArbolesCercanosRemoteData(
              coordenadas: coordenadasTest, distancia: distancia);
      // assert
      print(tArbolesTestModeloServer.listaArbolEntity[0].esquinaCalleArbol);
      expect(result, equals(tArbolesTestModeloServer));
    });
    test('DEBERIA retornar un error si el codigo de respuesta es 404 u otro',
        () async {
      // arrange
      setUpMockHttpFailure404();
      // act
      final call = remoteDataSource.getArbolesCercanosRemoteData;
      // assert
      expect(() => call(coordenadas: coordenadasTest, distancia: distancia),
          throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getArbolPorIdNFC', () {
    final String idNFC = "832NS8Hvw23";
    final List<Map> jsonMaped =
        List<Map<String, dynamic>>.from(json.decode(fixture('arbol.json')));
    final tArbolesTestModelo =
        ArbolesEntityModelo.fromJson(parsedListMapFromJson: jsonMaped);
    test(
        '''DEBERIA retornar un ArbolEntityModel CUANDO el code del request es 200 l''',
        () async {
      // arrange
      setUpMockHttpSuccess200('arbol.json');
      // act
      remoteDataSource.getArbolPorIdNFCRemoteData(idNFC: idNFC);
      // assert
      verify(mockHttpClient.post(
        _url + "/bd/getArbolPorIdNFC.php",
        body: {
          "idNFC": idNFC,
        },
      ));
    });
    test(
        'DEBERIA retornar ArbolTriviaModelo CUANDO el codigo de respuesta es 200',
        () async {
      // arrange
      setUpMockHttpSuccess200('arbol.json');
      // act
      final ArbolesEntityModelo result =
          await remoteDataSource.getArbolPorIdNFCRemoteData(idNFC: idNFC);
      // assert
      expect(result, equals(tArbolesTestModelo));
    });
    test('DEBERIA retornar un error si el codigo de respuesta es 404 u otro',
        () async {
      // arrange
      setUpMockHttpFailure404();
      // act
      final call = remoteDataSource.getArbolPorIdNFCRemoteData;
      // assert
      expect(() => call(idNFC: idNFC), throwsA(TypeMatcher<ServerException>()));
    });
  });
  group('grabarArbolRemoteData', () {
    final ArbolesEntityModelo tArbolesEntityModel =
        ArbolesEntityModelo(listaArbolesEntity: [arbolUno, arbolDos]);
    final ArbolEntity arbolSeleccionado =
        tArbolesEntityModel.listaArbolEntity[0];
    test('''Deberia retornar un true CUANDO el response.statusCode == 200''',
        () async {
      // arrange
      setUpMockHttpJustSuccess200();
      // act
      final call = remoteDataSource.grabarArboleRemoteData;
      // assert
//       expect(()  =>  call(arbol: arbolSeleccionado), Future<true>);
    });
  });

  group('loginUser', () {
    UserEntityModel tUserSinInicializar;
    final UserEntityModel tUserEntityModelo = UserEntityModel(
        idUsuario: '6',
        nombreUsuario: 'Nicolas',
        rutUsuario: '10647342',
        apellidoUsuario: 'Sanhueza',
        activoUsuario: 'si',
        detallePerfilUser: 'Admin',
        cliente: 'Vitacura');
    final Map mapaPropiedadesUsuario = {
      'id_usuario': '6',
      'nombre_usuario': 'Nicolas',
      'rut_usuario': '10647342',
      'apellido_usuario': 'Sanhueza',
      'activo_usuario': 'si',
      'detalle_perfil_user': 'Admin',
      'detalle_entidad': 'Vitacura'
    };

    final List<Map> jsonMaped =
        List<Map<String, dynamic>>.from(json.decode(fixture('user.json')));
    String password = '12345';
    // act
    final result = UserEntityModel.fromJson(jsonMaped[0]);
    test('''DEBERIA hacer un request POST con el rut y el password y retornar 
    el UserEntityModel con un solo usuario''', () async {
      // arrange
      setUpMockHttpSuccess200('user.json');

      // act
      remoteDataSource.loginRemoteData(
          password: password, rut: tUserEntityModelo.rutUsuario);

      // assert
      verify(mockHttpClient.post(
        _url + "/bd/loginApp.php",
        body: {
          "rut_usuario": tUserEntityModelo.rutUsuario.toString(),
          "password_usuario": password.toString(),
        },
      ));
    });
    test(
        'DEBERIA retornar UserEntityModel CUANDO el codigo de respuesta es 200',
        () async {
      // arrange
      setUpMockHttpSuccess200('arbol.json');
      // act
      final UserEntityModel result = await remoteDataSource.loginRemoteData(
          password: password, rut: tUserEntityModelo.rutUsuario);
      // assert
      expect(result, equals(tUserEntityModelo));
    });
    test('DEBERIA retornar un error si el codigo de respuesta es 404 u otro',
        () async {
      // arrange
      setUpMockHttpFailure404();
      // act
      final call = remoteDataSource.loginRemoteData;
      // assert
      expect(() => call(password: password, rut: tUserEntityModelo.rutUsuario),
          throwsA(TypeMatcher<ServerException>()));
    });
  });
}
