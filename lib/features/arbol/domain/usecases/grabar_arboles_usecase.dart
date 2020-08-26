import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/arboles_repositorio.dart';

class GrabarArbolesUseCase implements UseCase<bool, Params> {
  final ArbolesRepositorio repositorio;
  GrabarArbolesUseCase(this.repositorio);
  @override
  Future<Either<Failure, bool>> call(
    Params params,
  ) async {
    return await repositorio.grabarArboles(
        arboles: params.arbolesEntity, nArbol: params.nArbol);
  }
}
