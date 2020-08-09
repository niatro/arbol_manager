import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {}

class Params extends Equatable {
  final String idNFC;
  final String idUsuario;
  final ArbolesEntity arbolesEntity;
  final LatLng coordenada;
  Params({
    this.idNFC,
    this.idUsuario,
    this.arbolesEntity,
    this.coordenada,
  }) : super([idNFC, idUsuario, arbolesEntity, coordenada]);
}
