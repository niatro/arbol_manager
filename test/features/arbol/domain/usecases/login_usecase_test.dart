import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapparbol/core/constants/usuario_test.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/user_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arboles_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/login_usecase.dart';
import 'package:mockito/mockito.dart';

class MockArbolesRepositorio extends Mock implements ArbolesRepositorio {}

void main() {
  MockArbolesRepositorio mockArbolesRepositorio;
  LoginUseCase usecase;

  setUp(() {
    mockArbolesRepositorio = MockArbolesRepositorio();
    usecase = LoginUseCase(mockArbolesRepositorio);
  });
  final UserEntity usuarioTest = usuarioUno;
  final String password = '12345';

  test(
      'DEBERIA recibir un usuario CUANDO se invoca la lectura en el repositorio',
      () async {
    // arrange
    when(mockArbolesRepositorio.login(
            password: anyNamed("password"), rut: anyNamed("rut")))
        .thenAnswer((_) async => Right(usuarioTest));
    // act
    final result = await usecase
        .call(Params(password: password, rut: usuarioTest.rutUsuario));
    // assert
    expect(result, Right(usuarioTest));
    verify(mockArbolesRepositorio.login(
        password: password, rut: usuarioTest.rutUsuario));
    verifyNoMoreInteractions(mockArbolesRepositorio);
  });
  test(
      'DEBERIA entregarme un valor FailurePassword CUANDO la clave mo esta registrada en la BD',
      () async {
    // arrange
    when(mockArbolesRepositorio.login(
            password: anyNamed("password"), rut: anyNamed("rut")))
        .thenAnswer((_) async => Left(PassNoExisteFailure()));
    // act
    final result = await usecase
        .call(Params(password: password, rut: usuarioTest.rutUsuario));
    // assert
    expect(result, Left(PassNoExisteFailure()));
    verify(mockArbolesRepositorio.login(
        password: password, rut: usuarioTest.rutUsuario));
    verifyNoMoreInteractions(mockArbolesRepositorio);
  });

  test(
      'DEBERIA entregarme un valor FailureConexion CUANDO no hay acceso a la red',
      () async {
    // arrange
    when(mockArbolesRepositorio.login(
            password: anyNamed("password"), rut: anyNamed("rut")))
        .thenAnswer((_) async => Left(ConexionFailure()));
    // act
    final result = await usecase
        .call(Params(password: password, rut: usuarioTest.rutUsuario));
    // assert
    expect(result, Left(ConexionFailure()));
    verify(mockArbolesRepositorio.login(
        password: password, rut: usuarioTest.rutUsuario));
    verifyNoMoreInteractions(mockArbolesRepositorio);
  });

  test(
      'DEBERIA entregarme un valor ServerFailure CUANDO no se pudo conectar con el servidor',
      () async {
    // arrange
    when(mockArbolesRepositorio.login(
            password: anyNamed("password"), rut: anyNamed("rut")))
        .thenAnswer((_) async => Left(ServerFailure()));
    // act
    final result = await usecase
        .call(Params(password: password, rut: usuarioTest.rutUsuario));
    // assert
    expect(result, Left(ServerFailure()));
    verify(mockArbolesRepositorio.login(
        password: password, rut: usuarioTest.rutUsuario));
    verifyNoMoreInteractions(mockArbolesRepositorio);
  });
}
