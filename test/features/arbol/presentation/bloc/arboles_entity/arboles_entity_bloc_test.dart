import 'package:flutterapparbol/core/constants/usuario_test.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/core/util/input_converter.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
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

class MockLeerIdNFCUseCase extends Mock implements LeerIdNFCUseCase {}

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
  MockLeerIdNFCUseCase mockLeerIdNFCUseCase;
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
    mockLeerIdNFCUseCase = MockLeerIdNFCUseCase();
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
        leerIdNFCUseCase: mockLeerIdNFCUseCase,
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

    test('''DEBERIA llamar al InputConverter para validar y convertir
        el String en un unsigned LatLong que nos servira para
        buscar los arboles cercanos''', () async {
      // arrange
      setUpinputCoverterSuccess();

      // act
      arbolesEntityBloc
          .dispatch(GetArbolesEntityCercanosEvent(tCoordenadasStr));
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
      arbolesEntityBloc
          .dispatch(GetArbolesEntityCercanosEvent(tCoordenadasStr));
//      await untilCalled(mockInputConverter.stringToUnsignedLatLng(any));
    });
    test('DEBERIA emitir data de un CUANDO tenemos llega un UseCase Success',
        () async {
      // arrange
      setUpinputCoverterSuccess();
      when(mockGetArbolesCercanosUseCase(any))
          .thenAnswer((_) async => Right(tArbolesEntity));
      // act
      arbolesEntityBloc
          .dispatch(GetArbolesEntityCercanosEvent(tCoordenadasStr));
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
        Loaded(arboles: tArbolesEntity),
      ];
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
      //
      arbolesEntityBloc
          .dispatch(GetArbolesEntityCercanosEvent(tCoordenadasStr));
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
      arbolesEntityBloc
          .dispatch(GetArbolesEntityCercanosEvent(tCoordenadasStr));
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
      arbolesEntityBloc
          .dispatch(GetArbolesEntityCercanosEvent(tCoordenadasStr));
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
      setUpinputCoverterFromIdNFCToStrSuccess();
      when(mockGetArbolPorIdNFCUseCase(any))
          .thenAnswer((_) async => Right(tArbolesEntity));
      // act
      arbolesEntityBloc.dispatch(GetArbolesEntityPorIdNFCEvent(tIdNFC));
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
        Loaded(arboles: tArbolesEntity),
      ];
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
      //
      arbolesEntityBloc.dispatch(GetArbolesEntityPorIdNFCEvent(tIdNFC));
    });
    test('DEBERIA emitir [Loading, Error] cuando la data no pudo ser colectada',
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
      arbolesEntityBloc.dispatch(GetArbolesEntityPorIdNFCEvent(tIdNFC));
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
      arbolesEntityBloc.dispatch(GetArbolesEntityPorIdNFCEvent(tIdNFC));
    });
  });
  group('GrabarArboles Event', () {
    final ArbolesEntity tArbolesEntity =
        ArbolesEntity(listaArbolEntity: [arbolUno, arbolDos]);
    final bool respuesta = true;
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
      arbolesEntityBloc.dispatch(GrabarArbolEvent(tArbolesEntity, 1));

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
      arbolesEntityBloc.dispatch(GrabarArbolEvent(tArbolesEntity, 1));
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
        Error(message: INVALID_NFC_FAILURE_MESSAGE),
      ];
      // act
      arbolesEntityBloc.dispatch(GrabarArbolEvent(tArbolesEntity, 1));
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
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      // act
      arbolesEntityBloc.dispatch(GrabarArbolEvent(tArbolesEntity, 1));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
  });
  group('UpdateArbol Event', () {
    final ArbolesEntity tArbolesEntity =
        ArbolesEntity(listaArbolEntity: [arbolUno, arbolDos]);
    test('''DEBERIA tomar un arbol previamente seleccionado de la base de datos
    y hacer un Update CUANDO se gatille
    el evento de actualizar''', () async {
      // arrange
      when(mockUpdateArbolesUseCase.call(any))
          .thenAnswer((_) async => Right(ServerUpdateSuccess()));
      final expected = [
        Empty(),
        UpdatingArbol(),
        UpdatedArbol(success: ServerUpdateSuccess()),
      ];
      // act
      arbolesEntityBloc.dispatch(UpdateArbolEvent(tArbolesEntity, 1));

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
        UpdatingArbol(),
        Error(message: CONEXION_FAILURE_MESSAGE),
      ];
      // act
      arbolesEntityBloc.dispatch(UpdateArbolEvent(tArbolesEntity, 1));
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
        UpdatingArbol(),
        Error(message: UPDATE_NFC_FAILURE_MESSAGE),
      ];
      // act
      arbolesEntityBloc.dispatch(UpdateArbolEvent(tArbolesEntity, 1));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });

    test('DEBERIA emitir un [error] CUANDO no se puede actualizar ', () async {
      // arrange
      when(mockUpdateArbolesUseCase(any))
          .thenAnswer((_) async => Left(ServerUpdateFailure()));
      final expected = [
        Empty(),
        UpdatingArbol(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      // act
      arbolesEntityBloc.dispatch(UpdateArbolEvent(tArbolesEntity, 1));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
  });
  group('ActualizarDatosForm Event', () {
    UserEntity usuario = usuarioUno;
    test('DEBERIA dar un success CUANDO la data sql se puede actualizar',
        () async {
      // arrange
      when(mockActualizarDatosFormUseCase.call(any))
          .thenAnswer((_) async => Right(ServerActualizarFormSuccess()));
      // act
      final expected = [
        Empty(),
        UpdatingForm(),
        UpdatedForm(success: ServerActualizarFormSuccess()),
      ];
      arbolesEntityBloc.dispatch(ActualizarFormEvent(usuario));
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
        UpdatingForm(),
        Error(message: CONEXION_FAILURE_MESSAGE),
      ];
      // act
      arbolesEntityBloc.dispatch(ActualizarFormEvent(usuario));
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
        UpdatingForm(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      // act
      arbolesEntityBloc.dispatch(ActualizarFormEvent(usuario));
      // assert
      expectLater(arbolesEntityBloc.state, emitsInOrder(expected));
    });
  });
  group('GetDatosForm Event', () {});
  group('LoginUseCase Event', () {});
  group('LeerIdNFCUseCase Event', () {});
  group('getCoordUseCase', () {});
  group('getIdNFCUseCase', () {});
}
