import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/data/models/arboles_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/form_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/user_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../entities/arboles_entity.dart';

abstract class ArbolesRepositorio {
  //LISTO: implementado
  Future<Either<Failure, ArbolesEntity>> getArbolesCercanos(
      LatLng coordenadas, int distancia);
  //LISTO: implementado
  Future<Either<Failure, ArbolesEntity>> getArbolPorIdNFC(String idNFC);
  //LISTO: implementado
  Future<Either<Failure, bool>> comprobarIdNFC({String idNFC});
  //LISTO: implementado
  Future<Either<Failure, NfcEntity>> leerIdNfc({String idUsuario});
  //LISTO: implementado
  Future<Either<Failure, LatLng>> getCoordenadas({NoParams params});
  //LISTO: implementado
  Future<Either<Failure, Success>> grabarArboles(
      {ArbolesEntity arboles, int nArbol});
  //LISTO: implementado
  Future<Either<Failure, FormEntity>> getDatosForm({String idUsuario});
  //LISTO: implementado
  Future<Either<Failure, Success>> actualizarDatosForm({NoParams params});
  //LISTO: implementado
  Future<Either<Failure, Success>> crearDatosForm();
//LISTO: implementado
  Future<Either<Failure, Success>> updateArbol(
      {ArbolesEntity arboles, int nArbol});
  Future<Either<Failure, UserEntity>> login({String password, String rut});

  Future<Either<Failure, UserEntity>> getUserInfo({String password});
}
