import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/lista_de_arboles.dart';
import '../repositories/arbol_repositorio.dart';

class GrabarListaDeArbolesLevantadosOneByOne
    implements UseCase<bool, ParamsGrabar> {
  final ListaArbolRepositorio repositorio;
  GrabarListaDeArbolesLevantadosOneByOne(this.repositorio);
  @override
  Future<Either<Failure, bool>> call(
    ParamsGrabar params,
  ) async {
    return await repositorio
        .grabarListaDeArbolesLevantadosOneByOne(params.listaDeArboles);
  }
}

class ParamsGrabar extends Equatable {
  final ListaDeArboles listaDeArboles;
  ParamsGrabar({@required this.listaDeArboles}) : super([listaDeArboles]);
}
