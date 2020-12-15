part of 'nfc_bloc.dart';

@freezed
abstract class NfcEvent with _$NfcEvent {
  const factory NfcEvent.leidoNfc() = LeidoNfcEvent;
  const factory NfcEvent.verificadoIdNfc(String idNfc) = VerificadoIdNfcEvent;
  const factory NfcEvent.escribirdNfc(String idNfc) = EscribirdNfcEvent;
  const factory NfcEvent.arbolConseguidoPorIdNfc(String idNfc) =
      ArbolConseguidoPorIdNfcEvent;
  const factory NfcEvent.leerVerificarConseguir(UserEntity usuario) =
      leerVerificarConseguirEvent;
}
