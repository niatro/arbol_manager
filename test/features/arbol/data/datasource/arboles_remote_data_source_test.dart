import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapparbol/core/constants/server_prueba.dart';
import 'package:flutterapparbol/core/error/exceptions.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/arboles_remote_data_source.dart';
import 'package:flutterapparbol/features/arbol/data/models/arboles_entity_modelo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  ArbolesRemoteDataSourceImpl remoteDataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSource = ArbolesRemoteDataSourceImpl(client: mockHttpClient);
  });
  final String _url = urlPruebas;
  void setUpMockHttpSuccess200(String file) {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response(fixture(file), 200));
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
    final tArbolesTestModelo =
        ArbolesEntityModelo.fromJson(parsedListMapFromJson: jsonMaped);
    test('''DEBERIA hacer un request al URL con las coordenadas y 
    recibir arboles cercanos  en un radio por definir''', () async {
      // arrange
      setUpMockHttpSuccess200('arboles.json');
      // act
      remoteDataSource.getArbolesCercanosRemoteData(
          coordenadas: coordenadasTest);

      // assert
      verify(mockHttpClient.post(
        _url + "/bd/getArbolPorCoordenadas.php",
        body: {
          "latitud": coordenadasTest.latitude.toString(),
          "longitud": coordenadasTest.longitude.toString(),
        },
      ));
    });
    test(
        'DEBERIA retornar ArbolEntityModelo cuando el codigo de respuesta es 200',
        () async {
      // arrange
      setUpMockHttpSuccess200('arboles.json');
      // act
      final ArbolesEntityModelo result = await remoteDataSource
          .getArbolesCercanosRemoteData(coordenadas: coordenadasTest);
      // assert
      expect(result, equals(tArbolesTestModelo));
    });
    test('DEBERIA retornar un error si el codigo de respuesta es 404 u otro',
        () async {
      // arrange
      setUpMockHttpFailure404();
      // act
      final call = remoteDataSource.getArbolesCercanosRemoteData;
      // assert
      expect(() => call(coordenadas: coordenadasTest),
          throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getArbolPorIdNFC', () {
    final String idNFC = "832NS8Hvw23";
    final List<Map> jsonMaped =
        List<Map<String, dynamic>>.from(json.decode(fixture('arbol.json')));
    final tArbolesTestModelo =
        ArbolesEntityModelo.fromJson(parsedListMapFromJson: jsonMaped);
    test('''DEBERIA hacer un request POST con el idNFC y retornar 
    el ArbolEntityModel con un solo arbol''', () async {
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
}
