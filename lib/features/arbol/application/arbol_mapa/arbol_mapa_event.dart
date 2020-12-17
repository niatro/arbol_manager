part of 'arbol_mapa_bloc.dart';

@freezed
abstract class ArbolMapaEvent with _$ArbolMapaEvent {
  const factory ArbolMapaEvent.getArbolesCercanosEvent(
    String coordenadas,
    int distancia,
    BitmapDescriptor markerIconResto,
  ) = GetArbolesCercanosEvent;
  const factory ArbolMapaEvent.cambiarMapa({
    LatLng localizacion,
    bool cambiar,
    ArbolesEntity arboles,
    BitmapDescriptor markerIcon,
    BitmapDescriptor markerIconResto,
  }) = cambiarMapaEvent;
  const factory ArbolMapaEvent.getCoordenadasEvent() = GetCoordenadasEvent;
  const factory ArbolMapaEvent.onTapPantalla({
    LatLng tapPosicion,
    ArbolesEntity arboles,
    LatLng localizacion,
    BitmapDescriptor markerIcon,
    BitmapDescriptor markerIconResto,
    MapType mapType,
  }) = OnTapPantallaEvent;
}
