import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';
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

class ArbolesRepositorioImpl implements ArbolesRepositorio {
  final ArbolesRemoteDataSource remoteDataSource;
  final ArbolesLocalDataSource localDatasource;
  final NetworkInfo netWorkInfo;

  ArbolesRepositorioImpl({
    @required this.remoteDataSource,
    @required this.localDatasource,
    @required this.netWorkInfo,
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
    return Right(true);
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
  Future<Either<Failure, bool>> grabarArboles(ArbolesEntity arboles) {
    // TODO: implement grabarArbolesLevantadosOneByOne
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
  Future<Either<Failure, LatLng>> getCoordenadas(String idUsuario) {
    // TODO: implement getCoordenadas
    throw UnimplementedError();
  }
}
