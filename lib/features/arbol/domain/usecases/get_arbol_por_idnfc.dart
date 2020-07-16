import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/lista_de_arboles.dart';
import '../../domain/repositories/arbol_repositorio.dart';

class GetArbolPorIdNFC implements UseCase<ListaDeArboles, ParamsIdNFC> {
  final ListaArbolRepositorio repositorio;

  GetArbolPorIdNFC(this.repositorio);

  @override
  Future<Either<Failure, ListaDeArboles>> call(
    ParamsIdNFC params,
  ) async {
    return await repositorio.getArbolPorIdNFC(params.idNFC);
  }
}

class ParamsIdNFC extends Equatable {
  final String idNFC;
  ParamsIdNFC({@required this.idNFC}) : super([idNFC]);
}
