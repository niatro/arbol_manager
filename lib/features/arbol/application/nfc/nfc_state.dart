part of 'nfc_bloc.dart';

// @immutable
// abstract class NfcState {}
//
// class NfcInitial extends NfcState {}

@freezed
abstract class NfcState with _$NfcState {
  const factory NfcState({
    @required NfcEntity nfcEntity,
    ArbolesEntity arbol,
    @required bool showErrorMessages,
    @required bool estaRegistrado,
    Failure failure,
  }) = _NfcState;
  factory NfcState.initial() => NfcState(
        nfcEntity: NfcEntity(idNfc: null, body: null),
        arbol: null,
        estaRegistrado: false,
        showErrorMessages: false,
        failure: null,
      );
  const factory NfcState.loadingNfcState() = LoadingNfcState;
}
