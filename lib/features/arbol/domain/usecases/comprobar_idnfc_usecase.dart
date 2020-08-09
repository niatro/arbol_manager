import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/arboles_repositorio.dart';

class ComprobarIdNFCUseCase implements UseCase<bool, Params> {
  final ArbolesRepositorio repositorio;
//api de mysql
  ComprobarIdNFCUseCase(this.repositorio);

  @override
  Future<Either<Failure, bool>> call(
    Params params,
  ) async {
    return await repositorio.comprobarIdNFC(params.idNFC);
  }
}
