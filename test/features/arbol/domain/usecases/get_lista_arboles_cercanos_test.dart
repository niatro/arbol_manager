import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/lista_de_arboles.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arbol_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_lista_arboles_cercanos.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../data/lista_de_arboles_test.dart';

class MockListaArbolRepositorio extends Mock implements ArbolRepositorio {}

void main() {
  ///Abajo van los nombres de las variables que me interesan
  MockListaArbolRepositorio mockListaArbolRepositorio;
  GetListaArbolesCercanos usecase;

  ///Primer método en correr donde inicializo todos los objetos que voy a utilizar
  ///
  setUp(() {
    mockListaArbolRepositorio = MockListaArbolRepositorio();
    usecase = GetListaArbolesCercanos(mockListaArbolRepositorio);
  });
  final coordenadasTest = LatLng(-33.40022111646666, -70.59898554630922);
  final ListaDeArboles listaDeArboles =
      ListaDeArboles.fromJson(listaDeArbolesTest);
  test(
    'debería traer un listado de arboles basado en una reference geográfica todo del repositario',
    () async {
      // arrange
      when(mockListaArbolRepositorio.getListadoArbolesCercanos(any))
          .thenAnswer((_) async => Right(listaDeArboles));
      // act
      final result = await usecase.call(Params(coordenada: coordenadasTest));
      // assert
      expect(result, Right(listaDeArboles));
      verify(
          mockListaArbolRepositorio.getListadoArbolesCercanos(coordenadasTest));
      verifyNoMoreInteractions(mockListaArbolRepositorio);
    },
  );
}
