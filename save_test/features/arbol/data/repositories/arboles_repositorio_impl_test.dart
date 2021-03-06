import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/constants/form_entity_test.dart';
import 'package:flutterapparbol/core/constants/lista_de_arboles_test.dart';
import 'package:flutterapparbol/core/constants/usuario_test.dart';
import 'package:flutterapparbol/core/database/no_data.dart';
import 'package:flutterapparbol/core/error/exceptions.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/network/network_info.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/arboles_local_data_source.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/arboles_remote_data_source.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/form_local_source_sql.dart';
import 'package:flutterapparbol/features/arbol/data/models/arboles_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/data/repositories/arboles_repositorio_impl.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/user_entity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';

class MockArbolesEntityRemoteDataSource extends Mock
    implements ArbolesRemoteDataSource {}

class MockArbolesEntityLocalDataSource extends Mock
    implements ArbolesLocalDataSource {}

class MockFormEntitySqlDataSource extends Mock implements FormLocalSourceSql {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockDataBase extends Mock implements Database {}

void main() {
  ArbolesRepositorioImpl repositorio;
  MockArbolesEntityRemoteDataSource mockRemoteDataSource;
  MockArbolesEntityLocalDataSource mockLocalDataSource;
  MockFormEntitySqlDataSource mockSqlDataSource;
  MockNetworkInfo mockNetworkInfo;
  MockDataBase mockDataBase;

  setUp(() {
    mockRemoteDataSource = MockArbolesEntityRemoteDataSource();
    mockLocalDataSource = MockArbolesEntityLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockSqlDataSource = MockFormEntitySqlDataSource();
    repositorio = ArbolesRepositorioImpl(
        remoteDataSource: mockRemoteDataSource,
        localDatasource: mockLocalDataSource,
        sqlDataSource: mockSqlDataSource,
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

//OJO: repositorio getArbolesCercanos Test
  group('getArbolesCercanos', () {
    final tCoordenadas = LatLng(-33.40022111646666, -70.59898554630922);
    final ArbolesEntityModelo tArbolesEntityModel =
        ArbolesEntityModelo(listaArbolesEntity: [arbolUno, arbolDos]);
    final ArbolesEntity tArbolesEntity = tArbolesEntityModel;
    final int distancia = 30;

    test(
        '''DEBERÍA revisar que el repositorio pueda obtener datos de arboles'''
        '''CUANDO esta conectado a la red''', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      final Future result =
          repositorio.getArbolesCercanos(tCoordenadas, distancia);
      // assert
      verify(mockNetworkInfo.isConnected);
      expect(result, isA<Future<Either>>());
    });
    runTestsOnline(() {
      test(''''DEBERIA el repositorio debe retornar ArbolesEntity
           CUANDO el RemoteDataSource obtiene datos''', () async {
        // arrange, se activa de donde viene la data y se dice lo que produce
        when(mockRemoteDataSource.getArbolesCercanosRemoteData(
                coordenadas: anyNamed("coordenadas"),
                distancia: anyNamed("distancia")))
            .thenAnswer((_) async => tArbolesEntityModel);
        // act, se representa el objeto recibiendo la data
        final result =
            await repositorio.getArbolesCercanos(tCoordenadas, distancia);
        // assert, se verifica que que lo que sale del objeto recibiendo data
        // sea lo que se espera "expect(result, equals(Right(tArbolesEntity)));"
        verify(mockRemoteDataSource.getArbolesCercanosRemoteData(
            coordenadas: tCoordenadas, distancia: distancia));
        expect(result, equals(Right(tArbolesEntity)));
      });
      test(
          'DEBERIA retornar un Server failure CUANDO la llamada a la data remota no exitosa',
          () async {
        // arrange
        when(mockRemoteDataSource.getArbolesCercanosRemoteData(
                coordenadas: anyNamed("coordenadas"),
                distancia: anyNamed("distancia")))
            .thenThrow(ServerException());
        // act
        final result =
            await repositorio.getArbolesCercanos(tCoordenadas, distancia);
        // assert
        verify(mockRemoteDataSource.getArbolesCercanosRemoteData(
            coordenadas: tCoordenadas, distancia: distancia));
        verifyZeroInteractions(mockLocalDataSource);
        //como no llegan Arboles porque fallo la comunicación con el servidor se
        // no debería haber interacciones en lado del LocalDataSource (nada que guardar)
        expect(result, equals(Left(ServerFailure())));
      });
      //Fixme: nosotros solo deberiamos poner data en el cache cuando no hay conexion y queremos grabar arboles
      //
      /*test(
          'DEBERIA poner data al cache CUANDO la llamada a la data de cache remota es exitosa',
          () async {
        // arrange, la conexión remota es exitosa y trae los ArbolesEntidad
        when(mockRemoteDataSource.getArbolesCercanosRemoteData(
                coordenadas: anyNamed("coordenadas")))
            .thenAnswer((_) async => tArbolesEntityModel);
        // act
        // en el repositorio junto con llamar el método se consiguen los arboles
        // y luego se pasan al método de ponerlos en el cache
        await repositorio.getArbolesCercanos(tCoordenadas);

        // assert
        // Aquí es donde se hace la llamada al local data source que debería tener
        // guardados los arboles una vez que se definieron con las coordenadas
        verify(mockRemoteDataSource.getArbolesCercanosRemoteData(
            coordenadas: tCoordenadas));

        verify(mockLocalDataSource
            .cacheArbEntDeArbEntModLocalData(tArbolesEntityModel));
      });*/
    });

    runTestsOffline(() {
      /*test('DEBERIA retornar la cache local  CUANDO la data esta presente',
          () async {
        // arrange
        when(mockLocalDataSource.getCacheArbolesLocalData())
            .thenAnswer((_) async => tArbolesEntityModel);
        // act

        final result = await repositorio.getArbolesCercanos(tCoordenadas);
        // en el repositorio junto con llamar el método se consiguen los arboles
        // y luego se pasan al método de ponerlos en el cache
        // assert

        verifyZeroInteractions(mockRemoteDataSource);
        // verificar que el remote datasource no se activo
        verify(mockLocalDataSource.getCacheArbolesLocalData());
        // Verificar que esto se activo una vez
        expect(result, equals(Right(tArbolesEntity)));
      });*/

      /*test('DEBERIA retornar la CacheFailure l  CUANDO no hay data presente',
          () async {
        // arrange
        when(mockLocalDataSource.getCacheArbolesLocalData())
            .thenThrow(CacheException());
        // act

        final result = await repositorio.getArbolesCercanos(tCoordenadas);
        // en el repositorio junto con llamar el método se consiguen los arboles
        // y luego se pasan al método de ponerlos en el cache
        // assert

        verifyZeroInteractions(mockRemoteDataSource);
        // verificar que el remote datasource no se activo
        verify(mockLocalDataSource.getCacheArbolesLocalData());
        // Verificar que esto se activo una vez
        expect(result, equals(Left(CacheFailure())));
      });*/
    });
  });

  //OJO: repositorio getArbolPorIdNFC Test
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
        when(mockRemoteDataSource.getArbolPorIdNFCRemoteData(
                idNFC: anyNamed("idNFC")))
            .thenAnswer((_) async => tArbolesEntity);
        // act
        final result = await repositorio.getArbolPorIdNFC(tIdNFC);
        // assert
        verify(mockRemoteDataSource.getArbolPorIdNFCRemoteData(idNFC: tIdNFC));
        expect(result, equals(Right(tArbolesEntity)));
      });
      test(
          'DEBERIA retornar algo sin datos CUANDO la llamada a la data remota es exitosa y no hay datos',
          () async {
        // arrange
        when(mockRemoteDataSource.getArbolPorIdNFCRemoteData(
                idNFC: anyNamed("idNFC")))
            .thenAnswer((_) async => null);
        // act
        final result = await repositorio.getArbolPorIdNFC(tIdNFC);
        // assert
        verify(mockRemoteDataSource.getArbolPorIdNFCRemoteData(idNFC: tIdNFC));
        expect(result, equals(Right(null)));
      });

      test(
          'DEBERIA retornar un Server failure CUANDO la llamada a la data remota no es exitosa',
          () async {
        // arrange
        when(mockRemoteDataSource.getArbolPorIdNFCRemoteData(
                idNFC: anyNamed("idNFC")))
            .thenThrow(ServerException());
        // act
        final result = await repositorio.getArbolPorIdNFC(tIdNFC);
        // assert
        verify(mockRemoteDataSource.getArbolPorIdNFCRemoteData(idNFC: tIdNFC));
        verifyZeroInteractions(mockLocalDataSource);
        //como no llegan Arboles porque fallo la comunicación con el servidor
        // no debería haber interacciones en lado del LocalDataSource (nada que guardar)
        expect(result, equals(Left(ServerFailure())));
      });

      test(
          'DEBERIA almacenar data del cache CUANDO la llamada a la data de cache remota es exitosa',
          () async {
        // arrange
        when(mockRemoteDataSource.getArbolPorIdNFCRemoteData(
                idNFC: anyNamed("idNFC")))
            .thenAnswer((_) async => tArbolesEntityModel);
        // act

        await repositorio.getArbolPorIdNFC(tIdNFC);
        // en el repositorio junto con llamar el método se consiguen los arboles
        // y luego se pasan al método de ponerlos en el cache
        // assert

        verify(mockRemoteDataSource.getArbolPorIdNFCRemoteData(idNFC: tIdNFC));
        // Se verifica que se ejecuto el proceso en el remote server Data Source
        // en este caso que se le paso una variable iIdNfc

        verify(mockLocalDataSource
            .cacheArbEntDeArbEntModLocalData(tArbolesEntityModel));
        // Se verifica que al local data source se le paso una entidad de arboles
      });
    });

    runTestsOffline(() {
      test(
          'DEBERIA retornar la última cache local  CUANDO la data esta presente',
          () async {
        // arrange
        when(mockLocalDataSource.getCacheArbolesLocalData())
            .thenAnswer((_) async => tArbolesEntityModel);
        // act

        final result = await repositorio.getArbolPorIdNFC(tIdNFC);
        // en el repositorio junto con llamar el método se consiguen los árboles
        // y luego se pasan al método de ponerlos en el cache
        // assert

        verifyZeroInteractions(mockRemoteDataSource);
        // verificar que el remote datasource no se activo porque se activo solo
        // el localdatasource
        verify(mockLocalDataSource.getCacheArbolesLocalData());
        // Verificar que esto se activo una vez
        expect(result, equals(Right(tArbolesEntity)));
      });

      test('DEBERIA retornar la CacheFailure  CUANDO no hay data presente',
          () async {
        // arrange
        when(mockLocalDataSource.getCacheArbolesLocalData())
            .thenThrow(CacheException());
        // act

        final result = await repositorio.getArbolPorIdNFC(tIdNFC);
        // en el repositorio junto con llamar el método se consiguen los arboles
        // y luego se pasan al método de ponerlos en el cache
        // assert

        verifyZeroInteractions(mockRemoteDataSource);
        // verificar que el remote datasource no se activo
        verify(mockLocalDataSource.getCacheArbolesLocalData());
        // Verificar que esto se activo una vez
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  //OJO: repositorio leerIdNFC Test
  group('leerIdNFC', () {
    final NfcEntity idNFCEntity = NfcEntity(idNfc: "AS4576");
    final String idUsuario = "usuarioPrueba";
    final String idNFC = "AS4576";

    test(
        'Solo quiero verificar que el método devuelve un Either cuando es llamado',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      final Future result = repositorio.leerIdNfc(idUsuario: idUsuario);
      // assert
      expect(result, isA<Future<Either>>());
    });
    runTestsOnline(() {
      //TODO: implementar este método  y los otros del repositorio hasta que sea cristal clear
      test(
          'DEBERIA retornar data del Chip CUANDO la llamada a la LocalDataSource es exitosa',
          () async {
        // arrange
        when(mockLocalDataSource.leerIdNFCLocalData(idUsuario: idUsuario))
            .thenAnswer((_) async => idNFC);
        // act
        final result = await repositorio.leerIdNfc(idUsuario: idUsuario);
        // assert
        //TODO: revisar el repositorio y que pasa ahi
        verify(mockLocalDataSource.leerIdNFCLocalData(idUsuario: idUsuario));
        expect(result, equals(Right(idNFCEntity)));
      });
      test(
          'DEBERIA retornar failure CUANDO la llamada a la LocalDataSource NO es exitosa',
          () async {
        // arrange
        when(mockLocalDataSource.leerIdNFCLocalData(
                idUsuario: anyNamed("idUsuario")))
            .thenThrow(NfcException());
        // act
        final result = await repositorio.leerIdNfc(idUsuario: idUsuario);
        // assert
        verify(mockLocalDataSource.leerIdNFCLocalData(
            idUsuario: anyNamed("idUsuario")));
        expect(result, equals(Left(NfcFailure())));
      });
    });
    runTestsOffline(() {
      //TODO: implementar este método  y los otros del repositorio hasta que sea cristal clear
      test(
          'DEBERIA retornar data del Chip CUANDO la llamada a la LocalDataSource es exitosa',
          () async {
        // arrange
        when(mockLocalDataSource.leerIdNFCLocalData(idUsuario: idUsuario))
            .thenAnswer((_) async => idNFC);
        // act
        final result = await repositorio.leerIdNfc(idUsuario: idUsuario);
        // assert
        //TODO: revisar el repositorio y que pasa ahi
        verify(mockLocalDataSource.leerIdNFCLocalData(idUsuario: idUsuario));
        expect(result, equals(Right(idNFCEntity)));
      });
      test(
          'DEBERIA retornar failure CUANDO la llamada a la LocalDataSource NO es exitosa',
          () async {
        // arrange
        when(mockLocalDataSource.leerIdNFCLocalData(
                idUsuario: anyNamed("idUsuario")))
            .thenThrow(NfcException());
        // act
        final result = await repositorio.leerIdNfc(idUsuario: idUsuario);
        // assert
        verify(mockLocalDataSource.leerIdNFCLocalData(
            idUsuario: anyNamed("idUsuario")));
        expect(result, equals(Left(NfcFailure())));
      });
    });
  });

  //OJO: repositorio comprobarIdNFC Test
  group('comprobarIdNFC', () {
    final String idUsuario = "usuarioPrueba";
    final String idNFC = "AS4576";

    test(
        'Solo quiero verificar que el método devuelve un Either cuando es llamado',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      final Future result = repositorio.comprobarIdNFC(idNFC: idNFC);
      // assert
      expect(result, isA<Future<Either>>());
    });
    runTestsOnline(() {
      test(
          'DEBERIA retornar un valor true CUANDO encuentra el idNFC en el servidor',
          () async {
        // arrange
        when(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
                idNFC: anyNamed('idNFC')))
            .thenAnswer((_) async => true);
        // act
        final result = await repositorio.comprobarIdNFC(idNFC: idNFC);

        // assert
        verify(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
            idNFC: anyNamed('idNFC')));
        expect(result, equals(Right(true)));
      });
      test(
          'DEBERIA retornar un valor false CUANDO no encuentra el idNFC en el servidor',
          () async {
        // arrange
        when(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
                idNFC: anyNamed('idNFC')))
            .thenAnswer((_) async => false);
        // act
        final result = await repositorio.comprobarIdNFC(idNFC: idNFC);

        // assert
        verify(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
            idNFC: anyNamed('idNFC')));
        expect(result, equals(Right(false)));
      });

      test(
          'DEBERIA retornar un Server failure CUANDO la llamada a la data remota no exitosa',
          () async {
        // arrange
        when(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
                idNFC: anyNamed('idNFC')))
            .thenThrow(ServerException());
        // act
        final result = await repositorio.comprobarIdNFC(idNFC: idNFC);
        // assert
        verify(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
            idNFC: idNFC));
        verifyZeroInteractions(mockLocalDataSource);

        expect(result, equals(Left(ServerFailure())));
      });
    });
  });

  //OJO: Repositorio grabar árboles una vez que están capturados,
  // Si se esta online se graba en la nube, si se esta offline debe arrojar un error
  // Se debe entrega el parámetro que dic que árbol se debe guardar de la lista

  group('grabarArboles', () {
    final Params params = Params(nArbol: 0);
    final ArbolesEntityModelo tArbolesEntityModel =
        ArbolesEntityModelo(listaArbolesEntity: [arbolUno, arbolDos]);
    final int tNumeroArbolesInicial =
        tArbolesEntityModel.listaArbolEntity.length;

    final ArbolEntity arbolSeleccionado =
        tArbolesEntityModel.listaArbolEntity[0];
    final String nfcEntrante =
        tArbolesEntityModel.listaArbolEntity[0].idNfcHistoria.last;
    runTestsOnline(() {
      test(
          '''DEBERIA grabar el Arbol a la BD  CUANDO  esta online'''
          ''' DEBERIA borrar el arbol grabado del listado de arboles'''
          '''CUANDO el idNFC del arbol no esta registrado''', () async {
        // arrange
        // Cuando el IdNFC no esta en la base de datos OnLine
        when(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
                idNFC: nfcEntrante))
            .thenAnswer((_) async => false);
        // Cuando se graban exitosamente  los datos
        when(mockRemoteDataSource.grabarArboleRemoteData(
                arbol: arbolSeleccionado))
            .thenAnswer((_) async => true);

        // act
        final result = await repositorio.grabarArboles(
            arboles: tArbolesEntityModel, nArbol: params.nArbol);
        // assert
        verify(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
            idNFC: nfcEntrante));
        verify(mockRemoteDataSource.grabarArboleRemoteData(
            arbol: arbolSeleccionado));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Right(ServerGrabarSuccess())));
        expect(tArbolesEntityModel.listaArbolEntity.length,
            tNumeroArbolesInicial - 1);
      });
      test(
          '''DEBERIA no grabar el Arbol cuando esta online y CUANDO el'''
          ''' idNFC del arbol ya esta en la base de datos''', () async {
        // arrange
        // Cuando el IdNFC esta en la base de datos OnLine
        when(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
                idNFC: nfcEntrante))
            .thenAnswer((_) async => true);
        // act
        // El proceso de grabar los datos dio falso
        final result = await repositorio.grabarArboles(
            arboles: tArbolesEntityModel, nArbol: params.nArbol);
        // assert
        //Se checkea que el procedimiento de verificación de datos alla sido llamado
        verify(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
            idNFC: nfcEntrante));
        verifyZeroInteractions(mockLocalDataSource);
      });
      test(
          '''DEBERIA arrojar ServerFailure CUANDO se esta online CUANDO el'''
          ''' idNFC del arbol no esta en la base de datos y CUANDO no se pudo grabar''',
          () async {
        // arrange
        // Cuando el IdNFC no esta en la base de datos OnLine
        when(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
                idNFC: nfcEntrante))
            .thenAnswer((_) async => false);
        // Cuando se graban exitosamente  los datos
        when(mockRemoteDataSource.grabarArboleRemoteData(
                arbol: tArbolesEntityModel.listaArbolEntity[0]))
            .thenThrow(ServerException());
        // act
        final result = await repositorio.grabarArboles(
            arboles: tArbolesEntityModel, nArbol: params.nArbol);
        // assert
        verifyNever(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
            idNFC: arbolUno.guiArbol));
        verify(mockRemoteDataSource.grabarArboleRemoteData(
            arbol: tArbolesEntityModel.listaArbolEntity[0]));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
      test(
          '''DEBERIA arrojar ServerFailure CUANDO se esta online CUANDO el'''
          ''' idNFC del arbol no se pudo verificar si esta en la base de datos''',
          () async {
        // arrange
        // Cuando el IdNFC no esta en la base de datos OnLine
        when(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
                idNFC: anyNamed('idNFC')))
            .thenThrow(ServerException());
        // Cuando se graban exitosamente  los datos
        when(mockRemoteDataSource.grabarArboleRemoteData(
                arbol: tArbolesEntityModel.listaArbolEntity[0]))
            .thenThrow(ServerException());
        // act
        final result = await repositorio.grabarArboles(
            arboles: tArbolesEntityModel, nArbol: params.nArbol);
        // assert
        verify(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
            idNFC: nfcEntrante));
        verifyNever(mockRemoteDataSource.grabarArboleRemoteData(
            arbol: tArbolesEntityModel.listaArbolEntity[0]));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
    //TODO: falta escribir los test offline del repositorio
    runTestsOffline(() {});
  });

  //OJO: repositorio updateArboles
  group('updateArboles', () {
    final Params params = Params(nArbol: 0);
    final ArbolesEntityModelo tArbolesEntityModel =
        ArbolesEntityModelo(listaArbolesEntity: [arbolUno, arbolDos]);
    final int tNumeroArbolesInicial =
        tArbolesEntityModel.listaArbolEntity.length;

    final ArbolEntity arbolSeleccionado =
        tArbolesEntityModel.listaArbolEntity[0];
    final String nfcEntrante =
        tArbolesEntityModel.listaArbolEntity[0].idNfcHistoria.last;

    runTestsOnline(() {
      test(
          '''DEBERIA actualizar el Arbol a la BD-SERVER  CUANDO  esta online'''
          ''' DEBERIA borrar el arbol grabado del listado de arboles posteriormente'''
          '''CUANDO el idNFC del arbol  esta registrado''', () async {
        // arrange
        // Cuando el IdNFC  esta en la base de datos OnLine
        when(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
                idNFC: nfcEntrante))
            .thenAnswer((_) async => true);
        // Cuando se updatean exitosamente  los datos
        when(mockRemoteDataSource.updateArbolRemoteData(
                arbol: arbolSeleccionado))
            .thenAnswer((_) async => true);

        // act
        final result = await repositorio.updateArbol(
            arboles: tArbolesEntityModel, nArbol: params.nArbol);
        // assert

        verify(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
            idNFC: nfcEntrante));
        verify(mockRemoteDataSource.updateArbolRemoteData(
            arbol: arbolSeleccionado));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Right(ServerUpdateSuccess())));
        expect(tArbolesEntityModel.listaArbolEntity.length,
            tNumeroArbolesInicial - 1);
      });
      test(
          '''DEBERIA arrojar un ArbolNoUpdateNoExisteFailure'''
          '''CUANDO el idNFC no esta en el servidor''', () async {
        // arrange
        when(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
                idNFC: nfcEntrante))
            .thenAnswer((_) async => false);

        // act
        final result = await repositorio.updateArbol(
            arboles: tArbolesEntityModel, nArbol: params.nArbol);
        // assert
        verifyNever(mockRemoteDataSource.updateArbolRemoteData(
            arbol: arbolSeleccionado));
        expect(result, equals(Left(ArbolNoUpdateNoExisteFailure())));
      });
      test(
          '''''DEBERIA arrojar un Left(ServerUpdateFailure()'''
          '''CUANDO el idNFC esta pero por alguna razon no se updatea en el servidor''',
          () async {
        // arrange
        when(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
                idNFC: nfcEntrante))
            .thenAnswer((_) async => true);
        when(mockRemoteDataSource.updateArbolRemoteData(
                arbol: arbolSeleccionado))
            .thenAnswer((_) async => false);
        // act
        final result = await repositorio.updateArbol(
            arboles: tArbolesEntityModel, nArbol: params.nArbol);
        // assert
        verifyNever(mockRemoteDataSource.updateArbolRemoteData(
            arbol: arbolSeleccionado));
        expect(result, equals(Left(ServerUpdateFailure())));
      });
    });
    //OJO: No hay test offline
    runTestsOffline(() {
      test(
          '''DEBERIA arrojar un ConexionFailure'''
          '''CUANDO no hay internet''', () async {
        // arrange

        // act
        final result = await repositorio.updateArbol(
            arboles: tArbolesEntityModel, nArbol: params.nArbol);
        // assert
        verifyNever(mockRemoteDataSource.verificarSiExisteIdNfcRemoteData(
            idNFC: nfcEntrante));
        verifyNever(mockRemoteDataSource.updateArbolRemoteData(
            arbol: arbolSeleccionado));

        expect(result, equals(Left(ConexionFailure())));
      });
    });
  });

  //OJO: Repositorio actualizar Datos Form si se esta online y el usuario lo solicita 🔃
  group('actualizarDatosForm', () {
    final String idUsuario = "usuarioPrueba";
    final ArbolesEntityModelo tArbolesEntityModel =
        ArbolesEntityModelo(listaArbolesEntity: [arbolUno, arbolDos]);
    final int tNumeroArbolesInicial =
        tArbolesEntityModel.listaArbolEntity.length;
    test(
        '''DEBERÍA revisar que esta Online y asi obtener datos para el form'''
        '''CUANDO esta conectado a la red''', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      final result = repositorio.actualizarDatosForm(params: NoParams());
      // assert
      verify(mockNetworkInfo.isConnected);
      expect(result, isA<Future<Either>>());
    });
    test(
        '''DEBERÍA revisar que el repositorio obtenga un Failure'''
        '''CUANDO no esta conectado a la red''', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = repositorio.actualizarDatosForm(params: NoParams());
      // assert
      verify(mockNetworkInfo.isConnected);
      expect(result, isA<Future<Either>>());
    });
    runTestsOnline(() {
      test(
          'DEBERIA actualizar la Base Datos Interna y arrojar un success CUANDO la llamada remota devuelve data ',
          () async {
        // arrange
        when(mockRemoteDataSource.actualizarBaseDatosFormularios())
            .thenAnswer((_) async => true);
        // act
        final result =
            await repositorio.actualizarDatosForm(params: NoParams());
        verify(mockRemoteDataSource.actualizarBaseDatosFormularios());
        // assert
        expect(result, equals(Right(ServerActualizarFormSuccess())));
      });
      test(
          'DEDERIA arrojar un failure CUANDO no es capaz de actualizar la Base de Datos',
          () async {
        // arrange
        when(mockRemoteDataSource.actualizarBaseDatosFormularios())
            .thenAnswer((_) async => false);
        // act
        final result =
            await repositorio.actualizarDatosForm(params: NoParams());
        verify(mockRemoteDataSource.actualizarBaseDatosFormularios());
        // assert
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test(
          'DEBERIA entregar una falla de actualización CUANDO el dispositivo esta offline',
          () async {
        // arrange
        when(mockRemoteDataSource.actualizarBaseDatosFormularios())
            .thenThrow((_) async => false);
        // act
        final result =
            await repositorio.actualizarDatosForm(params: NoParams());

        // assert
        expect(result, Left(ConexionFailure()));
        verifyNever(mockRemoteDataSource.actualizarBaseDatosFormularios());
      });
    });
  });

  group('getDatosForm', () {
    final String idUsuario = "usuarioPrueba";

    test(
        'DEBERIA arrojar un un FormEntity CUANDO no hay problemas con la BD interna',
        () async {
      // arrange
      when(mockSqlDataSource.getDatosFormSql(idUsuario: anyNamed('idUsuario')))
          .thenAnswer((_) async => tFormTestModelo);
      // act
      final result = await repositorio.getDatosForm(idUsuario: idUsuario);
      verify(mockSqlDataSource.getDatosFormSql(idUsuario: idUsuario));
      // assert
      expect(result, Right(tFormTestModelo));
    });

    test(
        'DEBERIA arrojar un un Failure CUANDO  hay problemas con la BD interna',
        () async {
      // arrange
      when(mockSqlDataSource.getDatosFormSql(idUsuario: anyNamed('idUsuario')))
          .thenThrow(DataBaseException());
      // act
      final result = await repositorio.getDatosForm(idUsuario: idUsuario);
      verify(mockSqlDataSource.getDatosFormSql(idUsuario: idUsuario));
      // assert
      expect(result, Left(SqlFailure()));
    });
  });

  group('getCoordenadas', () {
    Position position = Position(latitude: -33.2, longitude: -45.3);
    LatLng latLong = LatLng(-33.2, -45.3);
    test(
        'DEBERIA retornar una clase LatLng CUANDO el reposito arroja un Position',
        () async {
      // arrange
      when(mockLocalDataSource.getCoordenadasLocalData())
          .thenAnswer((_) async => position);
      // act
      final result = await repositorio.getCoordenadas(params: NoParams());

      // assert
      expect(result, Right(latLong));
    });
    test(
        'DEBERIA retornar una clase Failure con coord CUANDO el reposito arrroja una excepcion',
        () async {
      // arrange
      when(mockLocalDataSource.getCoordenadasLocalData())
          .thenThrow(LocationException());
      // act
      final result = await repositorio.getCoordenadas(params: NoParams());

      // assert
      expect(result, Left(LocalGpsFailure()));
    });
  });

  //OJO: repositorio login Test
  group('login', () {
    final UserEntity usuarioTestParaTest = usuarioTest;
    final String password = 'mypass';
    final String rut = '10647342';

    test('Deberia', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      final Future result = repositorio.login(password: password, rut: rut);

      // assert
      verify(mockNetworkInfo.isConnected);
      expect(result, isA<Future<Either>>());
    });
    runTestsOnline(() {
      test(
          '''DEBERIA retornar un UserEntity CUANDO no hay problemas en el servidor y el password esta OK''',
          () async {
        // arrange
        when(mockRemoteDataSource.loginRemoteData(
                password: anyNamed("password"), rut: anyNamed("rut")))
            .thenAnswer((_) async => usuarioTestParaTest);
        // act
        final result = await repositorio.login(password: password, rut: rut);
        // assert
        verify(mockRemoteDataSource.loginRemoteData(
            password: password, rut: usuarioTestParaTest.rutUsuario));
        expect(result, equals(Right(usuarioTestParaTest)));
      });
      test('''DEBERIA retornar un ServerFailure CUANDO hay problemas en el 
          servidor y no se puede conectar''', () async {
        // arrange
        when(mockRemoteDataSource.loginRemoteData(
                password: anyNamed("password"), rut: anyNamed("rut")))
            .thenThrow(ServerException());
        // act
        final result = await repositorio.login(password: password, rut: rut);
        // assert
        verify(
            mockRemoteDataSource.loginRemoteData(password: password, rut: rut));
        expect(result, equals(Left(ServerFailure())));
      });

      test(
          '''DEBERIA retornar un PasswordNoExisteFailure CUANDO no hay problemas en el 
      servidor y no se encuentra el password''', () async {
        // arrange
        when(mockRemoteDataSource.loginRemoteData(
                password: anyNamed("password"), rut: anyNamed("rut")))
            .thenThrow(PassException());
        // act
        final result = await repositorio.login(
            password: password, rut: usuarioTestParaTest.rutUsuario);
        // assert
        verify(mockRemoteDataSource.loginRemoteData(
            password: password, rut: usuarioTestParaTest.rutUsuario));
        expect(result, equals(Left(PassNoExisteFailure())));
      });
    });
  });
}
