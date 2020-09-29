import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/form_local_source_sql.dart';
import 'package:flutterapparbol/features/arbol/data/models/form_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/form_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/arboles_entity.dart';
import '../../domain/repositories/arboles_repositorio.dart';
import '../datasources/arboles_local_data_source.dart';
import '../datasources/arboles_remote_data_source.dart';

typedef Future<ArbolesEntity> _ArbolesEntityPorCoordOIdNFC();
typedef Future<IdNFCEntity> _LecturaChip();
typedef Future<FormEntity> _FormEntityPorActualizacion();

class ArbolesRepositorioImpl implements ArbolesRepositorio {
  final ArbolesRemoteDataSource remoteDataSource;
  final ArbolesLocalDataSource localDatasource;
  final FormLocalSourceSql sqlDataSource;
  final NetworkInfo netWorkInfo;

  ArbolesRepositorioImpl({
    @required this.remoteDataSource,
    @required this.localDatasource,
    @required this.netWorkInfo,
    @required this.sqlDataSource,
  });
  @override
  Future<Either<Failure, ArbolesEntity>> getArbolPorIdNFC(String idNFC) async {
    return await _getArbolesEntity(() {
      return remoteDataSource.getArbolPorIdNFCRemoteData(idNFC: idNFC);
    });
  }

  @override
  Future<Either<Failure, ArbolesEntity>> getArbolesCercanos(
      LatLng coordenadas) async {
    return await _getArbolesEntity(() {
      return remoteDataSource.getArbolesCercanosRemoteData(
          coordenadas: coordenadas);
    });
  }

  @override
  Future<Either<Failure, bool>> comprobarIdNFC({String idNFC}) async {
    // TODO: implement comprobarExistenciaIdNFC
    try {
      bool verdaderoOfalso =
          await remoteDataSource.verificarIdNFCRemoteData(idNFC: idNFC);
      return Right(verdaderoOfalso);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, IdNFCEntity>> leerIdNFC({String idUsuario}) async {
    // TODO: implement fromChipReadAndGetIdNFC
    try {
      String idNFC =
          await localDatasource.leerIdNFCLocalData(idUsuario: idUsuario);
      final IdNFCEntity idNFCEntity = IdNFCEntity(idNfc: idNFC);
      return Right(idNFCEntity);
    } on NfcException {
      return Left(NfcFailure());
    }
  }

  @override
  Future<Either<Failure, ServerGrabarSuccess>> grabarArboles(
      {ArbolesEntity arboles, int nArbol}) async {
    if (await netWorkInfo.isConnected) {
      try {
        bool verificado = await remoteDataSource.verificarIdNFCRemoteData(
            idNFC: arboles.listaArbolEntity[nArbol].guiArbol);
        if (verificado == false) {
          bool grabadoSioNo = await remoteDataSource.grabarArboleRemoteData(
              arbol: arboles.listaArbolEntity[nArbol]);
          if (grabadoSioNo == true) {
            arboles.listaArbolEntity.removeAt(nArbol);
            return Right(ServerGrabarSuccess());
          } else {
            return Left(ServerFailureGrabando());
          }
        } else {
          return Left(IdNfcNoGrabaYaExisteFailure());
        }
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, ServerActualizarFormSuccess>> actualizarDatosForm(
      {String idUsuario}) async {
    if (await netWorkInfo.isConnected) {
      bool result = await remoteDataSource.actualizarBaseDatosFormularios();
      if (result == true) {
        return Right(ServerActualizarFormSuccess());
      } else {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConexionFailure());
    }
  }

//OJO: TDD Realizado
  @override
  Future<Either<Failure, FormEntity>> getDatosForm({String idUsuario}) async {
    try {
      final result = await sqlDataSource.getDatosFormSql(idUsuario: idUsuario);
      return Right(result);
    } on DataBaseException {
      return Left(DataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, Success>> crearDatosForm() {
    // TODO: implement crearDatosForm
    throw UnimplementedError();
  }

  Future<Either<Failure, ArbolesEntity>> _getArbolesEntity(
    _ArbolesEntityPorCoordOIdNFC getArbolesPrometidosPorCoordenadasOIdNFC,
  ) async {
    if (await netWorkInfo.isConnected) {
      try {
        final arbolesEntity = await getArbolesPrometidosPorCoordenadasOIdNFC();
        localDatasource.cacheArbEntDeArbEntModLocalData(arbolesEntity);
        return Right(arbolesEntity);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final arbolesLocales = await localDatasource.getCacheArbolesLocalData();
        return Right(arbolesLocales);
      } on CacheException {
        return Left(CacheFailure());
        // el retorno llena el lado izquierdo del Either que produce
        // el método getArbolesCercanos
      }
    }
  }

  @override
  Future<Either<Failure, LatLng>> getCoordenadas({NoParams params}) async {
    // TODO: implement getCoordenadas
    try {
      Position posicion = await localDatasource.getCoordenadasLocalData();
      LatLng latlong = LatLng(posicion.latitude, posicion.longitude);
      return Right(latlong);
    } on LocationException {
      return (Left(LocalGpsFailure()));
    }
  }
}
