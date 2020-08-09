import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/arboles_entity.dart';
import '../../domain/repositories/arboles_repositorio.dart';

class GetArbolPorIdNFCUseCase implements UseCase<ArbolesEntity, Params> {
  final ArbolesRepositorio repositorio;

  GetArbolPorIdNFCUseCase(this.repositorio);

  @override
  Future<Either<Failure, ArbolesEntity>> call(
    Params params,
  ) async {
    return await repositorio.getArbolPorIdNFC(params.idNFC);
  }
}
