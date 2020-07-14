import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/lista_de_arboles.dart';
import '../repositories/arbol_repositorio.dart';

class GrabarListaDeArbolesLevantados
    implements UseCase<ListaDeArboles, ParamsGrabar> {
  final ArbolRepositorio repositorio;
  GrabarListaDeArbolesLevantados(this.repositorio);
  @override
  Future<Either<Failure, ListaDeArboles>> call(
    ParamsGrabar params,
  ) async {
    return await repositorio
        .grabarListaDeArbolesLevantados(params.listaDeArboles);
  }
}

class ParamsGrabar extends Equatable {
  final ListaDeArboles listaDeArboles;
  ParamsGrabar({@required this.listaDeArboles}) : super([listaDeArboles]);
}
