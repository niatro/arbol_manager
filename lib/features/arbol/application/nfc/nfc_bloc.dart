import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutterapparbol/core/constants/usuario_test.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/comprobar_idnfc_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_arbol_por_idnfc_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/leer_idnfc_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nfc_event.dart';
part 'nfc_state.dart';
part 'nfc_bloc.freezed.dart';

@injectable
class NfcBloc extends Bloc<NfcEvent, NfcState> {
  final GetArbolPorIdNFCUseCase getArbolPorIdNFCUseCase;
  final LeerIdNfcUseCase leerIdNfcUseCase;
  final ComprobarIdNfcUseCase comprobarIdNfcUseCase;

  NfcBloc({
    @required GetArbolPorIdNFCUseCase getArbolPorIdNFCUseCase,
    @required LeerIdNfcUseCase leerIdNfcUseCase,
    @required ComprobarIdNfcUseCase comprobarIdNfcUseCase,
  })  : assert(getArbolPorIdNFCUseCase != null),
        assert(leerIdNfcUseCase != null),
        assert(comprobarIdNfcUseCase != null),
        getArbolPorIdNFCUseCase = getArbolPorIdNFCUseCase,
        leerIdNfcUseCase = leerIdNfcUseCase,
        comprobarIdNfcUseCase = comprobarIdNfcUseCase;

  NfcState get initialState => NfcState.initial();

  @override
  Stream<NfcState> mapEventToState(
    NfcEvent event,
  ) async* {
    yield* event.map(
      leidoNfc: (e) async* {
        yield LoadingNfcState();
        final failureOrNfc = await leerIdNfcUseCase
            .call(Params(idUsuario: usuarioTest.idUsuario));
        yield* failureOrNfc.fold(
          (failure) async* {
            yield NfcState(
              nfcEntity: null,
              arbol: null,
              estaRegistrado: false,
              showErrorMessages: true,
              failure: failure,
            );
          },
          (nfcEntity) async* {
            yield NfcState(
              nfcEntity: nfcEntity,
              arbol: null,
              estaRegistrado: false,
              showErrorMessages: false,
              failure: null,
            );
          },
        );
      },
      verificadoIdNfc: (e) async* {
        yield LoadingNfcState();
        final failureOrNfc =
            await comprobarIdNfcUseCase.call(Params(idNFC: e.idNfc));
        yield* failureOrNfc.fold(
          (failure) async* {
            yield NfcState(
              nfcEntity: null,
              arbol: null,
              estaRegistrado: false,
              showErrorMessages: true,
              failure: failure,
            );
          },
          (trueFalse) async* {
            if (trueFalse == true) {
              print('esta registrado');
              yield NfcState(
                nfcEntity: NfcEntity(idNfc: e.idNfc),
                arbol: null,
                estaRegistrado: true,
                showErrorMessages: false,
                failure: null,
              );
            } else {
              print('no esta registrado');
              yield NfcState(
                nfcEntity: NfcEntity(idNfc: e.idNfc),
                arbol: null,
                estaRegistrado: false,
                showErrorMessages: true,
                failure: null,
              );
            }
            ;
          },
        );
      },
      escribirdNfc: (e) async* {},
      arbolConseguidoPorIdNfc: (e) async* {
        yield LoadingNfcState();
        final failureOrArbol =
            await getArbolPorIdNFCUseCase.call(Params(idNFC: e.idNfc));
        yield* failureOrArbol.fold(
          (failure) async* {
            yield NfcState(
              nfcEntity: null,
              arbol: null,
              estaRegistrado: false,
              showErrorMessages: true,
              failure: failure,
            );
          },
          (arbol) async* {
            yield NfcState(
              nfcEntity: null,
              arbol: arbol,
              estaRegistrado: true,
              showErrorMessages: false,
              failure: null,
            );
          },
        );
      },
    );
  }
}
