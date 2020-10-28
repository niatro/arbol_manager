import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/core/util/input_converter.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/actualizar_datos_form_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_coordenadas_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_datos_form_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/leer_idnfc_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/login_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/update_arboles_usecase.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/arboles_entity.dart';
import '../../../domain/usecases/comprobar_idnfc_usecase.dart';
import '../../../domain/usecases/get_arbol_por_idnfc_usecase.dart';
import '../../../domain/usecases/get_arboles_cercanos_usecase.dart';
import '../../../domain/usecases/grabar_arboles_usecase.dart';

part 'arboles_entity_event.dart';

part 'arboles_entity_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input';
const String CONEXION_FAILURE_MESSAGE = 'No esta conectado a internet';
const String IDFNC_EXISTE_FAILURE_MESSAGE =
    'No se puede grabar un idnfc que ya existe en la base de datos';
const String SERVER_SAVE_FAILURE_MESSAGE =
    'Hubo un error al grabar o actualizar en el servidor';
const String INVALID_NFC_FAILURE_MESSAGE = 'Invalid Nfc';
const String UPDATE_NFC_FAILURE_MESSAGE =
    'El IdNfc no esta en la base de datos';

class ArbolesEntityBloc extends Bloc<ArbolesEntityEvent, ArbolesEntityState> {
  final GetArbolesCercanosUseCase getArbolesCercanosUseCase;
  final ComprobarIdNFCUseCase comprobarIdNFCUseCase;
  final GetArbolPorIdNFCUseCase getArbolPorIdNFCUseCase;
  final GrabarArbolUseCase grabarArbolUseCase;
  final UpdateArbolesUseCase updateArbolUseCase;
  final ActualizarDatosFormUseCase actualizarDatosFormUseCase;
  final GetDatosFormUseCase getDatosFormUseCase;
  final LeerIdNFCUseCase leerIdNFCUseCase;
  final GetCoordUseCase getCoordUseCase;
  final LoginUseCase loginUseCase;
  final InputConverterStrToLatLng inputConverterStrToLatLng;
  final InputConverterIdNFCToStr inputConverterIdNFCToStr;

  ArbolesEntityBloc(
      {@required GetArbolesCercanosUseCase arbolesCercanosUseCase,
      @required ComprobarIdNFCUseCase comprobarIdNFCUseCase,
      @required GetArbolPorIdNFCUseCase arbolPorIdNFCUseCase,
      @required GrabarArbolUseCase grabarArbolUseCase,
      @required UpdateArbolesUseCase updateArbolesUseCase,
      @required ActualizarDatosFormUseCase actualizarDatosFormUseCase,
      @required GetDatosFormUseCase getDatosFormUseCase,
      @required LeerIdNFCUseCase leerIdNFCUseCase,
      @required GetCoordUseCase getCoordUseCase,
      @required LoginUseCase loginUseCase,
      @required InputConverterStrToLatLng inputConverter,
      @required InputConverterIdNFCToStr inputConverterFromIdNFCToStr})
      : assert(arbolesCercanosUseCase != null),
        assert(comprobarIdNFCUseCase != null),
        assert(arbolPorIdNFCUseCase != null),
        assert(grabarArbolUseCase != null),
        assert(actualizarDatosFormUseCase != null),
        assert(getDatosFormUseCase != null),
        assert(updateArbolesUseCase != null),
        assert(leerIdNFCUseCase != null),
        assert(getCoordUseCase != null),
        assert(loginUseCase != null),
        assert(inputConverter != null),
        assert(inputConverterFromIdNFCToStr != null),
        getArbolesCercanosUseCase = arbolesCercanosUseCase,
        comprobarIdNFCUseCase = comprobarIdNFCUseCase,
        getArbolPorIdNFCUseCase = arbolPorIdNFCUseCase,
        grabarArbolUseCase = grabarArbolUseCase,
        actualizarDatosFormUseCase = actualizarDatosFormUseCase,
        getDatosFormUseCase = getDatosFormUseCase,
        updateArbolUseCase = updateArbolesUseCase,
        leerIdNFCUseCase = leerIdNFCUseCase,
        getCoordUseCase = getCoordUseCase,
        loginUseCase = loginUseCase,
        inputConverterStrToLatLng = inputConverter,
        inputConverterIdNFCToStr = inputConverterFromIdNFCToStr;

  @override
  ArbolesEntityState get initialState => Empty();

  @override
  Stream<ArbolesEntityState> mapEventToState(
    ArbolesEntityEvent event,
  ) async* {
    if (event is GetArbolesEntityCercanosEvent) {
      final inputEither =
          inputConverterStrToLatLng.stringToLatLng(event.coordenada);
      yield* inputEither.fold(
        (Failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (coordenada) async* {
          yield Loading();
          final failureOrArboles =
              await getArbolesCercanosUseCase(Params(coordenada: coordenada));
          yield* _eatherLoadedOrErrorState(failureOrArboles);
        },
      );
    } else if (event is GetArbolesEntityPorIdNFCEvent) {
      final inputEither = inputConverterIdNFCToStr.idNFCToStr(event.idNFC);
      yield* inputEither.fold(
        (Failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (idNFC) async* {
          yield Loading();
          final failureOrArboles =
              await getArbolPorIdNFCUseCase(Params(idNFC: idNFC));
          yield* _eatherLoadedOrErrorState(failureOrArboles);
        },
      );
    } else if (event is GrabarArbolEvent) {
      yield Saving();
      final Either<Failure, Success> failOrSuccess = await grabarArbolUseCase(
          Params(arbolesEntity: event.arboles, nArbol: event.nArbol));
      yield* failOrSuccess.fold(
        (Failure) async* {
          if (Failure == ConexionFailure()) {
            yield Error(message: CONEXION_FAILURE_MESSAGE);
          } else if (Failure == ArbolNoGrabaYaExisteFailure()) {
            yield Error(message: INVALID_NFC_FAILURE_MESSAGE);
          } else if (Failure == ServerGrabarFailure()) {
            yield Error(message: SERVER_FAILURE_MESSAGE);
          }
        },
        (Success) async* {
          yield Saved(success: ServerGrabarSuccess());
        },
      );
    } else if (event is UpdateArbolEvent) {
      yield Updating();
      final Either<Failure, Success> failOrSuccess = await updateArbolUseCase(
          Params(arbolesEntity: event.arboles, nArbol: event.nArbol));
      yield* failOrSuccess.fold(
        (Failure) async* {
          if (Failure == ConexionFailure()) {
            yield Error(message: CONEXION_FAILURE_MESSAGE);
          } else if (Failure == ArbolNoUpdateNoExisteFailure()) {
            yield Error(message: UPDATE_NFC_FAILURE_MESSAGE);
          } else if (Failure == ServerUpdateFailure()) {
            yield Error(message: SERVER_FAILURE_MESSAGE);
          }
        },
        (Success) async* {
          yield Updated(success: ServerUpdateSuccess());
        },
      );
    }
  }

  Stream<ArbolesEntityState> _eatherLoadedOrErrorState(
      Either<Failure, ArbolesEntity> failureOrArboles) async* {
    yield failureOrArboles.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (arboles) => Loaded(arboles: arboles),
    );
  }

  Stream<ArbolesEntityState> _eatherSavedOrErrorState(
      Either<Failure, Success> failureOrSuccess) async* {
    yield failureOrSuccess.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (success) => Saved(success: success),
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
      default:
        return 'Unexpected error';
    }
  }
}
