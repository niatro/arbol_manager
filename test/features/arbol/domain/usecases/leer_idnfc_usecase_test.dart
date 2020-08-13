import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arboles_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/grabar_arboles_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/leer_idnfc_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/core/constants/lista_de_arboles_test.dart';

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
      when(mockArbolesRepositorio.fromChipReadAndGetIdNFC(any))
          .thenAnswer((_) async => Right(idNFCEntity));
      // act
      final result = await usecase.call(Params(idUsuario: idUsuario));
      // assert
      expect(result, Right(idNFCEntity));
      verify(mockArbolesRepositorio.fromChipReadAndGetIdNFC(idUsuario));
      verifyNoMoreInteractions(mockArbolesRepositorio);
    },
  );
}
