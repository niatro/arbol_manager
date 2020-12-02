part of 'arbol_mapa_bloc.dart';

@freezed
abstract class ArbolMapaState with _$ArbolMapaState {
  const factory ArbolMapaState.initial() = InitialMapaState;
  const factory ArbolMapaState.desplegandoArbolesCercanos({
    @required ArbolesEntity arboles,
    @required LatLng coordenada,
  }) = ArbolesCercanosObtenidosMapaState;
  const factory ArbolMapaState.coordenadasObtenidas({
    @required LatLng latLng,
  }) = CoordenadasObtenidasMapaState;
  const factory ArbolMapaState.failure({
    @required String message,
  }) = FailureMapaState;
  const factory ArbolMapaState.loading() = LoadingMapaState;

  const factory ArbolMapaState.mapaDesplegado({
    @required LatLng latLong,
    ArbolesEntity arboles,
    LatLng tapPosition,
    UserEntity usuario,
  }) = MapaDesplegadoState;
}
