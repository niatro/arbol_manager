import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/constants/form_entity_test.dart';
import 'package:flutterapparbol/core/constants/lista_de_arboles_test.dart';
import 'package:flutterapparbol/core/database/no_data.dart';
import 'package:flutterapparbol/core/error/exceptions.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/network/network_info.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/arboles_local_data_source.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/arboles_remote_data_source.dart';
import 'package:flutterapparbol/features/arbol/data/models/arboles_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/data/models/form_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/data/repositories/arboles_repositorio_impl.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/form_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';

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

//OJO: repositorio getArbolesCercanos Test
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
        // arrange, se activa de donde viene la data y se dice lo que produce
        when(mockRemoteDataSource.getArbolesCercanosRemoteData(
                coordenadas: anyNamed("coordenadas")))
            .thenAnswer((_) async => tArbolesEntityModel);
        // act, se representa el objeto recibiendo la data
        final result = await repositorio.getArbolesCercanos(tCoordenadas);
        // assert, se verifica que que lo que sale del objeto recibiendo data
        // sea lo que se espera "expect(result, equals(Right(tArbolesEntity)));"
        verify(mockRemoteDataSource.getArbolesCercanosRemoteData(
            coordenadas: tCoordenadas));
        expect(result, equals(Right(tArbolesEntity)));
      });
      test(
          'DEBERIA retornar un Server failure CUANDO la llamada a la data remota no exitosa',
          () async {
        // arrange
        when(mockRemoteDataSource.getArbolesCercanosRemoteData(
                coordenadas: anyNamed("coordenadas")))
            .thenThrow(ServerException());
        // act
        final result = await repositorio.getArbolesCercanos(tCoordenadas);
        // assert
        verify(mockRemoteDataSource.getArbolesCercanosRemoteData(
            coordenadas: tCoordenadas));
        verifyZeroInteractions(mockLocalDataSource);
        //como no llegan Arboles porque fallo la comunicación con el servidor se
        // no debería haber interacciones en lado del LocalDataSource (nada que guardar)
        expect(result, equals(Left(ServerFailure())));
      });
      //Fixme: nosotros solo deberiamos poner data en el cache cuando no hay conexion y queremos grabar arboles
      //
      test(
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
      });
    });

    runTestsOffline(() {
      test('DEBERIA retornar la cache local  CUANDO la data esta presente',
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
      });

      test('DEBERIA retornar la CacheFailure l  CUANDO no hay data presente',
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
      });
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
    final IdNFCEntity idNFCEntity = IdNFCEntity(idNfc: "AS4576");
    final String idUsuario = "usuarioPrueba";
    final String idNFC = "AS4576";

    test(
        'Solo quiero verificar que el método devuelve un Either cuando es llamado',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      final Future result = repositorio.leerIdNFC(idUsuario: idUsuario);
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
        final result = await repositorio.leerIdNFC(idUsuario: idUsuario);
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
        final result = await repositorio.leerIdNFC(idUsuario: idUsuario);
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
        final result = await repositorio.leerIdNFC(idUsuario: idUsuario);
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
        final result = await repositorio.leerIdNFC(idUsuario: idUsuario);
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
        when(mockRemoteDataSource.verificarIdNFCRemoteData(
                idNFC: anyNamed('idNFC')))
            .thenAnswer((_) async => true);
        // act
        final result = await repositorio.comprobarIdNFC(idNFC: idNFC);

        // assert
        verify(mockRemoteDataSource.verificarIdNFCRemoteData(
            idNFC: anyNamed('idNFC')));
        expect(result, equals(Right(true)));
      });
      test(
          'DEBERIA retornar un valor false CUANDO no encuentra el idNFC en el servidor',
          () async {
        // arrange
        when(mockRemoteDataSource.verificarIdNFCRemoteData(
                idNFC: anyNamed('idNFC')))
            .thenAnswer((_) async => false);
        // act
        final result = await repositorio.comprobarIdNFC(idNFC: idNFC);

        // assert
        verify(mockRemoteDataSource.verificarIdNFCRemoteData(
            idNFC: anyNamed('idNFC')));
        expect(result, equals(Right(false)));
      });

      test(
          'DEBERIA retornar un Server failure CUANDO la llamada a la data remota no exitosa',
          () async {
        // arrange
        when(mockRemoteDataSource.verificarIdNFCRemoteData(
                idNFC: anyNamed('idNFC')))
            .thenThrow(ServerException());
        // act
        final result = await repositorio.comprobarIdNFC(idNFC: idNFC);
        // assert
        verify(mockRemoteDataSource.verificarIdNFCRemoteData(idNFC: idNFC));
        verifyZeroInteractions(mockLocalDataSource);

        expect(result, equals(Left(ServerFailure())));
      });
    });
  });
  //OJO: Repositorio grabar árboles una vez que están capturados,
  // Si se esta online se graba en la nube, si se esta ofline debe arrojar un error
  // Se debe entrega el parámetro que dic que árbol se debe guardar de la lista

  group('grabarArboles', () {
    final Params params = Params(nArbol: 0);
    final ArbolesEntityModelo tArbolesEntityModel =
        ArbolesEntityModelo(listaArbolesEntity: [arbolUno, arbolDos]);
    final int tNumeroArbolesInicial =
        tArbolesEntityModel.listaArbolEntity.length;
    runTestsOnline(() {
      test(
          '''DEBERIA grabar el Arbol a la BD  CUANDO  esta online'''
          ''' DEBERIA borrar el arbol grabado del listado de arboles'''
          '''CUANDO el idNFC del arbol no esta registrado''', () async {
        // arrange
        // Cuando el IdNFC no esta en la base de datos OnLine
        when(mockRemoteDataSource.verificarIdNFCRemoteData(
                idNFC: anyNamed('idNFC')))
            .thenAnswer((_) async => false);
        // Cuando se graban exitosamente  los datos
        when(mockRemoteDataSource.grabarArbolesRemoteData(
                arbol: tArbolesEntityModel.listaArbolEntity[0]))
            .thenAnswer((_) async => true);

        // act
        final result = await repositorio.grabarArboles(
            arboles: tArbolesEntityModel, nArbol: params.nArbol);
        // assert
        verifyNever(mockRemoteDataSource.verificarIdNFCRemoteData(
            idNFC: tArbolesEntityModel.listaArbolEntity[0].guiArbol));
        verifyNever(mockRemoteDataSource.grabarArbolesRemoteData(
            arbol: tArbolesEntityModel.listaArbolEntity[0]));
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
        when(mockRemoteDataSource.verificarIdNFCRemoteData(
                idNFC: anyNamed('idNFC')))
            .thenAnswer((_) async => true);
        // act
        // El proceso de grabar los datos dio falso
        final result = await repositorio.grabarArboles(
            arboles: tArbolesEntityModel, nArbol: params.nArbol);
        // assert
        //Se checkea que el procedimiento de verificación de datos alla sido llamado
        verify(mockRemoteDataSource.verificarIdNFCRemoteData(
            idNFC: tArbolesEntityModel.listaArbolEntity[0].guiArbol));
        verifyZeroInteractions(mockLocalDataSource);
      });
      test(
          '''DEBERIA arrojar ServerFailure CUANDO se esta online CUANDO el'''
          ''' idNFC del arbol no esta en la base de datos y CUANDO no se pudo grabar''',
          () async {
        // arrange
        // Cuando el IdNFC no esta en la base de datos OnLine
        when(mockRemoteDataSource.verificarIdNFCRemoteData(
                idNFC: anyNamed('idNFC')))
            .thenAnswer((_) async => false);
        // Cuando se graban exitosamente  los datos
        when(mockRemoteDataSource.grabarArbolesRemoteData(
                arbol: tArbolesEntityModel.listaArbolEntity[0]))
            .thenThrow(ServerException());
        // act
        final result = await repositorio.grabarArboles(
            arboles: tArbolesEntityModel, nArbol: params.nArbol);
        // assert
        verifyNever(mockRemoteDataSource.verificarIdNFCRemoteData(
            idNFC: arbolUno.guiArbol));
        verify(mockRemoteDataSource.grabarArbolesRemoteData(
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
        when(mockRemoteDataSource.verificarIdNFCRemoteData(
                idNFC: anyNamed('idNFC')))
            .thenThrow(ServerException());
        // Cuando se graban exitosamente  los datos
        when(mockRemoteDataSource.grabarArbolesRemoteData(
                arbol: tArbolesEntityModel.listaArbolEntity[0]))
            .thenThrow(ServerException());
        // act
        final result = await repositorio.grabarArboles(
            arboles: tArbolesEntityModel, nArbol: params.nArbol);
        // assert
        verify(mockRemoteDataSource.verificarIdNFCRemoteData(
            idNFC: tArbolesEntityModel.listaArbolEntity[0].guiArbol));
        verifyNever(mockRemoteDataSource.grabarArbolesRemoteData(
            arbol: tArbolesEntityModel.listaArbolEntity[0]));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
    //TODO: falta escribir los test offline del repositorio
    runTestsOffline(() {});
  });
  //OJO: Repositorio actualizar Datos Form si se esta online y el usuario lo solicita 🔃

  group('actualizarDatosForm', () {
    final Params params = Params(nArbol: 0);
    final String idUsuario = "usuarioPrueba";
    final FormEntityModelo tFormEntityModelo = formTestModelo;
    final ArbolesEntityModelo tArbolesEntityModel =
        ArbolesEntityModelo(listaArbolesEntity: [arbolUno, arbolDos]);
    final int tNumeroArbolesInicial =
        tArbolesEntityModel.listaArbolEntity.length;
    test(
        '''DEBERÍA revisar que el repositorio pueda obtener datos para  el form'''
        '''CUANDO esta conectado a la red''', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      final result = repositorio.actualizarDatosForm(idUsuario: idUsuario);
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
      final result = repositorio.actualizarDatosForm(idUsuario: idUsuario);
      // assert
      verify(mockNetworkInfo.isConnected);
      expect(result, isA<Future<Either>>());
    });
    runTestsOnline(() {
      test(
          'DEBERIA actualizar la Base Datos Interna CUANDO la llamada remota devuelve data ',
          () async {
        // arrange
        when(mockRemoteDataSource.getDatosForm(
                idUsuario: anyNamed('idUsuario')))
            .thenAnswer((_) async => tFormEntityModelo);
        // act
        final result = await repositorio.getDatosFormRepo(idUsuario: idUsuario);
        verify(mockRemoteDataSource.getDatosForm(idUsuario: idUsuario));
        // assert
        expect(result, equals(Right(tFormEntityModelo)));
      });
      test('DEDERIA', () async {
        // arrange

        // act

        // assert
      });
    });

    runTestsOffline(() {});
  });
}
