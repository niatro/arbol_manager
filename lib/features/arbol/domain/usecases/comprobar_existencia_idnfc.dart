import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/arbol_repositorio.dart';

class ComprobarExistenciaIdNFC implements UseCase<bool, ParamsIdNFC> {
  final ListaArbolRepositorio repositorio;
//api de mysql
  ComprobarExistenciaIdNFC(this.repositorio);

  @override
  Future<Either<Failure, bool>> call(
    ParamsIdNFC params,
  ) async {
    return await repositorio.comprobarExistenciaIdNFC(params.idNFC);
  }
}

class ParamsIdNFC extends Equatable {
  final String idNFC;
  ParamsIdNFC({@required this.idNFC}) : super([idNFC]);
}
