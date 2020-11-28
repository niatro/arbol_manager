import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapparbol/core/constants/form_entity_test.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arboles_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_datos_form_usecase.dart';
import 'package:mockito/mockito.dart';

class MockArbolesReopistorio extends Mock implements ArbolesRepositorio {}

void main() {
  MockArbolesReopistorio mockArbolesRepositorio;
  //OJO: estamos testeando un UseCase, los parámetros entran del repositorio
  GetDatosFormUseCase usecase;
  setUp(() {
    mockArbolesRepositorio = MockArbolesReopistorio();
    usecase = GetDatosFormUseCase(mockArbolesRepositorio);
  });

  final String idUsuario = 'AO65303ns2';

  test(
      'DEBERIA entregar un GrabarSuccess CUANDO se actualizan los datos llamados desde el UseCase',
      () async {
    // arrange
    when(mockArbolesRepositorio.getDatosForm(idUsuario: anyNamed('idUsuario')))
        .thenAnswer((_) async => Right(formTest));
    // act
    final result = await usecase.call(Params(idUsuario: idUsuario));
    // assert
    expect(result, Right(formTest));
    verify(mockArbolesRepositorio.getDatosForm(idUsuario: idUsuario));
    verifyNoMoreInteractions(mockArbolesRepositorio);
  });
  test(
      'DEBERIA entregar un Failure en lectura de la BD CUANDO no se actualizan los datos llamados desde el UseCase',
      () async {
    // arrange
    when(mockArbolesRepositorio.getDatosForm(idUsuario: anyNamed('idUsuario')))
        .thenAnswer((_) async => Left(LocalDataBaseFailure()));
    // act
    final result = await usecase.call(Params(idUsuario: idUsuario));
    // assert
    expect(result, Left(LocalDataBaseFailure()));
    verify(mockArbolesRepositorio.getDatosForm(idUsuario: idUsuario));
    verifyNoMoreInteractions(mockArbolesRepositorio);
  });
}
