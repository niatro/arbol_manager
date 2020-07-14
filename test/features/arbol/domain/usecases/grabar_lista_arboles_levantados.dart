import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/lista_de_arboles.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arbol_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/grabar_listado_de_arboles_levantados.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../data/lista_de_arboles_test.dart';

class MockListaArbolRepositorio extends Mock implements ArbolRepositorio {}

class Exito implements Success {
  @override
  // TODO: implement props
  List get props => throw UnimplementedError();
}

void main() {
  ///Abajo van los nombres de las variables que me interesan
  MockListaArbolRepositorio mockListaArbolRepositorio;
  GrabarListaDeArbolesLevantados usecase;

  ///Primer método en correr donde inicializo todos los objetos que voy a utilizar
  ///
  setUp(() {
    mockListaArbolRepositorio = MockListaArbolRepositorio();
    usecase = GrabarListaDeArbolesLevantados(mockListaArbolRepositorio);
  });
  final Exito exito = Exito();

  final ListaDeArboles listaDeArboles =
      ListaDeArboles.fromJson(listaDeArbolesTest);
  test(
    'debería pasar un listado de arboles al repositorio para luego grabarlo en BD',
    () async {
      // arrange
      when(mockListaArbolRepositorio.grabarListaDeArbolesLevantados(any))
          .thenAnswer((_) async => Right(listaDeArboles));
      // act
      final result =
          await usecase.call(ParamsGrabar(listaDeArboles: listaDeArboles));
      // assert
      expect(result, Right(listaDeArboles));
      verify(mockListaArbolRepositorio
          .grabarListaDeArbolesLevantados(listaDeArboles));
      verifyNoMoreInteractions(mockListaArbolRepositorio);
    },
  );
}
