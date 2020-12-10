import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/core/util/input_converter.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';

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
  final ComprobarIdNfcUseCase comprobarIdNFCUseCase;
  final LeerIdNfcUseCase leerIdNfcUseCase;
  final GetCoordUseCase getCoordUseCase;
  final InputConverterStrToLatLng inputConverterStrToLatLng;
  final InputConverterIdNFCToStr inputConverterIdNFCToStr;

  ArbolMapaBloc(
      {@required GetArbolesCercanosUseCase arbolesCercanosUseCase,
      @required ComprobarIdNfcUseCase comprobarIdNFCUseCase,
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
                    latLong: coordenada,
                    arboles: arboles,
                    markerIconResto: e.markerIconResto);
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
      onTapPantalla: (e) async* {
        if (e.arboles == null || e.arboles.listaArbolEntity.length == 1) {
          ArbolEntity arbolDePosicion = _generarArbolMarcador(e.tapPosicion);
          print(arbolDePosicion);
          final ArbolesEntity arbolesNuevos =
              ArbolesEntity(listaArbolEntity: [arbolDePosicion]);
          yield ArbolMapaState.mapaDesplegado(
            arboles: arbolesNuevos,
            latLong: e.localizacion,
            tapPosition: e.tapPosicion,
            markerIcon: e.markerIcon,
            markerIconResto: e.markerIconResto,
          );
        } else {
          ArbolEntity arbolVacioPosicion = _generarArbolMarcador(e.tapPosicion);
          final ArbolesEntity arbolesNuevos = ArbolesEntity(listaArbolEntity: [
            ...e.arboles.listaArbolEntity,
            arbolVacioPosicion
          ]);
          yield ArbolMapaState.mapaDesplegado(
            arboles: arbolesNuevos,
            latLong: e.localizacion,
            tapPosition: e.tapPosicion,
            markerIcon: e.markerIcon,
            markerIconResto: e.markerIconResto,
          );
        }
      },
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

  ArbolEntity _generarArbolMarcador(LatLng tapPosicion) {
    final ArbolEntity arbolVacioPosicion = ArbolEntity(
      guiArbol: "No asignado",
      idArbol: 0,
      idNfcHistoria: [],
      clienteArbol: "No asignado",
      zonaArbol: "No Asignada",
      calleArbol: "No Asignada",
      nCalleArbol: null,
      esquinaCalleArbol: "No Asignada",
      especieArbol: "No Asignada",
      diametroTroncoArbolCm: null,
      diametroCopaNsArbolMt: null,
      diametroCopaEoArbolMt: null,
      alturaArbolArbolMt: null,
      alturaCopaArbolMt: null,
      estadoGeneralArbol: "No determinado",
      estadoSanitarioArbol: "No determinado",
      enfermedad: Enfermedad(),
      inclinacionTroncoArbol: "No determinado",
      orientacionInclinacionArbol: "No determinado",
      obsArbolHistoria: [],
      accionObsArbol: "No Asignada",
      segundaAccionObsArbol: "No Asignada",
      terceraAccionObsArbol: "No Asignada",
      geoReferenciaCapturaArbol: tapPosicion,
      nombreUsuarioCreacionArbol: "No Asignada",
      usuarioModificaArbol: "No Asignada",
      fechaCreacionArbol: null,
      fechaUltimaModArbol: null,
      alertaArbol: "No Asignada",
      revisionArbol: "No Asignada",
      fotosArbol: [],
      fotosEnfermedad: [],
    );
    return arbolVacioPosicion;
  }
}
