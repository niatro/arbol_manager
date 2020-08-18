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

typedef Future<ArbolesEntity> _CoordenadasOIdNfcSelect();
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
    return await _getARbolesEntity(() {
      return remoteDataSource.getArbolPorIdNFC(idNFC: idNFC);
    });
  }

  @override
  Future<Either<Failure, ArbolesEntity>> getArbolesCercanos(
      LatLng coordenadas) async {
    return await _getARbolesEntity(() {
      return remoteDataSource.getArbolesCercanos(coordenadas: coordenadas);
    });
  }

  @override
  Future<Either<Failure, bool>> comprobarIdNFC(String idNFC) {
    // TODO: implement comprobarExistenciaIdNFC
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, IdNFCEntity>> fromChipReadAndGetIdNFC(
      String idUsuario) async {
    // TODO: implement fromChipReadAndGetIdNFC
    String idNFC =
        await remoteDataSource.fromChipReadAndGetIdNFC(idUsuario: idUsuario);
    final IdNFCEntity idNFCEntity = IdNFCEntity(idNfc: idNFC);
    return Right(idNFCEntity);
  }

  @override
  Future<Either<Failure, bool>> grabarArboles(ArbolesEntity arboles) {
    // TODO: implement grabarArbolesLevantadosOneByOne
    throw UnimplementedError();
  }

  Future<Either<Failure, ArbolesEntity>> _getARbolesEntity(
    _CoordenadasOIdNfcSelect getArbolesPorCoordenadasOIdNFC,
  ) async {
    if (await netWorkInfo.isConnected) {
      try {
        final remoteArbolesEntityModel = await getArbolesPorCoordenadasOIdNFC();
        localDatasource.cacheArbolesEntityModelo(remoteArbolesEntityModel);
        return Right(remoteArbolesEntityModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final arbolesLocales = await localDatasource.getCacheArboles();
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
