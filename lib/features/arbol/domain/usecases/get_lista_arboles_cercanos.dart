import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/lista_de_arboles.dart';
import '../repositories/arbol_repositorio.dart';

class GetListaArbolesCercanos implements UseCase<ListaDeArboles, Params> {
  final ListaArbolRepositorio repositorio;
//api de mysql
  GetListaArbolesCercanos(this.repositorio);

  @override
  Future<Either<Failure, ListaDeArboles>> call(
    Params params,
  ) async {
    return await repositorio.getListadoArbolesCercanos(params.coordenada);
  }
}

class Params extends Equatable {
  final LatLng coordenada;
  Params({@required this.coordenada}) : super([coordenada]);
}
