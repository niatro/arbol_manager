import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/user_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/arboles_repositorio.dart';

class GetUserInfo implements UseCase<UserEntity, Params> {
  final ArbolesRepositorio repositorio;
  GetUserInfo(this.repositorio);
  @override
  Future<Either<Failure, UserEntity>> call(
    Params params,
  ) async {
    return await repositorio.getUserInfo(password: params.password);
  }
}
