import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/core/util/input_converter.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/form_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/user_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/actualizar_datos_form_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_coordenadas_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_datos_form_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/leer_idnfc_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/login_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/update_arboles_usecase.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
const String PASSWORD_FAILURE =
    'El password no existe o no tiene derechos de acceso';
const String READ_NFC_FAILURE_MESSAGE = 'Problema al leer el Nfc';
const String SQL_FAILURE =
    'Ocurrio algun error al intentar leer la base de datos interna';
const String COORD_FAILURE = 'Ocurrio algun error obteniendo las coordenadas';

class ArbolesEntityBloc extends Bloc<ArbolesEntityEvent, ArbolesEntityState> {
  final GetArbolesCercanosUseCase getArbolesCercanosUseCase;
  final ComprobarIdNFCUseCase comprobarIdNFCUseCase;
  final GetArbolPorIdNFCUseCase getArbolPorIdNFCUseCase;
  final GrabarArbolUseCase grabarArbolUseCase;
  final UpdateArbolesUseCase updateArbolUseCase;
  final ActualizarDatosFormUseCase actualizarDatosFormUseCase;
  final GetDatosFormUseCase getDatosFormUseCase;
  final LeerIdNfcUseCase leerIdNfcUseCase;
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
      @required LeerIdNfcUseCase leerIdNfcUseCase,
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
        assert(leerIdNfcUseCase != null),
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
        leerIdNfcUseCase = leerIdNfcUseCase,
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
            yield Error(message: _mapFailureToMessage(Failure));
          } else if (Failure == ArbolNoGrabaYaExisteFailure()) {
            yield Error(message: _mapFailureToMessage(Failure));
          } else if (Failure == ServerGrabarFailure()) {
            yield Error(message: _mapFailureToMessage(Failure));
          }
        },
        (Success) async* {
          yield Saved(success: ServerGrabarSuccess());
        },
      );
    } else if (event is UpdateArbolEvent) {
      yield Saving();
      final Either<Failure, Success> failOrSuccess = await updateArbolUseCase(
          Params(arbolesEntity: event.arboles, nArbol: event.nArbol));
      yield* failOrSuccess.fold(
        (Failure) async* {
          if (Failure == ConexionFailure()) {
            yield Error(message: _mapFailureToMessage(Failure));
          } else if (Failure == ArbolNoUpdateNoExisteFailure()) {
            yield Error(message: _mapFailureToMessage(Failure));
          } else if (Failure == ServerUpdateFailure()) {
            yield Error(message: _mapFailureToMessage(Failure));
          }
        },
        (Success) async* {
          yield UpdatedArbol(success: ServerUpdateSuccess());
        },
      );
    } else if (event is ActualizarFormEvent) {
      yield Loading();
      final Either<Failure, Success> failOrSuccess =
          await actualizarDatosFormUseCase(NoParams());
      yield* failOrSuccess.fold(
        (Failure) async* {
          if (Failure == ConexionFailure()) {
            yield Error(message: _mapFailureToMessage(Failure));
          } else if (Failure == ServerFailure()) {
            yield Error(message: _mapFailureToMessage(Failure));
          }
        },
        (Success) async* {
          yield UpdatedSql(success: ServerActualizarFormSuccess());
        },
      );
    } else if (event is GetDatosFormEvent) {
      yield Loading();
      final Either<Failure, FormEntity> failOrSuccess =
          await getDatosFormUseCase(Params(idUsuario: event.idUsuario));
      yield* failOrSuccess.fold(
        (Failure) async* {
          if (Failure == SqlFailure()) {
            yield Error(message: _mapFailureToMessage(Failure));
          } else if (Failure == ServerFailure()) {
            yield Error(message: _mapFailureToMessage(Failure));
          }
        },
        (FormEntity) async* {
          yield UpdatedForm(formData: FormEntity);
        },
      );
    } else if (event is LoginUserEvent) {
      yield Loading();

      final Either<Failure, UserEntity> failOrSuccess =
          await loginUseCase(Params(password: event.password, rut: event.rut));
      yield* failOrSuccess.fold(
        (Failure) async* {
          if (Failure == PassNoExisteFailure()) {
            yield Error(message: _mapFailureToMessage(Failure));
          } else if (Failure == ServerFailure()) {
            yield Error(message: _mapFailureToMessage(Failure));
          } else if (Failure == ConexionFailure()) {
            yield Error(message: _mapFailureToMessage(Failure));
          }
        },
        (UserEntity) async* {
          yield LoadedUser(usuario: UserEntity);
        },
      );
    } else if (event is LeerIdNfcEvent) {
      yield Loading();
      final Either<Failure, NfcEntity> failOrNfcEntity =
          await leerIdNfcUseCase(Params(usuario: event.usuario));
      yield* failOrNfcEntity.fold(
        (Failure) async* {
          if (Failure == NfcFailure()) {
            yield Error(message: _mapFailureToMessage(Failure));
          }
        },
        (NfcEntity) async* {
          yield ReadedNfc(nfcEntity: NfcEntity);
        },
      );
    } else if (event is GetCoordEvent) {
      yield Loading();
      final Either<Failure, LatLng> failOrLatLng =
          await getCoordUseCase(NoParams());
      yield* failOrLatLng.fold(
        (Failure) async* {
          if (Failure == CoordFailure()) {
            yield Error(message: _mapFailureToMessage(Failure));
          }
        },
        (LatLng) async* {
          yield GettedCoord(latLng: LatLng);
        },
      );
    } else if (event is ComprobarIdNfcEvent) {
      yield Loading();
      final Either<Failure, bool> failOrBool =
          await comprobarIdNFCUseCase(Params(idNFC: event.idNfc));
      yield* failOrBool.fold(
        (Failure) async* {
          if (Failure == ServerFailure()) {
            yield Error(message: _mapFailureToMessage(Failure));
          }
        },
        (bool) async* {
          yield CheckedIdNfc(existe: bool);
        },
      );
    }
  }

  Stream<ArbolesEntityState> _eatherLoadedOrErrorState(
      Either<Failure, ArbolesEntity> failureOrArboles) async* {
    yield failureOrArboles.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (arboles) => LoadedArboles(arboles: arboles),
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
