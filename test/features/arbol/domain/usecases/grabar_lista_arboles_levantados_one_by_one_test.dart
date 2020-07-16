import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/lista_de_arboles.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arbol_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/grabar_listado_de_arboles_levantados_one_by_one.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../data/lista_de_arboles_test.dart';

class MockListaArbolRepositorio extends Mock implements ListaArbolRepositorio {}

void main() {
  ///Abajo van los nombres de las variables que me interesan
  MockListaArbolRepositorio mockListaArbolRepositorio;
  GrabarListaDeArbolesLevantadosOneByOne usecase;

  ///Primer método en correr donde inicializo todos los objetos que voy a utilizar
  ///
  setUp(() {
    mockListaArbolRepositorio = MockListaArbolRepositorio();
    usecase = GrabarListaDeArbolesLevantadosOneByOne(mockListaArbolRepositorio);
  });

  final ListaDeArboles listaDeArboles =
      ListaDeArboles.fromJson(listaDeArbolesTest);
  final bool existe = true;
  test(
    'debería pasar un listado de arboles al repositorio para luego grabarlo en BD, una vez operación se ha realizado debería devolver un true',
    () async {
      // arrange
      when(mockListaArbolRepositorio
              .grabarListaDeArbolesLevantadosOneByOne(any))
          .thenAnswer((_) async => Right(existe));
      // act
      final result =
          await usecase.call(ParamsGrabar(listaDeArboles: listaDeArboles));
      // assert
      expect(result, Right(existe));
      verify(mockListaArbolRepositorio
          .grabarListaDeArbolesLevantadosOneByOne(listaDeArboles));
      verifyNoMoreInteractions(mockListaArbolRepositorio);
    },
  );
}
