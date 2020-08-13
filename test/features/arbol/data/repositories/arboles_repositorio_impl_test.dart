import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/database/no_data.dart';
import 'package:flutterapparbol/core/error/exceptions.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/network/network_info.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/arboles_local_data_source.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/arboles_remote_data_source.dart';
import 'package:flutterapparbol/features/arbol/data/models/arboles_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/data/repositories/arboles_repositorio_impl.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/core/constants/lista_de_arboles_test.dart';

class MockArbolesEntityRemoteDataSource extends Mock
    implements ArbolesRemoteDataSource {}

class MockArbolesEntityLocalDataSource extends Mock
    implements ArbolesLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  ArbolesRepositorioImpl repositorio;
  MockArbolesEntityRemoteDataSource mockRemoteDataSource;
  MockArbolesEntityLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockArbolesEntityRemoteDataSource();
    mockLocalDataSource = MockArbolesEntityLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositorio = ArbolesRepositorioImpl(
        remoteDataSource: mockRemoteDataSource,
        localDatasource: mockLocalDataSource,
        netWorkInfo: mockNetworkInfo);
  });
  void runTestsOnline(Function body) {
    group('Dispositivo online', () {
      setUp(() {
        // Setea el parámetro bool de la clase NetworkInfo como true
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('Dispositivo offline', () {
      setUp(() {
        // Setea el parámetro bool de la clase NetworkInfo como true
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getArbolesCercanos', () {
    final tCoordenadas = LatLng(-33.40022111646666, -70.59898554630922);
    final String tIdNFC = "JJS97GB2300T43a";
    final ArbolesEntityModelo tArbolesEntityModel =
        ArbolesEntityModelo(listaArbolesEntity: [arbolUno, arbolDos]);
    final ArbolesEntity tArbolesEntity = tArbolesEntityModel;

    test(
        '''DEBERÍA revisar que el repositorio pueda obtener datos de arboles'''
        '''CUANDO esta conectado a la red''', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      final Future result = repositorio.getArbolesCercanos(tCoordenadas);
      // assert
      verify(mockNetworkInfo.isConnected);
      expect(result, isA<Future<Either>>());
    });
    runTestsOnline(() {
      test(
          ''''DEBERIA el repositorio debe retornar datos de arboles '''
          ''' CUANDO el RemoteDataSource obtiene datos''', () async {
        // arrange
        when(mockRemoteDataSource.getArbolesCercanos(
                coordenadas: anyNamed("coordenadas")))
            .thenAnswer((_) async => tArbolesEntityModel);
        // act
        final result = await repositorio.getArbolesCercanos(tCoordenadas);
        // assert
        verify(
            mockRemoteDataSource.getArbolesCercanos(coordenadas: tCoordenadas));
        expect(result, equals(Right(tArbolesEntity)));
      });
      test(
          'DEBERIA retornar un Server failure CUANDO la llamada a la data remota no exitosa',
          () async {
        // arrange
        when(mockRemoteDataSource.getArbolesCercanos(
                coordenadas: anyNamed("coordenadas")))
            .thenThrow(ServerException());
        // act
        final result = await repositorio.getArbolesCercanos(tCoordenadas);
        // assert
        verify(
            mockRemoteDataSource.getArbolesCercanos(coordenadas: tCoordenadas));
        verifyZeroInteractions(mockLocalDataSource);
        //como no llegan Arboles porque fallo la comunicación con el servidor se
        // no debería haber interacciones en lado del LocalDataSource (nada que guardar)
        expect(result, equals(Left(ServerFailure())));
      });
      test(
          'DEBERIA retornar data del cache CUANDO la llamada a la data de cache remota es exitosa',
          () async {
        // arrange
        when(mockRemoteDataSource.getArbolesCercanos(
                coordenadas: anyNamed("coordenadas")))
            .thenAnswer((_) async => tArbolesEntityModel);
        // act

        await repositorio.getArbolesCercanos(tCoordenadas);
        // en el repositorio junto con llamar el método se consiguen los arboles
        // y luego se pasan al método de ponerlos en el cache
        // assert

        verify(
            mockRemoteDataSource.getArbolesCercanos(coordenadas: tCoordenadas));

        verify(
            mockLocalDataSource.cacheArbolesEntityModelo(tArbolesEntityModel));
        // Aquí es donde se hace la llamada al local data source que debería tener
        // guardados los arboles una vez que se definieron con las coordenadas
      });
    });

    runTestsOffline(() {
      test('DEBERIA retornar la cache local  CUANDO la data esta presente',
          () async {
        // arrange
        when(mockLocalDataSource.getCacheArboles())
            .thenAnswer((_) async => tArbolesEntityModel);
        // act

        final result = await repositorio.getArbolesCercanos(tCoordenadas);
        // en el repositorio junto con llamar el método se consiguen los arboles
        // y luego se pasan al método de ponerlos en el cache
        // assert

        verifyZeroInteractions(mockRemoteDataSource);
        // verificar que el remote datasource no se activo
        verify(mockLocalDataSource.getCacheArboles());
        // Verificar que esto se activo una vez
        expect(result, equals(Right(tArbolesEntity)));
      });

      test('DEBERIA retornar la CacheFailure l  CUANDO no hay data presente',
          () async {
        // arrange
        when(mockLocalDataSource.getCacheArboles()).thenThrow(CacheException());
        // act

        final result = await repositorio.getArbolesCercanos(tCoordenadas);
        // en el repositorio junto con llamar el método se consiguen los arboles
        // y luego se pasan al método de ponerlos en el cache
        // assert

        verifyZeroInteractions(mockRemoteDataSource);
        // verificar que el remote datasource no se activo
        verify(mockLocalDataSource.getCacheArboles());
        // Verificar que esto se activo una vez
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
// TESTS PARA EL MÉTODO getArbolPorIdNFC
  group('getArbolPorIdNFC', () {
    final String tIdNFC = "JJS97GB2300T43a";
    final ArbolesEntityModelo tArbolesEntityModel =
        ArbolesEntityModelo(listaArbolesEntity: [arbolUno, arbolDos]);
    final ArbolesEntity tArbolesEntity = tArbolesEntityModel;
    final NoData sinDatos = NoData();

    test(
        'Solo quiero verificar que el método devuelve un Either cuando es llamado',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      final Future result = repositorio.getArbolPorIdNFC(tIdNFC);
      // assert
      expect(result, isA<Future<Either>>());
    });
    runTestsOnline(() {
      test(
          'DEBERIA retornar data remota CUANDO la llamada a la data remota es exitosa',
          () async {
        // arrange
        when(mockRemoteDataSource.getArbolPorIdNFC(idNFC: anyNamed("idNFC")))
            .thenAnswer((_) async => tArbolesEntity);
        // act
        final result = await repositorio.getArbolPorIdNFC(tIdNFC);
        // assert
        verify(mockRemoteDataSource.getArbolPorIdNFC(idNFC: tIdNFC));
        expect(result, equals(Right(tArbolesEntity)));
      });
      test(
          'DEBERIA retornar algo sin datos CUANDO la llamada a la data remota es exitosa',
          () async {
        // arrange
        when(mockRemoteDataSource.getArbolPorIdNFC(idNFC: anyNamed("idNFC")))
            .thenAnswer((_) async => null);
        // act
        final result = await repositorio.getArbolPorIdNFC(tIdNFC);
        // assert
        verify(mockRemoteDataSource.getArbolPorIdNFC(idNFC: tIdNFC));
        expect(result, equals(Right(null)));
      });

      test(
          'DEBERIA retornar un Server failure CUANDO la llamada a la data remota no exitosa',
          () async {
        // arrange
        when(mockRemoteDataSource.getArbolPorIdNFC(idNFC: anyNamed("idNFC")))
            .thenThrow(ServerException());
        // act
        final result = await repositorio.getArbolPorIdNFC(tIdNFC);
        // assert
        verify(mockRemoteDataSource.getArbolPorIdNFC(idNFC: tIdNFC));
        verifyZeroInteractions(mockLocalDataSource);
        //como no llegan Arboles porque fallo la comunicación con el servidor
        // no debería haber interacciones en lado del LocalDataSource (nada que guardar)
        expect(result, equals(Left(ServerFailure())));
      });

      test(
          'DEBERIA almacenar data del cache CUANDO la llamada a la data de cache remota es exitosa',
          () async {
        // arrange
        when(mockRemoteDataSource.getArbolPorIdNFC(idNFC: anyNamed("idNFC")))
            .thenAnswer((_) async => tArbolesEntityModel);
        // act

        await repositorio.getArbolPorIdNFC(tIdNFC);
        // en el repositorio junto con llamar el método se consiguen los arboles
        // y luego se pasan al método de ponerlos en el cache
        // assert

        verify(mockRemoteDataSource.getArbolPorIdNFC(idNFC: tIdNFC));
        // Se verifica que se ejecuto el proceso en el remote server Data Source
        // en este caso que se le paso una variable iIdNfc

        verify(
            mockLocalDataSource.cacheArbolesEntityModelo(tArbolesEntityModel));
        // Se verifica que al local data source se le paso una entidad de arboles
      });
    });
    //TODO: Seguir implementando el metodo getArbolPorIdNFC
    runTestsOffline(() {
      test(
          'DEBERIA retornar la última cache local  CUANDO la data esta presente',
          () async {
        // arrange
        when(mockLocalDataSource.getCacheArboles())
            .thenAnswer((_) async => tArbolesEntityModel);
        // act

        final result = await repositorio.getArbolPorIdNFC(tIdNFC);
        // en el repositorio junto con llamar el método se consiguen los arboles
        // y luego se pasan al método de ponerlos en el cache
        // assert

        verifyZeroInteractions(mockRemoteDataSource);
        // verificar que el remote datasource no se activo porque se activo solo
        // el localdatasource
        verify(mockLocalDataSource.getCacheArboles());
        // Verificar que esto se activo una vez
        expect(result, equals(Right(tArbolesEntity)));
      });

      test('DEBERIA retornar la CacheFailure  CUANDO no hay data presente',
          () async {
        // arrange
        when(mockLocalDataSource.getCacheArboles()).thenThrow(CacheException());
        // act

        final result = await repositorio.getArbolPorIdNFC(tIdNFC);
        // en el repositorio junto con llamar el método se consiguen los arboles
        // y luego se pasan al método de ponerlos en el cache
        // assert

        verifyZeroInteractions(mockRemoteDataSource);
        // verificar que el remote datasource no se activo
        verify(mockLocalDataSource.getCacheArboles());
        // Verificar que esto se activo una vez
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
  group('fromChipReadAndGetIdNFC', () {
    final IdNFCEntity idNFCEntity = IdNFCEntity(idNfc: "AS4576");
    final String idUsuario = "usuarioPrueba";
    final String idNFC = "AS4576";

    runTestsOnline(() {
      //TODO: implementar este metodo  implementar los otros del repositorio hasta que sea cristal clear
      test(
          'DEBERIA retornar data del Chip CUANDO la llamada a la RemoteDataSource es exitosa',
          () async {
        // arrange
        when(mockRemoteDataSource.fromChipReadAndGetIdNFC(idUsuario: idUsuario))
            .thenAnswer((_) async => idNFC);
        // act
        final result = await repositorio.fromChipReadAndGetIdNFC(idUsuario);
        // assert
        //TODO: revisar el repositorio y que pasa ahi
        verify(
            mockRemoteDataSource.fromChipReadAndGetIdNFC(idUsuario: idUsuario));
        expect(result, equals(Right(idNFCEntity)));
      });
    });
  });
}
