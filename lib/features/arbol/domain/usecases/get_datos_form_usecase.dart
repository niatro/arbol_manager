import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/form_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/arboles_repositorio.dart';

class GetDatosFormUseCase implements UseCase<FormEntity, Params> {
  final ArbolesRepositorio repositorio;
//Aquí revisa en los dispositivos del teléfono y devuelve la coordenada
  GetDatosFormUseCase(this.repositorio);

  @override
  Future<Either<Failure, FormEntity>> call(
    Params params,
  ) async {
    return await repositorio.getDatosFormRepo(idUsuario: params.idUsuario);
  }
}
