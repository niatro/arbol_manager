import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arboles_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/leer_idnfc_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockArbolesRepositorio extends Mock implements ArbolesRepositorio {}

void main() {
  MockArbolesRepositorio mockArbolesRepositorio;
  LeerIdNFCUseCase usecase;

  setUp(() {
    mockArbolesRepositorio = MockArbolesRepositorio();
    usecase = LeerIdNFCUseCase(mockArbolesRepositorio);
  });

  final IdNFCEntity idNFCEntity = IdNFCEntity(idNfc: "AS4576");
  final String idUsuario = "usuarioPrueba";

  test(
    'DEBERIA pasar un idUsuario y recibir un IdNFCEntity',
    () async {
      // arrange
      when(mockArbolesRepositorio.leerIdNFC(idUsuario: anyNamed("idUsuario")))
          .thenAnswer((_) async => Right(idNFCEntity));
      // act
      final result = await usecase.call(Params(idUsuario: idUsuario));
      // assert
      expect(result, Right(idNFCEntity));
      verify(mockArbolesRepositorio.leerIdNFC(idUsuario: idUsuario));
      verifyNoMoreInteractions(mockArbolesRepositorio);
    },
  );
}
