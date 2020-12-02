part of 'arbol_mapa_bloc.dart';

@freezed
abstract class ArbolMapaEvent with _$ArbolMapaEvent {
  const factory ArbolMapaEvent.getArbolesCercanosEvent(
      String coordenadas, int distancia) = GetArbolesCercanosEvent;
  const factory ArbolMapaEvent.getCoordenadasEvent() = GetCoordenadasEvent;
  const factory ArbolMapaEvent.onTapPantalla(
      {LatLng tapPosicion,
      ArbolesEntity arboles,
      LatLng localizacion}) = OnTapPantallaEvent;
}
