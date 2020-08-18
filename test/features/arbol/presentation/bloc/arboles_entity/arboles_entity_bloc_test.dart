import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/core/util/input_converter.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/comprobar_idnfc_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_arbol_por_idnfc_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_arboles_cercanos_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/grabar_arboles_usecase.dart';
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

class MockGrabarArbolesUseCase extends Mock implements GrabarArbolesUseCase {}

class MockComprobarIdNFCUseCase extends Mock implements ComprobarIdNFCUseCase {}

class MockInputConverterStrToLatLng extends Mock
    implements InputConverterStrToLatLng {}

class MockInputConverterFromIdNFCToStr extends Mock
    implements InputConverterIdNFCToStr {}

void main() {
  MockGetArbolesCercanosUseCase mockGetArbolesCercanosUseCase;
  MockGetArbolPorIdNFCUseCase mockGetArbolPorIdNFCUseCase;
  MockGrabarArbolesUseCase mockGrabarArbolesUseCase;
  MockComprobarIdNFCUseCase mockComprobarIdNFCUseCase;
  MockInputConverterStrToLatLng mockInputConverter;
  MockInputConverterFromIdNFCToStr mockInputConverterFromIdNFCToStr;
  ArbolesEntityBloc arbolesEntityBloc;

  setUp(() {
    mockGetArbolesCercanosUseCase = MockGetArbolesCercanosUseCase();
    mockGetArbolPorIdNFCUseCase = MockGetArbolPorIdNFCUseCase();
    mockGrabarArbolesUseCase = MockGrabarArbolesUseCase();
    mockComprobarIdNFCUseCase = MockComprobarIdNFCUseCase();
    mockInputConverter = MockInputConverterStrToLatLng();
    mockInputConverterFromIdNFCToStr = MockInputConverterFromIdNFCToStr();
    arbolesEntityBloc = ArbolesEntityBloc(
        arbolesCercanosUseCase: mockGetArbolesCercanosUseCase,
        grabarArbolesUseCase: mockGrabarArbolesUseCase,
        comprobarIdNFCUseCase: mockComprobarIdNFCUseCase,
        arbolPorIdNFCUseCase: mockGetArbolPorIdNFCUseCase,
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

    test(
        '''DEBERIA llamar al InputConverter para validar y convertir'''
        '''el String en un unsigned LatLong''', () async {
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
}
