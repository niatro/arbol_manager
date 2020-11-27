import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/core/util/input_converter.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/user_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/comprobar_idnfc_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_arboles_cercanos_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_coordenadas_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/leer_idnfc_usecase.dart';
import 'package:flutterapparbol/features/arbol/presentation/bloc/arboles_entity/arboles_entity_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'arbol_mapa_bloc.freezed.dart';
part 'arbol_mapa_event.dart';

part 'arbol_mapa_state.dart';

@injectable
class ArbolMapaBloc extends Bloc<ArbolMapaEvent, ArbolMapaState> {
  final GetArbolesCercanosUseCase getArbolesCercanosUseCase;
  final ComprobarIdNFCUseCase comprobarIdNFCUseCase;
  final LeerIdNfcUseCase leerIdNfcUseCase;
  final GetCoordUseCase getCoordUseCase;
  final InputConverterStrToLatLng inputConverterStrToLatLng;
  final InputConverterIdNFCToStr inputConverterIdNFCToStr;

  ArbolMapaBloc(
      {@required GetArbolesCercanosUseCase arbolesCercanosUseCase,
      @required ComprobarIdNFCUseCase comprobarIdNFCUseCase,
      @required LeerIdNfcUseCase leerIdNfcUseCase,
      @required GetCoordUseCase getCoordUseCase,
      @required InputConverterStrToLatLng inputConverter,
      @required InputConverterIdNFCToStr inputConverterFromIdNFCToStr})
      : assert(arbolesCercanosUseCase != null),
        assert(comprobarIdNFCUseCase != null),
        assert(leerIdNfcUseCase != null),
        assert(getCoordUseCase != null),
        assert(inputConverter != null),
        assert(inputConverterFromIdNFCToStr != null),
        getArbolesCercanosUseCase = arbolesCercanosUseCase,
        comprobarIdNFCUseCase = comprobarIdNFCUseCase,
        leerIdNfcUseCase = leerIdNfcUseCase,
        getCoordUseCase = getCoordUseCase,
        inputConverterStrToLatLng = inputConverter,
        inputConverterIdNFCToStr = inputConverterFromIdNFCToStr;

  @override
  ArbolMapaState get initialState => ArbolMapaState.initial();

  @override
  Stream<ArbolMapaState> mapEventToState(
    ArbolMapaEvent event,
  ) async* {
    yield* event.map(
      comprobarIdNfcEvent: (e) async* {
        yield LoadingMapaState();
        final Either<Failure, bool> failOrBool =
            await comprobarIdNFCUseCase(Params(idNFC: e.idNfc));
        yield* failOrBool.fold(
          (Failure) async* {
            if (Failure == ServerFailure()) {
              yield ArbolMapaState.failure(
                  message: _mapFailureToMessage(Failure));
            }
          },
          (bool) async* {
            yield ArbolMapaState.idNfcChequeado(existe: bool);
          },
        );
      },
      getArbolesCercanosEvent: (e) async* {
        final inputEither =
            inputConverterStrToLatLng.stringToLatLng(e.coordenadas);
        yield* inputEither.fold(
          (failure) async* {
            ArbolMapaState.failure(message: _mapFailureToMessage(failure));
          },
          (coordenada) async* {
            yield LoadingMapaState();
            final failureOrArboles = await getArbolesCercanosUseCase(
                Params(coordenada: coordenada, distancia: e.distancia));
            yield* failureOrArboles.fold(
              (failure) async* {
                print(
                    'En Arbol_bloc getArbolesCercanosEvent se produjo un failure, temporalmente /n '
                    ' hice que en vez de la falla se despliegue el mapa la falla registrada es: $_mapFailureToMessage(failure)');
//                yield ArbolMapaState.failure(
//                    message: _mapFailureToMessage(failure));
                yield ArbolMapaState.mapaDesplegado(latLong: coordenada);
              },
              (arboles) async* {
                print(arboles);
                yield ArbolMapaState.mapaDesplegado(
                    latLong: coordenada, arboles: arboles);
//                yield ArbolMapaState.desplegandoArbolesCercanos(
//                    arboles: arboles, coordenada: coordenada);
              },
            );
          },
        );
      },
      getCoordenadasEvent: (e) async* {
        yield LoadingMapaState();
        final Either<Failure, LatLng> failOrLatLng =
            await getCoordUseCase(NoParams());
        yield* failOrLatLng.fold(
          (failure) async* {
            yield ArbolMapaState.failure(
                message: _mapFailureToMessage(failure));
          },
          (latLng) async* {
//            yield ArbolMapaState.coordenadasObtenidas(latLng: latLng);
            yield ArbolMapaState.mapaDesplegado(latLong: latLng);
          },
        );
      },
      leerIdNfConTelefonoEvent: (e) async* {
        yield LoadingMapaState();
        final Either<Failure, NfcEntity> failOrNfcEntity =
            await leerIdNfcUseCase(Params(usuario: e.usuario));
        yield* failOrNfcEntity.fold(
          (failure) async* {
            yield ArbolMapaState.failure(
                message: _mapFailureToMessage(failure));
          },
          (NfcEntity) async* {
            yield ArbolMapaState.idNfcObtenido(nfcEntity: NfcEntity);
          },
        );
      },
      agregarPinEvent: (e) async* {},
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case ConexionFailure:
        return CONEXION_FAILURE_MESSAGE;
      case ArbolNoGrabaYaExisteFailure:
        return IDFNC_EXISTE_FAILURE_MESSAGE;
      case ServerGrabarFailure:
        return SERVER_SAVE_FAILURE_MESSAGE;
      case ArbolNoGrabaYaExisteFailure:
        return INVALID_NFC_FAILURE_MESSAGE;
      case ArbolNoUpdateNoExisteFailure:
        return UPDATE_NFC_FAILURE_MESSAGE;
      case ServerUpdateFailure:
        return SERVER_FAILURE_MESSAGE;
      case SqlFailure:
        return SQL_FAILURE;
      case PassNoExisteFailure:
        return PASSWORD_FAILURE;
      case NfcFailure:
        return READ_NFC_FAILURE_MESSAGE;
      case CoordFailure:
        return COORD_FAILURE;
      default:
        return 'Unexpected error';
    }
  }
}
