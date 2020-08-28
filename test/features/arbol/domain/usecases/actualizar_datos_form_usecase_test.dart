import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arboles_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/actualizar_datos_form_usecase.dart';
import 'package:mockito/mockito.dart';

class MockArbolesReopistorio extends Mock implements ArbolesRepositorio {}

void main() {
  MockArbolesReopistorio mockArbolesRepositorio;
  //OJO: estamos testeando un UseCase, los parámetros entran del repositorio
  ActualizarDatosFormUseCase usecase;
  setUp(() {
    mockArbolesRepositorio = MockArbolesReopistorio();
    usecase = ActualizarDatosFormUseCase(mockArbolesRepositorio);
  });

  final String idNFC = '54sue93G80HAT';
  final String idUsuario = 'AO65303ns2';

  test(
      'DEBERIA entregar un GrabarSuccess CUANDO se actualizan los datos llamados desde el UseCase',
      () async {
    // arrange
    when(mockArbolesRepositorio.actualizarDatosForm(
            idUsuario: anyNamed('idUsuario')))
        .thenAnswer((_) async => Right(SqfliteGrabarSuccess()));
    // act
    final result = await usecase.call(Params(idUsuario: idUsuario));
    // assert
    expect(result, Right(SqfliteGrabarSuccess()));
    verify(mockArbolesRepositorio.actualizarDatosForm(idUsuario: idUsuario));
    verifyNoMoreInteractions(mockArbolesRepositorio);
  });
  test(
      'DEBERIA entregar un Failure CUANDO no se actualizan los datos llamados desde el UseCase',
      () async {
    // arrange
    when(mockArbolesRepositorio.actualizarDatosForm(
            idUsuario: anyNamed('idUsuario')))
        .thenAnswer((_) async => Left(LocalDataBaseFailure()));
    // act
    final result = await usecase.call(Params(idUsuario: idUsuario));
    // assert
    expect(result, Left(LocalDataBaseFailure()));
    verify(mockArbolesRepositorio.actualizarDatosForm(idUsuario: idUsuario));
    verifyNoMoreInteractions(mockArbolesRepositorio);
  });
}
