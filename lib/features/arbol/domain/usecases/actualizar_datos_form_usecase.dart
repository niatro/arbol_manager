import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/form_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/arboles_repositorio.dart';

class ActualizarDatosFormUseCase implements UseCase<Success, NoParams> {
  final ArbolesRepositorio repositorio;
//Aquí revisa en los dispositivos del teléfono y devuelve la coordenada
  ActualizarDatosFormUseCase(this.repositorio);

  @override
  Future<Either<Failure, Success>> call(
    NoParams params,
  ) async {
    return await repositorio.actualizarDatosForm(params: NoParams());
  }
}
