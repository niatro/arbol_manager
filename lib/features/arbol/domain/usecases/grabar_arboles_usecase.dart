import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/success/success.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/arboles_repositorio.dart';

class GrabarArbolUseCase implements UseCase<Success, Params> {
  final ArbolesRepositorio repositorio;
  GrabarArbolUseCase(this.repositorio);
  @override
  Future<Either<Failure, Success>> call(
    Params params,
  ) async {
    return await repositorio.grabarArboles(
        arboles: params.arbolesEntity, nArbol: params.nArbol);
  }
}
