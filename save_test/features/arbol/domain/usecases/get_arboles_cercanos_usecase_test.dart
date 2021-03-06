import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arboles_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_arboles_cercanos_usecase.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/core/constants/lista_de_arboles_test.dart';

class MockListaArbolRepositorio extends Mock implements ArbolesRepositorio {}

void main() {
  ///Abajo van los nombres de las variables que me interesan
  MockListaArbolRepositorio mockListaArbolRepositorio;
  GetArbolesCercanosUseCase usecase;

  ///Primer método en correr donde inicializo todos los objetos que voy a utilizar
  ///
  setUp(() {
    mockListaArbolRepositorio = MockListaArbolRepositorio();
    usecase = GetArbolesCercanosUseCase(mockListaArbolRepositorio);
  });
  final coordenadasTest = LatLng(-33.40022111646666, -70.59898554630922);
  final int distancia = 30;
  final ArbolesEntity tListaDeArbolesEntity = arbolesEntityTest;
  ServerFailure falloServidor = ServerFailure();

  test(
    'debería traer un listado de arboles basado en una reference geográfica del repositario',
    () async {
      // arrange
      when(mockListaArbolRepositorio.getArbolesCercanos(any, any))
          .thenAnswer((_) async => Right(tListaDeArbolesEntity));
      // act
      final result = await usecase
          .call(Params(coordenada: coordenadasTest, distancia: distancia));
      // assert
      expect(result, Right(tListaDeArbolesEntity));
      verify(mockListaArbolRepositorio.getArbolesCercanos(
          coordenadasTest, distancia));
      verifyNoMoreInteractions(mockListaArbolRepositorio);
    },
  );
  test(
    'debería traer un Failure cuando no pudo conseguir los arboles',
    () async {
      // arrange
      when(mockListaArbolRepositorio.getArbolesCercanos(any, any))
          .thenAnswer((_) async => Left(falloServidor));
      // act
      final result = await usecase
          .call(Params(coordenada: coordenadasTest, distancia: distancia));
      // assert
      expect(result, Left(falloServidor));
      verify(mockListaArbolRepositorio.getArbolesCercanos(
          coordenadasTest, distancia));
      verifyNoMoreInteractions(mockListaArbolRepositorio);
    },
  );
}
