import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/arboles_repositorio.dart';

//
@lazySingleton
class ComprobarIdNFCUseCase implements UseCase<bool, Params> {
  final ArbolesRepositorio repositorio;
//api de mysql, se refiere a comprobar que un idNFC leído desde un chip
// esta en la base de datos, por eso el UseCase devolvera un bool,
  ComprobarIdNFCUseCase(this.repositorio);

  @override
  Future<Either<Failure, bool>> call(
    Params params,
  ) async {
    return await repositorio.comprobarIdNFC(idNFC: params.idNFC);
  }
}
