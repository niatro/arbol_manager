import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arboles_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/leer_idnfc_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockArbolesRepositorio extends Mock implements ArbolesRepositorio {}

void main() {
  MockArbolesRepositorio mockArbolesRepositorio;
  LeerIdNfcUseCase usecase;

  setUp(() {
    mockArbolesRepositorio = MockArbolesRepositorio();
    usecase = LeerIdNfcUseCase(mockArbolesRepositorio);
  });

  final NfcEntity idNFCEntity = NfcEntity(idNfc: "AS4576");
  final String idUsuario = "usuarioPrueba";

  test(
    'DEBERIA  recibir un IdNFCEntity CUANDO se produce la lectura de los datos',
    () async {
      // arrange
      when(mockArbolesRepositorio.leerIdNfc(idUsuario: anyNamed("idUsuario")))
          .thenAnswer((_) async => Right(idNFCEntity));
      // act
      final result = await usecase.call(Params(idUsuario: idUsuario));
      // assert
      expect(result, Right(idNFCEntity));
      verify(mockArbolesRepositorio.leerIdNfc(idUsuario: idUsuario));
      verifyNoMoreInteractions(mockArbolesRepositorio);
    },
  );

  test(
    'DEBERIA  recibir un nfcFailure CUANDO no se pueden leer los datos',
    () async {
      // arrange
      when(mockArbolesRepositorio.leerIdNfc(idUsuario: anyNamed("idUsuario")))
          .thenAnswer((_) async => Left(NfcFailure()));
      // act
      final result = await usecase.call(Params(idUsuario: idUsuario));
      // assert
      expect(result, Left(NfcFailure()));
      verify(mockArbolesRepositorio.leerIdNfc(idUsuario: idUsuario));
      verifyNoMoreInteractions(mockArbolesRepositorio);
    },
  );
}
