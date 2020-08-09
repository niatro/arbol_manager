import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterapparbol/core/error/failure.dart';
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
  final InputConverter inputConverter;

  ArbolesEntityBloc({
    @required GetArbolesCercanosUseCase arbolesCercanosUseCase,
    @required ComprobarIdNFCUseCase comprobarIdNFCUseCase,
    @required GetArbolPorIdNFCUseCase arbolPorIdNFCUseCase,
    @required GrabarArbolesUseCase grabarArbolesUseCase,
    @required InputConverter inputConverter,
  })  : assert(arbolesCercanosUseCase != null),
        assert(comprobarIdNFCUseCase != null),
        assert(arbolPorIdNFCUseCase != null),
        assert(grabarArbolesUseCase != null),
        assert(inputConverter != null),
        getArbolesCercanosUseCase = arbolesCercanosUseCase,
        comprobarIdNFCUseCase = comprobarIdNFCUseCase,
        getArbolPorIdNFCUseCase = arbolPorIdNFCUseCase,
        grabarArbolesUseCase = grabarArbolesUseCase,
        inputConverter = inputConverter;

  @override
  ArbolesEntityState get initialState => Empty();

  @override
  Stream<ArbolesEntityState> mapEventToState(
    ArbolesEntityEvent event,
  ) async* {
    // TODO: Add your event logic
    if (event is GetArbolesEntityCercanosPorCoordenada) {
      final inputEither =
          inputConverter.stringToUnsignedLatLng(event.coordenada);
      yield* inputEither.fold(
        (Failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (coordenada) => throw UnimplementedError(),
      );
    }
  }
}
