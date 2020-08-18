import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/core/util/input_converter.dart';
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

class ArbolesEntityBloc extends Bloc<ArbolesEntityEvent, ArbolesEntityState> {
  final GetArbolesCercanosUseCase getArbolesCercanosUseCase;
  final ComprobarIdNFCUseCase comprobarIdNFCUseCase;
  final GetArbolPorIdNFCUseCase getArbolPorIdNFCUseCase;
  final GrabarArbolesUseCase grabarArbolesUseCase;
  final InputConverterStrToLatLng inputConverterStrToLatLng;
  final InputConverterIdNFCToStr inputConverterIdNFCToStr;

  ArbolesEntityBloc(
      {@required GetArbolesCercanosUseCase arbolesCercanosUseCase,
      @required ComprobarIdNFCUseCase comprobarIdNFCUseCase,
      @required GetArbolPorIdNFCUseCase arbolPorIdNFCUseCase,
      @required GrabarArbolesUseCase grabarArbolesUseCase,
      @required InputConverterStrToLatLng inputConverter,
      @required InputConverterIdNFCToStr inputConverterFromIdNFCToStr})
      : assert(arbolesCercanosUseCase != null),
        assert(comprobarIdNFCUseCase != null),
        assert(arbolPorIdNFCUseCase != null),
        assert(grabarArbolesUseCase != null),
        assert(inputConverter != null),
        assert(inputConverterFromIdNFCToStr != null),
        getArbolesCercanosUseCase = arbolesCercanosUseCase,
        comprobarIdNFCUseCase = comprobarIdNFCUseCase,
        getArbolPorIdNFCUseCase = arbolPorIdNFCUseCase,
        grabarArbolesUseCase = grabarArbolesUseCase,
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
    }
  }

  Stream<ArbolesEntityState> _eatherLoadedOrErrorState(
      Either<Failure, ArbolesEntity> failureOrArboles) async* {
    yield failureOrArboles.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (arboles) => Loaded(arboles: arboles),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
