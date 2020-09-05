import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arboles_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_coordenadas_usecase.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';

class MockArbolesReopistorio extends Mock implements ArbolesRepositorio {}

void main() {
  MockArbolesReopistorio mockArbolesRepositorio;
  GetCoordUseCase usecase;

  setUp(() {
    mockArbolesRepositorio = MockArbolesReopistorio();
    usecase = GetCoordUseCase(mockArbolesRepositorio);
  });
  final LatLng tCoordenadas = LatLng(-33.438779, -70.612920);
  test('DEBERIA retornar LatLng CUANDO la lectura del repositorio es exitosa',
      () async {
    // arrange
    when(mockArbolesRepositorio.getCoordenadas(params: anyNamed('params')))
        .thenAnswer((_) async => Right(tCoordenadas));
    // act
    final result = await usecase.call(NoParams());
    // assert
    expect(result, Right(tCoordenadas));
    verify(mockArbolesRepositorio.getCoordenadas(params: NoParams()));
    verifyNoMoreInteractions(mockArbolesRepositorio);
  });
}
