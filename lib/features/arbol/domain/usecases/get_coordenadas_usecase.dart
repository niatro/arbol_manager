import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/arboles_repositorio.dart';

class GetCoordUseCase implements UseCase<LatLng, NoParams> {
  final ArbolesRepositorio repositorio;
//Aquí revisa en los dispositivos del teléfono y devuelve la coordenada
  GetCoordUseCase(this.repositorio);

  @override
  Future<Either<Failure, LatLng>> call(
    NoParams params,
  ) async {
    return await repositorio.getCoordenadas(params: NoParams());
  }
}
