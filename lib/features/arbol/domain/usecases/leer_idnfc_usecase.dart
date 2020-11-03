import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/arboles_repositorio.dart';

class LeerIdNfcUseCase implements UseCase<NfcEntity, Params> {
  final ArbolesRepositorio repositorio;
  LeerIdNfcUseCase(this.repositorio);
  @override
  Future<Either<Failure, NfcEntity>> call(
    Params params,
  ) async {
    return await repositorio.leerIdNfc(idUsuario: params.idUsuario);
  }
}
