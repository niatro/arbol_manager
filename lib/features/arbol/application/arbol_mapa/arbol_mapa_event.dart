part of 'arbol_mapa_bloc.dart';

@freezed
abstract class ArbolMapaEvent with _$ArbolMapaEvent {
  const factory ArbolMapaEvent.comprobarIdNfcEvent(String idNfc) =
      ComprobarIdNfacEvent;
  const factory ArbolMapaEvent.getArbolesCercanosEvent(
      String coordenadas, int distancia) = GetArbolesCercanosEvent;
  const factory ArbolMapaEvent.getCoordenadasEvent() = GetCoordenadasEvent;
  const factory ArbolMapaEvent.leerIdNfConTelefonoEvent(UserEntity usuario) =
      LeerIdNfConTelefonoEvent;
  const factory ArbolMapaEvent.onTapPantalla(
      {LatLng tapPosicion,
      ArbolesEntity arboles,
      LatLng localizacion}) = OnTapPantallaEvent;
}
