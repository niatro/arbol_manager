import 'package:flutterapparbol/core/error/failure.dart';
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

import '../../../data/lista_de_arboles_test.dart';

class MockGetArbolesCercanos extends Mock implements GetArbolesCercanosUseCase {
}

class MockGetArbolPorIdNFC extends Mock implements GetArbolPorIdNFCUseCase {}

class MockGrabarArbolesLevantadosOneByOne extends Mock
    implements GrabarArbolesUseCase {}

class MockComprobarExistenciaIdNFC extends Mock
    implements ComprobarIdNFCUseCase {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  MockGetArbolesCercanos mockGetArbolesCercanos;
  MockGetArbolPorIdNFC mockGetArbolPorIdNFC;
  MockGrabarArbolesLevantadosOneByOne mockGrabarArbolesLevantadosOneByOne;
  MockComprobarExistenciaIdNFC mockComprobarExistenciaIdNFC;
  MockInputConverter mockInputConverter;
  ArbolesEntityBloc arbolesEntityBloc;

  setUp(() {
    mockGetArbolesCercanos = MockGetArbolesCercanos();
    mockGetArbolPorIdNFC = MockGetArbolPorIdNFC();
    mockGrabarArbolesLevantadosOneByOne = MockGrabarArbolesLevantadosOneByOne();
    mockComprobarExistenciaIdNFC = MockComprobarExistenciaIdNFC();
    mockInputConverter = MockInputConverter();
    arbolesEntityBloc = ArbolesEntityBloc(
        arbolesCercanosUseCase: mockGetArbolesCercanos,
        grabarArbolesUseCase: mockGrabarArbolesLevantadosOneByOne,
        comprobarIdNFCUseCase: mockComprobarExistenciaIdNFC,
        arbolPorIdNFCUseCase: mockGetArbolPorIdNFC,
        inputConverter: mockInputConverter);
  });

  test('DEBERIA emitir un estado inicial de empty', () async {
    // assert
    expect(arbolesEntityBloc.initialState, Empty());
  });
  group('GetArbolesCercanos Event es lo primero que probamos', () {
    final String tCoordenadasStr = "-33.398827188275405,-70.59860965002224";
    final LatLng tCoordenadasParseada =
        LatLng(-33.398827188275405, -70.59860965002224);
    final ArbolesEntity arbolesEntity =
        ArbolesEntity(listaArbolEntity: [arbolUno, arbolDos]);
    test(
        '''DEBERIA llamar al InputConverter para validar y convertir'''
        '''el String en un unsigned LatLong''', () async {
      // arrange
      when(mockInputConverter.stringToUnsignedLatLng(any))
          .thenReturn(Right(tCoordenadasParseada));
      // act
      arbolesEntityBloc
          .dispatch(GetArbolesEntityCercanosPorCoordenada(tCoordenadasStr));
      await untilCalled(mockInputConverter.stringToUnsignedLatLng(any));

      // assert
      verify(mockInputConverter.stringToUnsignedLatLng(tCoordenadasStr));
    });
    test('DEBERIA emitir [Error] CUANDO el input es valido', () async {
      // arrange
      when(mockInputConverter.stringToUnsignedLatLng(any))
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
          .dispatch(GetArbolesEntityCercanosPorCoordenada(tCoordenadasStr));
//      await untilCalled(mockInputConverter.stringToUnsignedLatLng(any));
    });
  });
}
