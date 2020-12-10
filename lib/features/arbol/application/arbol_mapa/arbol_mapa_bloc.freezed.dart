// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'arbol_mapa_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ArbolMapaEventTearOff {
  const _$ArbolMapaEventTearOff();

// ignore: unused_element
  GetArbolesCercanosEvent getArbolesCercanosEvent(
      String coordenadas, int distancia, BitmapDescriptor markerIconResto) {
    return GetArbolesCercanosEvent(
      coordenadas,
      distancia,
      markerIconResto,
    );
  }

// ignore: unused_element
  GetCoordenadasEvent getCoordenadasEvent() {
    return const GetCoordenadasEvent();
  }

// ignore: unused_element
  OnTapPantallaEvent onTapPantalla(
      {LatLng tapPosicion,
      ArbolesEntity arboles,
      LatLng localizacion,
      BitmapDescriptor markerIcon,
      BitmapDescriptor markerIconResto}) {
    return OnTapPantallaEvent(
      tapPosicion: tapPosicion,
      arboles: arboles,
      localizacion: localizacion,
      markerIcon: markerIcon,
      markerIconResto: markerIconResto,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ArbolMapaEvent = _$ArbolMapaEventTearOff();

/// @nodoc
mixin _$ArbolMapaEvent {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result getArbolesCercanosEvent(String coordenadas, int distancia,
            BitmapDescriptor markerIconResto),
    @required Result getCoordenadasEvent(),
    @required
        Result onTapPantalla(
            LatLng tapPosicion,
            ArbolesEntity arboles,
            LatLng localizacion,
            BitmapDescriptor markerIcon,
            BitmapDescriptor markerIconResto),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result getArbolesCercanosEvent(
        String coordenadas, int distancia, BitmapDescriptor markerIconResto),
    Result getCoordenadasEvent(),
    Result onTapPantalla(
        LatLng tapPosicion,
        ArbolesEntity arboles,
        LatLng localizacion,
        BitmapDescriptor markerIcon,
        BitmapDescriptor markerIconResto),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    @required Result getCoordenadasEvent(GetCoordenadasEvent value),
    @required Result onTapPantalla(OnTapPantallaEvent value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    Result getCoordenadasEvent(GetCoordenadasEvent value),
    Result onTapPantalla(OnTapPantallaEvent value),
    @required Result orElse(),
  });
}

/// @nodoc
abstract class $ArbolMapaEventCopyWith<$Res> {
  factory $ArbolMapaEventCopyWith(
          ArbolMapaEvent value, $Res Function(ArbolMapaEvent) then) =
      _$ArbolMapaEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ArbolMapaEventCopyWithImpl<$Res>
    implements $ArbolMapaEventCopyWith<$Res> {
  _$ArbolMapaEventCopyWithImpl(this._value, this._then);

  final ArbolMapaEvent _value;
  // ignore: unused_field
  final $Res Function(ArbolMapaEvent) _then;
}

/// @nodoc
abstract class $GetArbolesCercanosEventCopyWith<$Res> {
  factory $GetArbolesCercanosEventCopyWith(GetArbolesCercanosEvent value,
          $Res Function(GetArbolesCercanosEvent) then) =
      _$GetArbolesCercanosEventCopyWithImpl<$Res>;
  $Res call(
      {String coordenadas, int distancia, BitmapDescriptor markerIconResto});
}

/// @nodoc
class _$GetArbolesCercanosEventCopyWithImpl<$Res>
    extends _$ArbolMapaEventCopyWithImpl<$Res>
    implements $GetArbolesCercanosEventCopyWith<$Res> {
  _$GetArbolesCercanosEventCopyWithImpl(GetArbolesCercanosEvent _value,
      $Res Function(GetArbolesCercanosEvent) _then)
      : super(_value, (v) => _then(v as GetArbolesCercanosEvent));

  @override
  GetArbolesCercanosEvent get _value => super._value as GetArbolesCercanosEvent;

  @override
  $Res call({
    Object coordenadas = freezed,
    Object distancia = freezed,
    Object markerIconResto = freezed,
  }) {
    return _then(GetArbolesCercanosEvent(
      coordenadas == freezed ? _value.coordenadas : coordenadas as String,
      distancia == freezed ? _value.distancia : distancia as int,
      markerIconResto == freezed
          ? _value.markerIconResto
          : markerIconResto as BitmapDescriptor,
    ));
  }
}

/// @nodoc
class _$GetArbolesCercanosEvent implements GetArbolesCercanosEvent {
  const _$GetArbolesCercanosEvent(
      this.coordenadas, this.distancia, this.markerIconResto)
      : assert(coordenadas != null),
        assert(distancia != null),
        assert(markerIconResto != null);

  @override
  final String coordenadas;
  @override
  final int distancia;
  @override
  final BitmapDescriptor markerIconResto;

  @override
  String toString() {
    return 'ArbolMapaEvent.getArbolesCercanosEvent(coordenadas: $coordenadas, distancia: $distancia, markerIconResto: $markerIconResto)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetArbolesCercanosEvent &&
            (identical(other.coordenadas, coordenadas) ||
                const DeepCollectionEquality()
                    .equals(other.coordenadas, coordenadas)) &&
            (identical(other.distancia, distancia) ||
                const DeepCollectionEquality()
                    .equals(other.distancia, distancia)) &&
            (identical(other.markerIconResto, markerIconResto) ||
                const DeepCollectionEquality()
                    .equals(other.markerIconResto, markerIconResto)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(coordenadas) ^
      const DeepCollectionEquality().hash(distancia) ^
      const DeepCollectionEquality().hash(markerIconResto);

  @override
  $GetArbolesCercanosEventCopyWith<GetArbolesCercanosEvent> get copyWith =>
      _$GetArbolesCercanosEventCopyWithImpl<GetArbolesCercanosEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result getArbolesCercanosEvent(String coordenadas, int distancia,
            BitmapDescriptor markerIconResto),
    @required Result getCoordenadasEvent(),
    @required
        Result onTapPantalla(
            LatLng tapPosicion,
            ArbolesEntity arboles,
            LatLng localizacion,
            BitmapDescriptor markerIcon,
            BitmapDescriptor markerIconResto),
  }) {
    assert(getArbolesCercanosEvent != null);
    assert(getCoordenadasEvent != null);
    assert(onTapPantalla != null);
    return getArbolesCercanosEvent(coordenadas, distancia, markerIconResto);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result getArbolesCercanosEvent(
        String coordenadas, int distancia, BitmapDescriptor markerIconResto),
    Result getCoordenadasEvent(),
    Result onTapPantalla(
        LatLng tapPosicion,
        ArbolesEntity arboles,
        LatLng localizacion,
        BitmapDescriptor markerIcon,
        BitmapDescriptor markerIconResto),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (getArbolesCercanosEvent != null) {
      return getArbolesCercanosEvent(coordenadas, distancia, markerIconResto);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    @required Result getCoordenadasEvent(GetCoordenadasEvent value),
    @required Result onTapPantalla(OnTapPantallaEvent value),
  }) {
    assert(getArbolesCercanosEvent != null);
    assert(getCoordenadasEvent != null);
    assert(onTapPantalla != null);
    return getArbolesCercanosEvent(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    Result getCoordenadasEvent(GetCoordenadasEvent value),
    Result onTapPantalla(OnTapPantallaEvent value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (getArbolesCercanosEvent != null) {
      return getArbolesCercanosEvent(this);
    }
    return orElse();
  }
}

abstract class GetArbolesCercanosEvent implements ArbolMapaEvent {
  const factory GetArbolesCercanosEvent(
          String coordenadas, int distancia, BitmapDescriptor markerIconResto) =
      _$GetArbolesCercanosEvent;

  String get coordenadas;
  int get distancia;
  BitmapDescriptor get markerIconResto;
  $GetArbolesCercanosEventCopyWith<GetArbolesCercanosEvent> get copyWith;
}

/// @nodoc
abstract class $GetCoordenadasEventCopyWith<$Res> {
  factory $GetCoordenadasEventCopyWith(
          GetCoordenadasEvent value, $Res Function(GetCoordenadasEvent) then) =
      _$GetCoordenadasEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$GetCoordenadasEventCopyWithImpl<$Res>
    extends _$ArbolMapaEventCopyWithImpl<$Res>
    implements $GetCoordenadasEventCopyWith<$Res> {
  _$GetCoordenadasEventCopyWithImpl(
      GetCoordenadasEvent _value, $Res Function(GetCoordenadasEvent) _then)
      : super(_value, (v) => _then(v as GetCoordenadasEvent));

  @override
  GetCoordenadasEvent get _value => super._value as GetCoordenadasEvent;
}

/// @nodoc
class _$GetCoordenadasEvent implements GetCoordenadasEvent {
  const _$GetCoordenadasEvent();

  @override
  String toString() {
    return 'ArbolMapaEvent.getCoordenadasEvent()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is GetCoordenadasEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result getArbolesCercanosEvent(String coordenadas, int distancia,
            BitmapDescriptor markerIconResto),
    @required Result getCoordenadasEvent(),
    @required
        Result onTapPantalla(
            LatLng tapPosicion,
            ArbolesEntity arboles,
            LatLng localizacion,
            BitmapDescriptor markerIcon,
            BitmapDescriptor markerIconResto),
  }) {
    assert(getArbolesCercanosEvent != null);
    assert(getCoordenadasEvent != null);
    assert(onTapPantalla != null);
    return getCoordenadasEvent();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result getArbolesCercanosEvent(
        String coordenadas, int distancia, BitmapDescriptor markerIconResto),
    Result getCoordenadasEvent(),
    Result onTapPantalla(
        LatLng tapPosicion,
        ArbolesEntity arboles,
        LatLng localizacion,
        BitmapDescriptor markerIcon,
        BitmapDescriptor markerIconResto),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (getCoordenadasEvent != null) {
      return getCoordenadasEvent();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    @required Result getCoordenadasEvent(GetCoordenadasEvent value),
    @required Result onTapPantalla(OnTapPantallaEvent value),
  }) {
    assert(getArbolesCercanosEvent != null);
    assert(getCoordenadasEvent != null);
    assert(onTapPantalla != null);
    return getCoordenadasEvent(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    Result getCoordenadasEvent(GetCoordenadasEvent value),
    Result onTapPantalla(OnTapPantallaEvent value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (getCoordenadasEvent != null) {
      return getCoordenadasEvent(this);
    }
    return orElse();
  }
}

abstract class GetCoordenadasEvent implements ArbolMapaEvent {
  const factory GetCoordenadasEvent() = _$GetCoordenadasEvent;
}

/// @nodoc
abstract class $OnTapPantallaEventCopyWith<$Res> {
  factory $OnTapPantallaEventCopyWith(
          OnTapPantallaEvent value, $Res Function(OnTapPantallaEvent) then) =
      _$OnTapPantallaEventCopyWithImpl<$Res>;
  $Res call(
      {LatLng tapPosicion,
      ArbolesEntity arboles,
      LatLng localizacion,
      BitmapDescriptor markerIcon,
      BitmapDescriptor markerIconResto});
}

/// @nodoc
class _$OnTapPantallaEventCopyWithImpl<$Res>
    extends _$ArbolMapaEventCopyWithImpl<$Res>
    implements $OnTapPantallaEventCopyWith<$Res> {
  _$OnTapPantallaEventCopyWithImpl(
      OnTapPantallaEvent _value, $Res Function(OnTapPantallaEvent) _then)
      : super(_value, (v) => _then(v as OnTapPantallaEvent));

  @override
  OnTapPantallaEvent get _value => super._value as OnTapPantallaEvent;

  @override
  $Res call({
    Object tapPosicion = freezed,
    Object arboles = freezed,
    Object localizacion = freezed,
    Object markerIcon = freezed,
    Object markerIconResto = freezed,
  }) {
    return _then(OnTapPantallaEvent(
      tapPosicion:
          tapPosicion == freezed ? _value.tapPosicion : tapPosicion as LatLng,
      arboles: arboles == freezed ? _value.arboles : arboles as ArbolesEntity,
      localizacion: localizacion == freezed
          ? _value.localizacion
          : localizacion as LatLng,
      markerIcon: markerIcon == freezed
          ? _value.markerIcon
          : markerIcon as BitmapDescriptor,
      markerIconResto: markerIconResto == freezed
          ? _value.markerIconResto
          : markerIconResto as BitmapDescriptor,
    ));
  }
}

/// @nodoc
class _$OnTapPantallaEvent implements OnTapPantallaEvent {
  const _$OnTapPantallaEvent(
      {this.tapPosicion,
      this.arboles,
      this.localizacion,
      this.markerIcon,
      this.markerIconResto});

  @override
  final LatLng tapPosicion;
  @override
  final ArbolesEntity arboles;
  @override
  final LatLng localizacion;
  @override
  final BitmapDescriptor markerIcon;
  @override
  final BitmapDescriptor markerIconResto;

  @override
  String toString() {
    return 'ArbolMapaEvent.onTapPantalla(tapPosicion: $tapPosicion, arboles: $arboles, localizacion: $localizacion, markerIcon: $markerIcon, markerIconResto: $markerIconResto)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is OnTapPantallaEvent &&
            (identical(other.tapPosicion, tapPosicion) ||
                const DeepCollectionEquality()
                    .equals(other.tapPosicion, tapPosicion)) &&
            (identical(other.arboles, arboles) ||
                const DeepCollectionEquality()
                    .equals(other.arboles, arboles)) &&
            (identical(other.localizacion, localizacion) ||
                const DeepCollectionEquality()
                    .equals(other.localizacion, localizacion)) &&
            (identical(other.markerIcon, markerIcon) ||
                const DeepCollectionEquality()
                    .equals(other.markerIcon, markerIcon)) &&
            (identical(other.markerIconResto, markerIconResto) ||
                const DeepCollectionEquality()
                    .equals(other.markerIconResto, markerIconResto)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(tapPosicion) ^
      const DeepCollectionEquality().hash(arboles) ^
      const DeepCollectionEquality().hash(localizacion) ^
      const DeepCollectionEquality().hash(markerIcon) ^
      const DeepCollectionEquality().hash(markerIconResto);

  @override
  $OnTapPantallaEventCopyWith<OnTapPantallaEvent> get copyWith =>
      _$OnTapPantallaEventCopyWithImpl<OnTapPantallaEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result getArbolesCercanosEvent(String coordenadas, int distancia,
            BitmapDescriptor markerIconResto),
    @required Result getCoordenadasEvent(),
    @required
        Result onTapPantalla(
            LatLng tapPosicion,
            ArbolesEntity arboles,
            LatLng localizacion,
            BitmapDescriptor markerIcon,
            BitmapDescriptor markerIconResto),
  }) {
    assert(getArbolesCercanosEvent != null);
    assert(getCoordenadasEvent != null);
    assert(onTapPantalla != null);
    return onTapPantalla(
        tapPosicion, arboles, localizacion, markerIcon, markerIconResto);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result getArbolesCercanosEvent(
        String coordenadas, int distancia, BitmapDescriptor markerIconResto),
    Result getCoordenadasEvent(),
    Result onTapPantalla(
        LatLng tapPosicion,
        ArbolesEntity arboles,
        LatLng localizacion,
        BitmapDescriptor markerIcon,
        BitmapDescriptor markerIconResto),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (onTapPantalla != null) {
      return onTapPantalla(
          tapPosicion, arboles, localizacion, markerIcon, markerIconResto);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    @required Result getCoordenadasEvent(GetCoordenadasEvent value),
    @required Result onTapPantalla(OnTapPantallaEvent value),
  }) {
    assert(getArbolesCercanosEvent != null);
    assert(getCoordenadasEvent != null);
    assert(onTapPantalla != null);
    return onTapPantalla(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    Result getCoordenadasEvent(GetCoordenadasEvent value),
    Result onTapPantalla(OnTapPantallaEvent value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (onTapPantalla != null) {
      return onTapPantalla(this);
    }
    return orElse();
  }
}

abstract class OnTapPantallaEvent implements ArbolMapaEvent {
  const factory OnTapPantallaEvent(
      {LatLng tapPosicion,
      ArbolesEntity arboles,
      LatLng localizacion,
      BitmapDescriptor markerIcon,
      BitmapDescriptor markerIconResto}) = _$OnTapPantallaEvent;

  LatLng get tapPosicion;
  ArbolesEntity get arboles;
  LatLng get localizacion;
  BitmapDescriptor get markerIcon;
  BitmapDescriptor get markerIconResto;
  $OnTapPantallaEventCopyWith<OnTapPantallaEvent> get copyWith;
}

/// @nodoc
class _$ArbolMapaStateTearOff {
  const _$ArbolMapaStateTearOff();

// ignore: unused_element
  InitialMapaState initial() {
    return const InitialMapaState();
  }

// ignore: unused_element
  ArbolesCercanosObtenidosMapaState desplegandoArbolesCercanos(
      {@required ArbolesEntity arboles, @required LatLng coordenada}) {
    return ArbolesCercanosObtenidosMapaState(
      arboles: arboles,
      coordenada: coordenada,
    );
  }

// ignore: unused_element
  CoordenadasObtenidasMapaState coordenadasObtenidas(
      {@required LatLng latLng}) {
    return CoordenadasObtenidasMapaState(
      latLng: latLng,
    );
  }

// ignore: unused_element
  FailureMapaState failure({@required String message}) {
    return FailureMapaState(
      message: message,
    );
  }

// ignore: unused_element
  LoadingMapaState loading() {
    return const LoadingMapaState();
  }

// ignore: unused_element
  MapaDesplegadoState mapaDesplegado(
      {@required LatLng latLong,
      ArbolesEntity arboles,
      LatLng tapPosition,
      UserEntity usuario,
      BitmapDescriptor markerIcon,
      BitmapDescriptor markerIconResto}) {
    return MapaDesplegadoState(
      latLong: latLong,
      arboles: arboles,
      tapPosition: tapPosition,
      usuario: usuario,
      markerIcon: markerIcon,
      markerIconResto: markerIconResto,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ArbolMapaState = _$ArbolMapaStateTearOff();

/// @nodoc
mixin _$ArbolMapaState {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required
        Result desplegandoArbolesCercanos(
            ArbolesEntity arboles, LatLng coordenada),
    @required Result coordenadasObtenidas(LatLng latLng),
    @required Result failure(String message),
    @required Result loading(),
    @required
        Result mapaDesplegado(
            LatLng latLong,
            ArbolesEntity arboles,
            LatLng tapPosition,
            UserEntity usuario,
            BitmapDescriptor markerIcon,
            BitmapDescriptor markerIconResto),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result desplegandoArbolesCercanos(ArbolesEntity arboles, LatLng coordenada),
    Result coordenadasObtenidas(LatLng latLng),
    Result failure(String message),
    Result loading(),
    Result mapaDesplegado(
        LatLng latLong,
        ArbolesEntity arboles,
        LatLng tapPosition,
        UserEntity usuario,
        BitmapDescriptor markerIcon,
        BitmapDescriptor markerIconResto),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(InitialMapaState value),
    @required
        Result desplegandoArbolesCercanos(
            ArbolesCercanosObtenidosMapaState value),
    @required Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    @required Result failure(FailureMapaState value),
    @required Result loading(LoadingMapaState value),
    @required Result mapaDesplegado(MapaDesplegadoState value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(InitialMapaState value),
    Result desplegandoArbolesCercanos(ArbolesCercanosObtenidosMapaState value),
    Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    Result failure(FailureMapaState value),
    Result loading(LoadingMapaState value),
    Result mapaDesplegado(MapaDesplegadoState value),
    @required Result orElse(),
  });
}

/// @nodoc
abstract class $ArbolMapaStateCopyWith<$Res> {
  factory $ArbolMapaStateCopyWith(
          ArbolMapaState value, $Res Function(ArbolMapaState) then) =
      _$ArbolMapaStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ArbolMapaStateCopyWithImpl<$Res>
    implements $ArbolMapaStateCopyWith<$Res> {
  _$ArbolMapaStateCopyWithImpl(this._value, this._then);

  final ArbolMapaState _value;
  // ignore: unused_field
  final $Res Function(ArbolMapaState) _then;
}

/// @nodoc
abstract class $InitialMapaStateCopyWith<$Res> {
  factory $InitialMapaStateCopyWith(
          InitialMapaState value, $Res Function(InitialMapaState) then) =
      _$InitialMapaStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$InitialMapaStateCopyWithImpl<$Res>
    extends _$ArbolMapaStateCopyWithImpl<$Res>
    implements $InitialMapaStateCopyWith<$Res> {
  _$InitialMapaStateCopyWithImpl(
      InitialMapaState _value, $Res Function(InitialMapaState) _then)
      : super(_value, (v) => _then(v as InitialMapaState));

  @override
  InitialMapaState get _value => super._value as InitialMapaState;
}

/// @nodoc
class _$InitialMapaState implements InitialMapaState {
  const _$InitialMapaState();

  @override
  String toString() {
    return 'ArbolMapaState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is InitialMapaState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required
        Result desplegandoArbolesCercanos(
            ArbolesEntity arboles, LatLng coordenada),
    @required Result coordenadasObtenidas(LatLng latLng),
    @required Result failure(String message),
    @required Result loading(),
    @required
        Result mapaDesplegado(
            LatLng latLong,
            ArbolesEntity arboles,
            LatLng tapPosition,
            UserEntity usuario,
            BitmapDescriptor markerIcon,
            BitmapDescriptor markerIconResto),
  }) {
    assert(initial != null);
    assert(desplegandoArbolesCercanos != null);
    assert(coordenadasObtenidas != null);
    assert(failure != null);
    assert(loading != null);
    assert(mapaDesplegado != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result desplegandoArbolesCercanos(ArbolesEntity arboles, LatLng coordenada),
    Result coordenadasObtenidas(LatLng latLng),
    Result failure(String message),
    Result loading(),
    Result mapaDesplegado(
        LatLng latLong,
        ArbolesEntity arboles,
        LatLng tapPosition,
        UserEntity usuario,
        BitmapDescriptor markerIcon,
        BitmapDescriptor markerIconResto),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(InitialMapaState value),
    @required
        Result desplegandoArbolesCercanos(
            ArbolesCercanosObtenidosMapaState value),
    @required Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    @required Result failure(FailureMapaState value),
    @required Result loading(LoadingMapaState value),
    @required Result mapaDesplegado(MapaDesplegadoState value),
  }) {
    assert(initial != null);
    assert(desplegandoArbolesCercanos != null);
    assert(coordenadasObtenidas != null);
    assert(failure != null);
    assert(loading != null);
    assert(mapaDesplegado != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(InitialMapaState value),
    Result desplegandoArbolesCercanos(ArbolesCercanosObtenidosMapaState value),
    Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    Result failure(FailureMapaState value),
    Result loading(LoadingMapaState value),
    Result mapaDesplegado(MapaDesplegadoState value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class InitialMapaState implements ArbolMapaState {
  const factory InitialMapaState() = _$InitialMapaState;
}

/// @nodoc
abstract class $ArbolesCercanosObtenidosMapaStateCopyWith<$Res> {
  factory $ArbolesCercanosObtenidosMapaStateCopyWith(
          ArbolesCercanosObtenidosMapaState value,
          $Res Function(ArbolesCercanosObtenidosMapaState) then) =
      _$ArbolesCercanosObtenidosMapaStateCopyWithImpl<$Res>;
  $Res call({ArbolesEntity arboles, LatLng coordenada});
}

/// @nodoc
class _$ArbolesCercanosObtenidosMapaStateCopyWithImpl<$Res>
    extends _$ArbolMapaStateCopyWithImpl<$Res>
    implements $ArbolesCercanosObtenidosMapaStateCopyWith<$Res> {
  _$ArbolesCercanosObtenidosMapaStateCopyWithImpl(
      ArbolesCercanosObtenidosMapaState _value,
      $Res Function(ArbolesCercanosObtenidosMapaState) _then)
      : super(_value, (v) => _then(v as ArbolesCercanosObtenidosMapaState));

  @override
  ArbolesCercanosObtenidosMapaState get _value =>
      super._value as ArbolesCercanosObtenidosMapaState;

  @override
  $Res call({
    Object arboles = freezed,
    Object coordenada = freezed,
  }) {
    return _then(ArbolesCercanosObtenidosMapaState(
      arboles: arboles == freezed ? _value.arboles : arboles as ArbolesEntity,
      coordenada:
          coordenada == freezed ? _value.coordenada : coordenada as LatLng,
    ));
  }
}

/// @nodoc
class _$ArbolesCercanosObtenidosMapaState
    implements ArbolesCercanosObtenidosMapaState {
  const _$ArbolesCercanosObtenidosMapaState(
      {@required this.arboles, @required this.coordenada})
      : assert(arboles != null),
        assert(coordenada != null);

  @override
  final ArbolesEntity arboles;
  @override
  final LatLng coordenada;

  @override
  String toString() {
    return 'ArbolMapaState.desplegandoArbolesCercanos(arboles: $arboles, coordenada: $coordenada)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ArbolesCercanosObtenidosMapaState &&
            (identical(other.arboles, arboles) ||
                const DeepCollectionEquality()
                    .equals(other.arboles, arboles)) &&
            (identical(other.coordenada, coordenada) ||
                const DeepCollectionEquality()
                    .equals(other.coordenada, coordenada)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(arboles) ^
      const DeepCollectionEquality().hash(coordenada);

  @override
  $ArbolesCercanosObtenidosMapaStateCopyWith<ArbolesCercanosObtenidosMapaState>
      get copyWith => _$ArbolesCercanosObtenidosMapaStateCopyWithImpl<
          ArbolesCercanosObtenidosMapaState>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required
        Result desplegandoArbolesCercanos(
            ArbolesEntity arboles, LatLng coordenada),
    @required Result coordenadasObtenidas(LatLng latLng),
    @required Result failure(String message),
    @required Result loading(),
    @required
        Result mapaDesplegado(
            LatLng latLong,
            ArbolesEntity arboles,
            LatLng tapPosition,
            UserEntity usuario,
            BitmapDescriptor markerIcon,
            BitmapDescriptor markerIconResto),
  }) {
    assert(initial != null);
    assert(desplegandoArbolesCercanos != null);
    assert(coordenadasObtenidas != null);
    assert(failure != null);
    assert(loading != null);
    assert(mapaDesplegado != null);
    return desplegandoArbolesCercanos(arboles, coordenada);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result desplegandoArbolesCercanos(ArbolesEntity arboles, LatLng coordenada),
    Result coordenadasObtenidas(LatLng latLng),
    Result failure(String message),
    Result loading(),
    Result mapaDesplegado(
        LatLng latLong,
        ArbolesEntity arboles,
        LatLng tapPosition,
        UserEntity usuario,
        BitmapDescriptor markerIcon,
        BitmapDescriptor markerIconResto),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (desplegandoArbolesCercanos != null) {
      return desplegandoArbolesCercanos(arboles, coordenada);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(InitialMapaState value),
    @required
        Result desplegandoArbolesCercanos(
            ArbolesCercanosObtenidosMapaState value),
    @required Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    @required Result failure(FailureMapaState value),
    @required Result loading(LoadingMapaState value),
    @required Result mapaDesplegado(MapaDesplegadoState value),
  }) {
    assert(initial != null);
    assert(desplegandoArbolesCercanos != null);
    assert(coordenadasObtenidas != null);
    assert(failure != null);
    assert(loading != null);
    assert(mapaDesplegado != null);
    return desplegandoArbolesCercanos(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(InitialMapaState value),
    Result desplegandoArbolesCercanos(ArbolesCercanosObtenidosMapaState value),
    Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    Result failure(FailureMapaState value),
    Result loading(LoadingMapaState value),
    Result mapaDesplegado(MapaDesplegadoState value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (desplegandoArbolesCercanos != null) {
      return desplegandoArbolesCercanos(this);
    }
    return orElse();
  }
}

abstract class ArbolesCercanosObtenidosMapaState implements ArbolMapaState {
  const factory ArbolesCercanosObtenidosMapaState(
      {@required ArbolesEntity arboles,
      @required LatLng coordenada}) = _$ArbolesCercanosObtenidosMapaState;

  ArbolesEntity get arboles;
  LatLng get coordenada;
  $ArbolesCercanosObtenidosMapaStateCopyWith<ArbolesCercanosObtenidosMapaState>
      get copyWith;
}

/// @nodoc
abstract class $CoordenadasObtenidasMapaStateCopyWith<$Res> {
  factory $CoordenadasObtenidasMapaStateCopyWith(
          CoordenadasObtenidasMapaState value,
          $Res Function(CoordenadasObtenidasMapaState) then) =
      _$CoordenadasObtenidasMapaStateCopyWithImpl<$Res>;
  $Res call({LatLng latLng});
}

/// @nodoc
class _$CoordenadasObtenidasMapaStateCopyWithImpl<$Res>
    extends _$ArbolMapaStateCopyWithImpl<$Res>
    implements $CoordenadasObtenidasMapaStateCopyWith<$Res> {
  _$CoordenadasObtenidasMapaStateCopyWithImpl(
      CoordenadasObtenidasMapaState _value,
      $Res Function(CoordenadasObtenidasMapaState) _then)
      : super(_value, (v) => _then(v as CoordenadasObtenidasMapaState));

  @override
  CoordenadasObtenidasMapaState get _value =>
      super._value as CoordenadasObtenidasMapaState;

  @override
  $Res call({
    Object latLng = freezed,
  }) {
    return _then(CoordenadasObtenidasMapaState(
      latLng: latLng == freezed ? _value.latLng : latLng as LatLng,
    ));
  }
}

/// @nodoc
class _$CoordenadasObtenidasMapaState implements CoordenadasObtenidasMapaState {
  const _$CoordenadasObtenidasMapaState({@required this.latLng})
      : assert(latLng != null);

  @override
  final LatLng latLng;

  @override
  String toString() {
    return 'ArbolMapaState.coordenadasObtenidas(latLng: $latLng)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CoordenadasObtenidasMapaState &&
            (identical(other.latLng, latLng) ||
                const DeepCollectionEquality().equals(other.latLng, latLng)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(latLng);

  @override
  $CoordenadasObtenidasMapaStateCopyWith<CoordenadasObtenidasMapaState>
      get copyWith => _$CoordenadasObtenidasMapaStateCopyWithImpl<
          CoordenadasObtenidasMapaState>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required
        Result desplegandoArbolesCercanos(
            ArbolesEntity arboles, LatLng coordenada),
    @required Result coordenadasObtenidas(LatLng latLng),
    @required Result failure(String message),
    @required Result loading(),
    @required
        Result mapaDesplegado(
            LatLng latLong,
            ArbolesEntity arboles,
            LatLng tapPosition,
            UserEntity usuario,
            BitmapDescriptor markerIcon,
            BitmapDescriptor markerIconResto),
  }) {
    assert(initial != null);
    assert(desplegandoArbolesCercanos != null);
    assert(coordenadasObtenidas != null);
    assert(failure != null);
    assert(loading != null);
    assert(mapaDesplegado != null);
    return coordenadasObtenidas(latLng);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result desplegandoArbolesCercanos(ArbolesEntity arboles, LatLng coordenada),
    Result coordenadasObtenidas(LatLng latLng),
    Result failure(String message),
    Result loading(),
    Result mapaDesplegado(
        LatLng latLong,
        ArbolesEntity arboles,
        LatLng tapPosition,
        UserEntity usuario,
        BitmapDescriptor markerIcon,
        BitmapDescriptor markerIconResto),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (coordenadasObtenidas != null) {
      return coordenadasObtenidas(latLng);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(InitialMapaState value),
    @required
        Result desplegandoArbolesCercanos(
            ArbolesCercanosObtenidosMapaState value),
    @required Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    @required Result failure(FailureMapaState value),
    @required Result loading(LoadingMapaState value),
    @required Result mapaDesplegado(MapaDesplegadoState value),
  }) {
    assert(initial != null);
    assert(desplegandoArbolesCercanos != null);
    assert(coordenadasObtenidas != null);
    assert(failure != null);
    assert(loading != null);
    assert(mapaDesplegado != null);
    return coordenadasObtenidas(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(InitialMapaState value),
    Result desplegandoArbolesCercanos(ArbolesCercanosObtenidosMapaState value),
    Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    Result failure(FailureMapaState value),
    Result loading(LoadingMapaState value),
    Result mapaDesplegado(MapaDesplegadoState value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (coordenadasObtenidas != null) {
      return coordenadasObtenidas(this);
    }
    return orElse();
  }
}

abstract class CoordenadasObtenidasMapaState implements ArbolMapaState {
  const factory CoordenadasObtenidasMapaState({@required LatLng latLng}) =
      _$CoordenadasObtenidasMapaState;

  LatLng get latLng;
  $CoordenadasObtenidasMapaStateCopyWith<CoordenadasObtenidasMapaState>
      get copyWith;
}

/// @nodoc
abstract class $FailureMapaStateCopyWith<$Res> {
  factory $FailureMapaStateCopyWith(
          FailureMapaState value, $Res Function(FailureMapaState) then) =
      _$FailureMapaStateCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$FailureMapaStateCopyWithImpl<$Res>
    extends _$ArbolMapaStateCopyWithImpl<$Res>
    implements $FailureMapaStateCopyWith<$Res> {
  _$FailureMapaStateCopyWithImpl(
      FailureMapaState _value, $Res Function(FailureMapaState) _then)
      : super(_value, (v) => _then(v as FailureMapaState));

  @override
  FailureMapaState get _value => super._value as FailureMapaState;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(FailureMapaState(
      message: message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$FailureMapaState implements FailureMapaState {
  const _$FailureMapaState({@required this.message}) : assert(message != null);

  @override
  final String message;

  @override
  String toString() {
    return 'ArbolMapaState.failure(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FailureMapaState &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @override
  $FailureMapaStateCopyWith<FailureMapaState> get copyWith =>
      _$FailureMapaStateCopyWithImpl<FailureMapaState>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required
        Result desplegandoArbolesCercanos(
            ArbolesEntity arboles, LatLng coordenada),
    @required Result coordenadasObtenidas(LatLng latLng),
    @required Result failure(String message),
    @required Result loading(),
    @required
        Result mapaDesplegado(
            LatLng latLong,
            ArbolesEntity arboles,
            LatLng tapPosition,
            UserEntity usuario,
            BitmapDescriptor markerIcon,
            BitmapDescriptor markerIconResto),
  }) {
    assert(initial != null);
    assert(desplegandoArbolesCercanos != null);
    assert(coordenadasObtenidas != null);
    assert(failure != null);
    assert(loading != null);
    assert(mapaDesplegado != null);
    return failure(message);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result desplegandoArbolesCercanos(ArbolesEntity arboles, LatLng coordenada),
    Result coordenadasObtenidas(LatLng latLng),
    Result failure(String message),
    Result loading(),
    Result mapaDesplegado(
        LatLng latLong,
        ArbolesEntity arboles,
        LatLng tapPosition,
        UserEntity usuario,
        BitmapDescriptor markerIcon,
        BitmapDescriptor markerIconResto),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (failure != null) {
      return failure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(InitialMapaState value),
    @required
        Result desplegandoArbolesCercanos(
            ArbolesCercanosObtenidosMapaState value),
    @required Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    @required Result failure(FailureMapaState value),
    @required Result loading(LoadingMapaState value),
    @required Result mapaDesplegado(MapaDesplegadoState value),
  }) {
    assert(initial != null);
    assert(desplegandoArbolesCercanos != null);
    assert(coordenadasObtenidas != null);
    assert(failure != null);
    assert(loading != null);
    assert(mapaDesplegado != null);
    return failure(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(InitialMapaState value),
    Result desplegandoArbolesCercanos(ArbolesCercanosObtenidosMapaState value),
    Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    Result failure(FailureMapaState value),
    Result loading(LoadingMapaState value),
    Result mapaDesplegado(MapaDesplegadoState value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class FailureMapaState implements ArbolMapaState {
  const factory FailureMapaState({@required String message}) =
      _$FailureMapaState;

  String get message;
  $FailureMapaStateCopyWith<FailureMapaState> get copyWith;
}

/// @nodoc
abstract class $LoadingMapaStateCopyWith<$Res> {
  factory $LoadingMapaStateCopyWith(
          LoadingMapaState value, $Res Function(LoadingMapaState) then) =
      _$LoadingMapaStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadingMapaStateCopyWithImpl<$Res>
    extends _$ArbolMapaStateCopyWithImpl<$Res>
    implements $LoadingMapaStateCopyWith<$Res> {
  _$LoadingMapaStateCopyWithImpl(
      LoadingMapaState _value, $Res Function(LoadingMapaState) _then)
      : super(_value, (v) => _then(v as LoadingMapaState));

  @override
  LoadingMapaState get _value => super._value as LoadingMapaState;
}

/// @nodoc
class _$LoadingMapaState implements LoadingMapaState {
  const _$LoadingMapaState();

  @override
  String toString() {
    return 'ArbolMapaState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is LoadingMapaState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required
        Result desplegandoArbolesCercanos(
            ArbolesEntity arboles, LatLng coordenada),
    @required Result coordenadasObtenidas(LatLng latLng),
    @required Result failure(String message),
    @required Result loading(),
    @required
        Result mapaDesplegado(
            LatLng latLong,
            ArbolesEntity arboles,
            LatLng tapPosition,
            UserEntity usuario,
            BitmapDescriptor markerIcon,
            BitmapDescriptor markerIconResto),
  }) {
    assert(initial != null);
    assert(desplegandoArbolesCercanos != null);
    assert(coordenadasObtenidas != null);
    assert(failure != null);
    assert(loading != null);
    assert(mapaDesplegado != null);
    return loading();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result desplegandoArbolesCercanos(ArbolesEntity arboles, LatLng coordenada),
    Result coordenadasObtenidas(LatLng latLng),
    Result failure(String message),
    Result loading(),
    Result mapaDesplegado(
        LatLng latLong,
        ArbolesEntity arboles,
        LatLng tapPosition,
        UserEntity usuario,
        BitmapDescriptor markerIcon,
        BitmapDescriptor markerIconResto),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(InitialMapaState value),
    @required
        Result desplegandoArbolesCercanos(
            ArbolesCercanosObtenidosMapaState value),
    @required Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    @required Result failure(FailureMapaState value),
    @required Result loading(LoadingMapaState value),
    @required Result mapaDesplegado(MapaDesplegadoState value),
  }) {
    assert(initial != null);
    assert(desplegandoArbolesCercanos != null);
    assert(coordenadasObtenidas != null);
    assert(failure != null);
    assert(loading != null);
    assert(mapaDesplegado != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(InitialMapaState value),
    Result desplegandoArbolesCercanos(ArbolesCercanosObtenidosMapaState value),
    Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    Result failure(FailureMapaState value),
    Result loading(LoadingMapaState value),
    Result mapaDesplegado(MapaDesplegadoState value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingMapaState implements ArbolMapaState {
  const factory LoadingMapaState() = _$LoadingMapaState;
}

/// @nodoc
abstract class $MapaDesplegadoStateCopyWith<$Res> {
  factory $MapaDesplegadoStateCopyWith(
          MapaDesplegadoState value, $Res Function(MapaDesplegadoState) then) =
      _$MapaDesplegadoStateCopyWithImpl<$Res>;
  $Res call(
      {LatLng latLong,
      ArbolesEntity arboles,
      LatLng tapPosition,
      UserEntity usuario,
      BitmapDescriptor markerIcon,
      BitmapDescriptor markerIconResto});
}

/// @nodoc
class _$MapaDesplegadoStateCopyWithImpl<$Res>
    extends _$ArbolMapaStateCopyWithImpl<$Res>
    implements $MapaDesplegadoStateCopyWith<$Res> {
  _$MapaDesplegadoStateCopyWithImpl(
      MapaDesplegadoState _value, $Res Function(MapaDesplegadoState) _then)
      : super(_value, (v) => _then(v as MapaDesplegadoState));

  @override
  MapaDesplegadoState get _value => super._value as MapaDesplegadoState;

  @override
  $Res call({
    Object latLong = freezed,
    Object arboles = freezed,
    Object tapPosition = freezed,
    Object usuario = freezed,
    Object markerIcon = freezed,
    Object markerIconResto = freezed,
  }) {
    return _then(MapaDesplegadoState(
      latLong: latLong == freezed ? _value.latLong : latLong as LatLng,
      arboles: arboles == freezed ? _value.arboles : arboles as ArbolesEntity,
      tapPosition:
          tapPosition == freezed ? _value.tapPosition : tapPosition as LatLng,
      usuario: usuario == freezed ? _value.usuario : usuario as UserEntity,
      markerIcon: markerIcon == freezed
          ? _value.markerIcon
          : markerIcon as BitmapDescriptor,
      markerIconResto: markerIconResto == freezed
          ? _value.markerIconResto
          : markerIconResto as BitmapDescriptor,
    ));
  }
}

/// @nodoc
class _$MapaDesplegadoState implements MapaDesplegadoState {
  const _$MapaDesplegadoState(
      {@required this.latLong,
      this.arboles,
      this.tapPosition,
      this.usuario,
      this.markerIcon,
      this.markerIconResto})
      : assert(latLong != null);

  @override
  final LatLng latLong;
  @override
  final ArbolesEntity arboles;
  @override
  final LatLng tapPosition;
  @override
  final UserEntity usuario;
  @override
  final BitmapDescriptor markerIcon;
  @override
  final BitmapDescriptor markerIconResto;

  @override
  String toString() {
    return 'ArbolMapaState.mapaDesplegado(latLong: $latLong, arboles: $arboles, tapPosition: $tapPosition, usuario: $usuario, markerIcon: $markerIcon, markerIconResto: $markerIconResto)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MapaDesplegadoState &&
            (identical(other.latLong, latLong) ||
                const DeepCollectionEquality()
                    .equals(other.latLong, latLong)) &&
            (identical(other.arboles, arboles) ||
                const DeepCollectionEquality()
                    .equals(other.arboles, arboles)) &&
            (identical(other.tapPosition, tapPosition) ||
                const DeepCollectionEquality()
                    .equals(other.tapPosition, tapPosition)) &&
            (identical(other.usuario, usuario) ||
                const DeepCollectionEquality()
                    .equals(other.usuario, usuario)) &&
            (identical(other.markerIcon, markerIcon) ||
                const DeepCollectionEquality()
                    .equals(other.markerIcon, markerIcon)) &&
            (identical(other.markerIconResto, markerIconResto) ||
                const DeepCollectionEquality()
                    .equals(other.markerIconResto, markerIconResto)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(latLong) ^
      const DeepCollectionEquality().hash(arboles) ^
      const DeepCollectionEquality().hash(tapPosition) ^
      const DeepCollectionEquality().hash(usuario) ^
      const DeepCollectionEquality().hash(markerIcon) ^
      const DeepCollectionEquality().hash(markerIconResto);

  @override
  $MapaDesplegadoStateCopyWith<MapaDesplegadoState> get copyWith =>
      _$MapaDesplegadoStateCopyWithImpl<MapaDesplegadoState>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required
        Result desplegandoArbolesCercanos(
            ArbolesEntity arboles, LatLng coordenada),
    @required Result coordenadasObtenidas(LatLng latLng),
    @required Result failure(String message),
    @required Result loading(),
    @required
        Result mapaDesplegado(
            LatLng latLong,
            ArbolesEntity arboles,
            LatLng tapPosition,
            UserEntity usuario,
            BitmapDescriptor markerIcon,
            BitmapDescriptor markerIconResto),
  }) {
    assert(initial != null);
    assert(desplegandoArbolesCercanos != null);
    assert(coordenadasObtenidas != null);
    assert(failure != null);
    assert(loading != null);
    assert(mapaDesplegado != null);
    return mapaDesplegado(
        latLong, arboles, tapPosition, usuario, markerIcon, markerIconResto);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result desplegandoArbolesCercanos(ArbolesEntity arboles, LatLng coordenada),
    Result coordenadasObtenidas(LatLng latLng),
    Result failure(String message),
    Result loading(),
    Result mapaDesplegado(
        LatLng latLong,
        ArbolesEntity arboles,
        LatLng tapPosition,
        UserEntity usuario,
        BitmapDescriptor markerIcon,
        BitmapDescriptor markerIconResto),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (mapaDesplegado != null) {
      return mapaDesplegado(
          latLong, arboles, tapPosition, usuario, markerIcon, markerIconResto);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(InitialMapaState value),
    @required
        Result desplegandoArbolesCercanos(
            ArbolesCercanosObtenidosMapaState value),
    @required Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    @required Result failure(FailureMapaState value),
    @required Result loading(LoadingMapaState value),
    @required Result mapaDesplegado(MapaDesplegadoState value),
  }) {
    assert(initial != null);
    assert(desplegandoArbolesCercanos != null);
    assert(coordenadasObtenidas != null);
    assert(failure != null);
    assert(loading != null);
    assert(mapaDesplegado != null);
    return mapaDesplegado(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(InitialMapaState value),
    Result desplegandoArbolesCercanos(ArbolesCercanosObtenidosMapaState value),
    Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    Result failure(FailureMapaState value),
    Result loading(LoadingMapaState value),
    Result mapaDesplegado(MapaDesplegadoState value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (mapaDesplegado != null) {
      return mapaDesplegado(this);
    }
    return orElse();
  }
}

abstract class MapaDesplegadoState implements ArbolMapaState {
  const factory MapaDesplegadoState(
      {@required LatLng latLong,
      ArbolesEntity arboles,
      LatLng tapPosition,
      UserEntity usuario,
      BitmapDescriptor markerIcon,
      BitmapDescriptor markerIconResto}) = _$MapaDesplegadoState;

  LatLng get latLong;
  ArbolesEntity get arboles;
  LatLng get tapPosition;
  UserEntity get usuario;
  BitmapDescriptor get markerIcon;
  BitmapDescriptor get markerIconResto;
  $MapaDesplegadoStateCopyWith<MapaDesplegadoState> get copyWith;
}
