import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/arboles_repositorio.dart';

class LeerIdNFCUseCase implements UseCase<IdNFCEntity, Params> {
  final ArbolesRepositorio repositorio;
  LeerIdNFCUseCase(this.repositorio);
  @override
  Future<Either<Failure, IdNFCEntity>> call(
    Params params,
  ) async {
    return await repositorio.leerIdNFC(idUsuario: params.idUsuario);
  }
}
