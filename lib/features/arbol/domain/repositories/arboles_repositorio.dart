import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/features/arbol/data/models/arboles_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/form_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/error/failure.dart';
import '../entities/arboles_entity.dart';

abstract class ArbolesRepositorio {
  Future<Either<Failure, ArbolesEntity>> getArbolesCercanos(LatLng coordenadas);
  Future<Either<Failure, ArbolesEntity>> getArbolPorIdNFC(String idNFC);
  Future<Either<Failure, bool>> comprobarIdNFC({String idNFC});

  //OJO: Falta implementar y testear las caracteristicas abajo
  Future<Either<Failure, IdNFCEntity>> leerIdNFC({String idUsuario});
  Future<Either<Failure, LatLng>> getCoordenadas(String idUsuario);
  Future<Either<Failure, Success>> grabarArboles(
      {ArbolesEntity arboles, int nArbol});
  Future<Either<Failure, FormEntity>> getDatosFormRepo({String idUsuario});
  Future<Either<Failure, Success>> actualizarDatosForm({String idUsuario});

// Los métodos abajo deberían ir en el layer de presentación
/*Future<Either<Failure, Success>> agregarArbolPorNFC(String idNFC);
  Future<Either<Failure, Success>> agregarArbolPorMapa(String idRandomNFC);
  Future<Either<Failure, Success>> editarArbolConNFC(int idArbol);
  Future<Either<Failure, Success>> editarArbolPorMapa(int idArbol);*/
}
