import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/arboles_entity.dart';
import '../repositories/arboles_repositorio.dart';

@lazySingleton
class GetArbolesCercanosUseCase implements UseCase<ArbolesEntity, Params> {
  final ArbolesRepositorio repositorio;
//api de mysql
  GetArbolesCercanosUseCase(this.repositorio);

  @override
  Future<Either<Failure, ArbolesEntity>> call(
    Params params,
  ) async {
    return await repositorio.getArbolesCercanos(params.coordenada);
  }
}
