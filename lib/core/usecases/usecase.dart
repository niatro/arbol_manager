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
  final ArbolEntity arbolEntity;
  final int nArbol;
  Params({
    this.idNFC,
    this.idUsuario,
    this.arbolesEntity,
    this.coordenada,
    this.arbolEntity,
    this.nArbol,
  }) : super(
            [idNFC, idUsuario, arbolesEntity, coordenada, arbolEntity, nArbol]);
}