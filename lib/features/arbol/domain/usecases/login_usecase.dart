import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/user_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/arboles_repositorio.dart';

class LoginUseCase implements UseCase<UserEntity, Params> {
  final ArbolesRepositorio repositorio;
  LoginUseCase(this.repositorio);
  @override
  Future<Either<Failure, UserEntity>> call(
    Params params,
  ) async {
    return await repositorio.login(
        password: params.password, rut: params.usuario.rut);
  }
}
