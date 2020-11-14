import 'package:flutterapparbol/core/constants/form_entity_test.dart';
import 'package:flutterapparbol/core/constants/usuario_test.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/core/util/input_converter.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/form_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/user_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/actualizar_datos_form_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/comprobar_idnfc_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_arbol_por_idnfc_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_arboles_cercanos_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_coordenadas_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_datos_form_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/grabar_arboles_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/leer_idnfc_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/login_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/update_arboles_usecase.dart';
import 'package:flutterapparbol/features/arbol/presentation/bloc/arboles_entity/arboles_entity_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../lib/core/constants/lista_de_arboles_test.dart';

class MockGetArbolesCercanosUseCase extends Mock
    implements GetArbolesCercanosUseCase {}

class MockGetArbolPorIdNFCUseCase extends Mock
    implements GetArbolPorIdNFCUseCase {}

class MockGrabarArbolesUseCase extends Mock implements GrabarArbolUseCase {}

class MockComprobarIdNFCUseCase extends Mock implements ComprobarIdNFCUseCase {}

class MockActualizarDatosFormUseCase extends Mock
    implements ActualizarDatosFormUseCase {}

class MockUpdateArbolesUseCase extends Mock implements UpdateArbolesUseCase {}

class MockLeerIdNFCUseCase extends Mock implements LeerIdNfcUseCase {}

class MockGetCoordUseCase extends Mock implements GetCoordUseCase {}

class MockGetDatosFormUseCase extends Mock implements GetDatosFormUseCase {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockInputConverterStrToLatLng extends Mock
    implements InputConverterStrToLatLng {}

class MockInputConverterFromIdNFCToStr extends Mock
    implements InputConverterIdNFCToStr {}

void main() {
  MockGetArbolesCercanosUseCase mockGetArbolesCercanosUseCase;
  MockGetArbolPorIdNFCUseCase mockGetArbolPorIdNFCUseCase;
  MockGrabarArbolesUseCase mockGrabarArbolesUseCase;
  MockComprobarIdNFCUseCase mockComprobarIdNFCUseCase;
  MockUpdateArbolesUseCase mockUpdateArbolesUseCase;
  MockActualizarDatosFormUseCase mockActualizarDatosFormUseCase;
  MockGetDatosFormUseCase mockGetDatosFormUseCase;
  MockLeerIdNFCUseCase mockLeerIdNfcUseCase;
  MockGetCoordUseCase mockGetCoordUseCase;
  MockLoginUseCase mockLoginUseCase;
  MockInputConverterStrToLatLng mockInputConverter;
  MockInputConverterFromIdNFCToStr mockInputConverterFromIdNFCToStr;
  ArbolesEntityBloc arbolesEntityBloc;

  setUp(() {
    mockGetArbolesCercanosUseCase = MockGetArbolesCercanosUseCase();
    mockGetArbolPorIdNFCUseCase = MockGetArbolPorIdNFCUseCase();
    mockGrabarArbolesUseCase = MockGrabarArbolesUseCase();
    mockComprobarIdNFCUseCase = MockComprobarIdNFCUseCase();
    mockUpdateArbolesUseCase = MockUpdateArbolesUseCase();
    mockActualizarDatosFormUseCase = MockActualizarDatosFormUseCase();
    mockGetDatosFormUseCase = MockGetDatosFormUseCase();
    mockLeerIdNfcUseCase = MockLeerIdNFCUseCase();
    mockGetCoordUseCase = MockGetCoordUseCase();
    mockLoginUseCase = MockLoginUseCase();
    mockInputConverter = MockInputConverterStrToLatLng();
    mockInputConverterFromIdNFCToStr = MockInputConverterFromIdNFCToStr();
    arbolesEntityBloc = ArbolesEntityBloc(
        arbolesCercanosUseCase: mockGetArbolesCercanosUseCase,
        arbolPorIdNFCUseCase: mockGetArbolPorIdNFCUseCase,
        grabarArbolUseCase: mockGrabarArbolesUseCase,
        updateArbolesUseCase: mockUpdateArbolesUseCase,
        comprobarIdNFCUseCase: mockComprobarIdNFCUseCase,
        actualizarDatosFormUseCase: mockActualizarDatosFormUseCase,
        getDatosFormUseCase: mockGetDatosFormUseCase,
        getCoordUseCase: mockGetCoordUseCase,
        loginUseCase: mockLoginUseCase,
        leerIdNfcUseCase: mockLeerIdNfcUseCase,
        inputConverter: mockInputConverter,
        inputConverterFromIdNFCToStr: mockInputConverterFromIdNFCToStr);
  });

  test('DEBERIA emitir un estado inicial de empty', () async {
    // assert
    expect(arbolesEntityBloc.initialState, Empty());
  });
  // Testea la funcionalidad de árboles cercanos a una coordenada
  group('GetArbolesCercanos Event es lo primero que probamos', () {
    final String tCoordenadasStr = "-33.398827188275405,-70.59860965002224";
    final LatLng tCoordenadasParseada =
        LatLng(-33.398827188275405, -70.59860965002224);

    final ArbolesEntity tArbolesEntity =
        ArbolesEntity(listaArbolEntity: [arbolUno, arbolDos]);
    void setUpinputCoverterSuccess() =>
        when(mockInputConverter.stringToLatLng(any))
            .thenReturn(Right(tCoordenadasParseada));
    //TODO: creo que hay que hacer un mock del get coordenada

    test('''DEBERIA llamar al InputConverter para validar y convertir
        el String en un unsigned LatLong que nos servira para
        buscar los arboles cercanos''', () async {
      // arrange
      setUpinputCoverterSuccess();

      // act
      arbolesEntityBloc.add(GetArbolesEntityCercanosEvent(tCoordenadasStr));
      await untilCalled(mockInputConverter.stringToLatLng(any));

      // assert
      verify(mockInputConverter.stringToLatLng(tCoordenadasStr));
    });
    test('DEBERIA emitir [Error] CUANDO el input LatLng es invalido', () async {
      // arrange
      when(mockInputConverter.stringToLatLng(any))
          .thenReturn(Left(InvalidInputFailure()));
      // assert later
      final expected = [
        Empty(),
        Error(message: INVALID_INPUT_FAILURE_MESSAGE),
      ];
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
      // [expectLater] espera por 30 segundos a que lleguen los valores del
      // stream
      // act
      arbolesEntityBloc.add(GetArbolesEntityCercanosEvent(tCoordenadasStr));
//      await untilCalled(mockInputConverter.stringToUnsignedLatLng(any));
    });
    test('DEBERIA emitir data de un CUANDO tenemos llega un UseCase Success',
        () async {
      // arrange
      setUpinputCoverterSuccess();
      when(mockGetArbolesCercanosUseCase(any))
          .thenAnswer((_) async => Right(tArbolesEntity));
      // act
      arbolesEntityBloc.add(GetArbolesEntityCercanosEvent(tCoordenadasStr));
      await untilCalled(mockGetArbolesCercanosUseCase(any));
      // assert
      verify(mockGetArbolesCercanosUseCase(
          Params(coordenada: tCoordenadasParseada)));
    });
    test(
        'DEBERIA emitir [Loading, Loaded] cuando la data es reunida exitosamente',
        () async {
      // arrange
      setUpinputCoverterSuccess();
      when(mockGetArbolesCercanosUseCase(any))
          .thenAnswer((_) async => Right(tArbolesEntity));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        LoadedArboles(arboles: tArbolesEntity),
      ];
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
      //
      arbolesEntityBloc.add(GetArbolesEntityCercanosEvent(tCoordenadasStr));
    });
    test('DEBERIA emitir [Loading, Error] cuando la data no pudo ser colectada',
        () async {
      // arrange
      setUpinputCoverterSuccess();
      when(mockGetArbolesCercanosUseCase(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
      //
      arbolesEntityBloc.add(GetArbolesEntityCercanosEvent(tCoordenadasStr));
    });
    test(
        'DEBERIA emitir [Loading, Error] con el mensaje correcto cuando la data falla ',
        () async {
      // arrange
      setUpinputCoverterSuccess();
      when(mockGetArbolesCercanosUseCase(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
      //
      arbolesEntityBloc.add(GetArbolesEntityCercanosEvent(tCoordenadasStr));
    });
  });
  // Testea la funcionalidad de arboles por idNFC
  group('GetArbolesPorIdNFC Event es lo primero que probamos', () {
    final ArbolesEntity tArbolesEntity =
        ArbolesEntity(listaArbolEntity: [arbolUno, arbolDos]);
    final String tIdNFC = "uh387qs123J4";
    void setUpinputCoverterFromIdNFCToStrSuccess() =>
        when(mockInputConverterFromIdNFCToStr.idNFCToStr(any))
            .thenReturn(Right(tIdNFC));

    test(
        'DEBERIA emitir data de un CUANDO llega un getArbolporIdNFCUseCase Success',
        () async {
      // arrange
      //TODO: creo que hay que hacer un mock del get idnfc
      setUpinputCoverterFromIdNFCToStrSuccess();
      when(mockGetArbolPorIdNFCUseCase(any))
          .thenAnswer((_) async => Right(tArbolesEntity));
      // act
      arbolesEntityBloc.add(GetArbolesEntityPorIdNFCEvent(tIdNFC));
      await untilCalled(mockGetArbolPorIdNFCUseCase(any));
      // assert
      verify(mockGetArbolPorIdNFCUseCase(Params(idNFC: tIdNFC)));
    });
    test(
        'DEBERIA emitir [Loading, Loaded] cuando la data es reunida exitosamente',
        () async {
      // arrange
      setUpinputCoverterFromIdNFCToStrSuccess();
      when(mockGetArbolPorIdNFCUseCase(any))
          .thenAnswer((_) async => Right(tArbolesEntity));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        LoadedArboles(arboles: tArbolesEntity),
      ];
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
      //
      arbolesEntityBloc.add(GetArbolesEntityPorIdNFCEvent(tIdNFC));
    });
    test(
        'DEBERIA emitir [Loading, Error] cuando no se pudo conectar con el servidor',
        () async {
      // arrange
      setUpinputCoverterFromIdNFCToStrSuccess();
      when(mockGetArbolPorIdNFCUseCase(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
      //
      arbolesEntityBloc.add(GetArbolesEntityPorIdNFCEvent(tIdNFC));
    });
    test(
        'DEBERIA emitir [Loading, Error] con el mensaje correcto cuando la data falla ',
        () async {
      // arrange
      setUpinputCoverterFromIdNFCToStrSuccess();
      when(mockGetArbolPorIdNFCUseCase(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
      //
      arbolesEntityBloc.add(GetArbolesEntityPorIdNFCEvent(tIdNFC));
    });
  });
  group('GrabarArboles Event', () {
    final ArbolesEntity tArbolesEntity =
        ArbolesEntity(listaArbolEntity: [arbolUno, arbolDos]);
    final bool respuesta = true;
    test(
        'DEBERIA llamarse el metodo GrabarArbolesUseCase CUANDO se pasa un evento al Bloc',
        () async {
      // arrange
      when(mockGrabarArbolesUseCase.call(any))
          .thenAnswer((_) async => Right(ServerGrabarSuccess()));
      // act

      arbolesEntityBloc.add(GrabarArbolEvent(tArbolesEntity, 1));
      await untilCalled(mockGrabarArbolesUseCase.call(any));
      // assert
      verify(mockGrabarArbolesUseCase.call(any));
    });
    test('''DEBERIA tomar un arbol grabarlo en la base de datos
    obtener un true y removerlo del listado CUANDO se gatille
    el evento de guardar''', () async {
      // arrange
      when(mockGrabarArbolesUseCase(any))
          .thenAnswer((_) async => Right(ServerGrabarSuccess()));
      final expected = [
        Empty(),
        Saving(),
        Saved(success: ServerGrabarSuccess()),
      ];
      // act
      arbolesEntityBloc.add(GrabarArbolEvent(tArbolesEntity, 1));

      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
    test('DEBERIA emitir un [error] CUANDO hay un problema de conxión ',
        () async {
      // arrange
      when(mockGrabarArbolesUseCase.call(any))
          .thenAnswer((_) async => Left(ConexionFailure()));
      final expected = [
        Empty(),
        Saving(),
        Error(message: CONEXION_FAILURE_MESSAGE),
      ];
      // act
      arbolesEntityBloc.add(GrabarArbolEvent(tArbolesEntity, 1));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
    test('DEBERIA emitir un [error] CUANDO hay un problema el nfc existe ',
        () async {
      // arrange
      when(mockGrabarArbolesUseCase.call(any))
          .thenAnswer((_) async => Left(ArbolNoGrabaYaExisteFailure()));
      final expected = [
        Empty(),
        Saving(),
        Error(message: IDFNC_EXISTE_FAILURE_MESSAGE),
      ];
      // act
      arbolesEntityBloc.add(GrabarArbolEvent(tArbolesEntity, 1));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
    test('DEBERIA emitir un [error] CUANDO hay un problema el nfc existe ',
        () async {
      // arrange
      when(mockGrabarArbolesUseCase.call(any))
          .thenAnswer((_) async => Left(ServerGrabarFailure()));
      final expected = [
        Empty(),
        Saving(),
        Error(message: SERVER_SAVE_FAILURE_MESSAGE),
      ];
      // act
      arbolesEntityBloc.add(GrabarArbolEvent(tArbolesEntity, 1));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
  });
  group('UpdateArbol Event', () {
    final ArbolesEntity tArbolesEntity =
        ArbolesEntity(listaArbolEntity: [arbolUno, arbolDos]);
    test(
        'DEBERIA llamarse el metodo UpdateArbolUseCase CUANDO se pasa un evento al Bloc',
        () async {
      // arrange
      when(mockUpdateArbolesUseCase.call(any))
          .thenAnswer((_) async => Right(ServerUpdateSuccess()));
      // act

      arbolesEntityBloc.add(UpdateArbolEvent(tArbolesEntity, 1));
      await untilCalled(mockUpdateArbolesUseCase.call(any));
      // assert
      verify(mockUpdateArbolesUseCase.call(any));
    });
    test('''DEBERIA tomar un arbol previamente seleccionado de la base de datos
    y hacer un Update CUANDO se gatille
    el evento de actualizar''', () async {
      // arrange
      when(mockUpdateArbolesUseCase.call(any))
          .thenAnswer((_) async => Right(ServerUpdateSuccess()));
      final expected = [
        Empty(),
        Saving(),
        UpdatedArbol(success: ServerUpdateSuccess()),
      ];
      // act
      arbolesEntityBloc.add(UpdateArbolEvent(tArbolesEntity, 1));

      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
    test('DEBERIA emitir un [error] CUANDO hay un problema de conxión ',
        () async {
      // arrange
      when(mockUpdateArbolesUseCase.call(any))
          .thenAnswer((_) async => Left(ConexionFailure()));
      final expected = [
        Empty(),
        Saving(),
        Error(message: CONEXION_FAILURE_MESSAGE),
      ];
      // act
      arbolesEntityBloc.add(UpdateArbolEvent(tArbolesEntity, 1));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });

    test('DEBERIA emitir un [error] CUANDO hay un problema el arbol ya existe ',
        () async {
      // arrange
      when(mockUpdateArbolesUseCase(any))
          .thenAnswer((_) async => Left(ArbolNoUpdateNoExisteFailure()));
      final expected = [
        Empty(),
        Saving(),
        Error(message: UPDATE_NFC_FAILURE_MESSAGE),
      ];
      // act
      arbolesEntityBloc.add(UpdateArbolEvent(tArbolesEntity, 1));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });

    test('DEBERIA emitir un [error] CUANDO no se puede actualizar ', () async {
      // arrange
      when(mockUpdateArbolesUseCase(any))
          .thenAnswer((_) async => Left(ServerUpdateFailure()));
      final expected = [
        Empty(),
        Saving(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      // act
      arbolesEntityBloc.add(UpdateArbolEvent(tArbolesEntity, 1));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
  });
  group('ActualizarDatosForm Event', () {
    UserEntity usuario = usuarioUno;
    test(
        'DEBERIA llamarse el metodo UpdateArbolUseCase CUANDO se pasa un evento al Bloc',
        () async {
      // arrange
      when(mockActualizarDatosFormUseCase.call(any))
          .thenAnswer((_) async => Right(ServerActualizarFormSuccess()));
      // act

      arbolesEntityBloc.add(ActualizarFormEvent(usuario));
      await untilCalled(mockActualizarDatosFormUseCase.call(any));
      // assert
      verify(mockActualizarDatosFormUseCase.call(any));
    });
    test('DEBERIA dar un success CUANDO la data sql se puede actualizar',
        () async {
      // arrange
      when(mockActualizarDatosFormUseCase.call(any))
          .thenAnswer((_) async => Right(ServerActualizarFormSuccess()));
      // act
      final expected = [
        Empty(),
        Loading(),
        UpdatedSql(success: ServerActualizarFormSuccess()),
      ];
      arbolesEntityBloc.add(ActualizarFormEvent(usuario));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
    test('DEBERIA emitir un [error] CUANDO hay un problema de conxión ',
        () async {
      // arrange
      when(mockActualizarDatosFormUseCase.call(any))
          .thenAnswer((_) async => Left(ConexionFailure()));
      final expected = [
        Empty(),
        Loading(),
        Error(message: CONEXION_FAILURE_MESSAGE),
      ];
      // act
      arbolesEntityBloc.add(ActualizarFormEvent(usuario));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
    test(
        'DEBERIA emitir un [error] CUANDO hay un problema preguntando los datos del servidor ',
        () async {
      // arrange
      when(mockActualizarDatosFormUseCase.call(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      // act
      arbolesEntityBloc.add(ActualizarFormEvent(usuario));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
  });
  group('GetDatosForm Event', () {
    UserEntity usuario = usuarioUno;
    FormEntity formEntity = formTest;

    test(
        'DEBERIA emitir un [error] CUANDO hay un problema preguntando los datos locales',
        () async {
      // arrange
      when(mockGetDatosFormUseCase.call(any))
          .thenAnswer((_) async => Left(SqlFailure()));
      // act
      final expected = [
        Empty(),
        Loading(),
        Error(message: SQL_FAILURE),
      ];
      arbolesEntityBloc.add(GetDatosFormEvent(usuario.idUsuario));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
    test('DEBERIA emitir un [error] CUANDO hay un problema en el servidor',
        () async {
      // arrange
      when(mockGetDatosFormUseCase.call(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      arbolesEntityBloc.add(GetDatosFormEvent(usuario.idUsuario));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
    test(
        'DEBERIA emitir un formEntityState CUANDO se llama a la base de datos sqlite',
        () async {
      // arrange
      when(mockGetDatosFormUseCase.call(any))
          .thenAnswer((_) async => Right(formTest));
      final expected = [
        Empty(),
        Loading(),
        UpdatedForm(formData: formEntity),
      ];
      // act
      arbolesEntityBloc.add(GetDatosFormEvent(usuario.idUsuario));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
  });
  group('LoginUseCase Event', () {
    UserEntity usuario = usuarioUno;
    FormEntity formEntity = formTest;
    String rut = '10647342';
    String password = 'mypass';
    test('DEBERIA llamarse el metodo login CUANDO se pasa un evento al Bloc',
        () async {
      // arrange
      when(mockLoginUseCase.call(any)).thenAnswer((_) async => Right(usuario));
      // act

      arbolesEntityBloc.add(LoginUserEvent(password, rut));
      await untilCalled(mockLoginUseCase.call(any));
      // assert
      verify(mockLoginUseCase.call(any));
    });
    test('DEBERIA traer un UserEntity CUANDO logra conectarse al servidor',
        () async {
      // arrange
      when(mockLoginUseCase.call(any)).thenAnswer((_) async => Right(usuario));
      // act
      final expected = [
        Empty(),
        Loading(),
        LoadedUser(usuario: usuario),
      ];
      arbolesEntityBloc.add(LoginUserEvent(password, rut));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });

    test(
        'DEBERIA arrojar un failure CUANDO el usuario no esta en la Base de Datos',
        () async {
      // arrange
      when(mockLoginUseCase.call(any))
          .thenAnswer((_) async => Left(PassNoExisteFailure()));

      // act
      final expected = [
        Empty(),
        Loading(),
        Error(message: PASSWORD_FAILURE),
      ];
      arbolesEntityBloc.add(LoginUserEvent(password, rut));

      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });

    test('DEBERIA arrojar un failure CUANDO no se pudo conectar al servidor',
        () async {
      // arrange
      when(mockLoginUseCase.call(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      arbolesEntityBloc.add(LoginUserEvent(password, rut));

      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });

    test('DEBERIA arrojar un Conexionfailure CUANDO no hay internet', () async {
      // arrange
      when(mockLoginUseCase.call(any))
          .thenAnswer((_) async => Left(ConexionFailure()));
      // act
      final expected = [
        Empty(),
        Loading(),
        Error(message: CONEXION_FAILURE_MESSAGE),
      ];
      arbolesEntityBloc.add(LoginUserEvent(password, rut));

      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
  });
  group('LeerIdNFCUseCase Event', () {
    final String tIdNFC = "uh387qs123J4";
    UserEntity usuario = usuarioUno;
    final NfcEntity nfcEntity = NfcEntity(idNfc: tIdNFC);
    test(
        'DEBERIA llamarse el método IdNfcUseCase CUANDO se pasa un evento al Bloc',
        () async {
      // arrange
      when(mockLeerIdNfcUseCase.call(any))
          .thenAnswer((_) async => Right(NfcEntity(idNfc: tIdNFC)));
      // act

      arbolesEntityBloc.add(LeerIdNfcEvent(usuario));
      await untilCalled(mockLeerIdNfcUseCase.call(any));
      // assert
      verify(mockLeerIdNfcUseCase.call(any));
    });
    test('DEBERIA traer un NfcEntity CUANDO logra leer el chip', () async {
      // arrange
      when(mockLeerIdNfcUseCase.call(any))
          .thenAnswer((_) async => Right(nfcEntity));
      // act
      final expected = [
        Empty(),
        Loading(),
        ReadedNfc(nfcEntity: nfcEntity),
      ];
      arbolesEntityBloc.add(LeerIdNfcEvent(usuario));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
    test('DEBERIA arrojar un [Error] CUANDO no logra leer el chip', () async {
      // arrange
      when(mockLeerIdNfcUseCase.call(any))
          .thenAnswer((_) async => Left(NfcFailure()));
      // act
      final expected = [
        Empty(),
        Loading(),
        Error(message: READ_NFC_FAILURE_MESSAGE),
      ];

      arbolesEntityBloc.add(LeerIdNfcEvent(usuario));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
  });

  group('getCoordUseCase', () {
    final LatLng latLng = LatLng(-34.56, -72.98);
    test(
        'DEBERIA llamarse el método GetCoordUseCase CUANDO se pasa un evento al Bloc',
        () async {
      // arrange
      when(mockGetCoordUseCase.call(any))
          .thenAnswer((_) async => Right(latLng));
      // act

      arbolesEntityBloc.add(GetCoordEvent());
      await untilCalled(mockGetCoordUseCase.call(any));
      // assert
      verify(mockGetCoordUseCase.call(any));
    });
    test('DEBERIA traer un LatLng CUANDO logra el GPS interno', () async {
      // arrange
      when(mockGetCoordUseCase.call(any))
          .thenAnswer((_) async => Right(latLng));
      // act
      final expected = [
        Empty(),
        Loading(),
        GettedCoord(latLng: latLng),
      ];
      arbolesEntityBloc.add(GetCoordEvent());
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
    test('DEBERIA arrojar un [Error] CUANDO cuando no logra acceder al GPS',
        () async {
      // arrange
      when(mockGetCoordUseCase.call(any))
          .thenAnswer((_) async => Left(CoordFailure()));
      // act
      final expected = [
        Empty(),
        Loading(),
        Error(message: COORD_FAILURE),
      ];
      arbolesEntityBloc.add(GetCoordEvent());
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
  });
  group('comprobarIdNFfcseCase', () {
    final String tIdNFC = "uh387qs123J4";
    test(
        'DEBERIA llamarse el método ComprobarIdNfcUseCase CUANDO se pasa un evento al Bloc',
        () async {
      // arrange
      when(mockComprobarIdNFCUseCase.call(any))
          .thenAnswer((_) async => Right(true));
      // act

      arbolesEntityBloc.add(ComprobarIdNfcEvent(tIdNFC));
      await untilCalled(mockComprobarIdNFCUseCase.call(any));
      // assert
      verify(mockComprobarIdNFCUseCase.call(any));
    });
    test('DEBERIA traer un true CUANDO encuentra el IdNfc en la base de datos',
        () async {
      // arrange
      when(mockComprobarIdNFCUseCase.call(any))
          .thenAnswer((_) async => Right(true));
      // act
      final expected = [
        Empty(),
        Loading(),
        CheckedIdNfc(existe: true),
      ];
      arbolesEntityBloc.add(ComprobarIdNfcEvent(tIdNFC));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });

    test('DEBERIA traer un failure CUANDO no se logra conectar con la BD',
        () async {
      // arrange
      when(mockComprobarIdNFCUseCase.call(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
      arbolesEntityBloc.add(ComprobarIdNfcEvent(tIdNFC));
    });
  });
}
