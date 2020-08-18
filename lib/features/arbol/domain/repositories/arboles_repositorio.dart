import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/error/failure.dart';
import '../entities/arboles_entity.dart';

abstract class ArbolesRepositorio {
  Future<Either<Failure, ArbolesEntity>> getArbolesCercanos(LatLng coordenadas);
  Future<Either<Failure, bool>> grabarArboles(ArbolesEntity arboles);
  Future<Either<Failure, bool>> comprobarIdNFC(String idNFC);
  //OJO: Falta implementar y testear las caracteristicas abajo
  Future<Either<Failure, ArbolesEntity>> getArbolPorIdNFC(String idNFC);

  // Este contrato no ha sido testeado pero me da la impresion que no deber
  //ia ser un UseCase, debería activarse a nivel de modelo cuando esta acce
  //diendo a una data específica
  Future<Either<Failure, IdNFCEntity>> fromChipReadAndGetIdNFC(
      String idUsuario);

  Future<Either<Failure, LatLng>> getCoordenadas(String idUsuario);

// Los métodos abajo deberían ir en el layer de presentación
/*Future<Either<Failure, Success>> agregarArbolPorNFC(String idNFC);
  Future<Either<Failure, Success>> agregarArbolPorMapa(String idRandomNFC);
  Future<Either<Failure, Success>> editarArbolConNFC(int idArbol);
  Future<Either<Failure, Success>> editarArbolPorMapa(int idArbol);*/
}
