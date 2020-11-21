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
  ComprobarIdNfacEvent comprobarIdNfcEvent(String idNfc) {
    return ComprobarIdNfacEvent(
      idNfc,
    );
  }

// ignore: unused_element
  GetArbolesCercanosEvent getArbolesCercanosEvent(String coordenadas) {
    return GetArbolesCercanosEvent(
      coordenadas,
    );
  }

// ignore: unused_element
  GetCoordenadasEvent getCoordenadasEvent() {
    return const GetCoordenadasEvent();
  }

// ignore: unused_element
  LeerIdNfConTelefonoEvent leerIdNfConTelefonoEvent(UserEntity usuario) {
    return LeerIdNfConTelefonoEvent(
      usuario,
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
    @required Result comprobarIdNfcEvent(String idNfc),
    @required Result getArbolesCercanosEvent(String coordenadas),
    @required Result getCoordenadasEvent(),
    @required Result leerIdNfConTelefonoEvent(UserEntity usuario),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result comprobarIdNfcEvent(String idNfc),
    Result getArbolesCercanosEvent(String coordenadas),
    Result getCoordenadasEvent(),
    Result leerIdNfConTelefonoEvent(UserEntity usuario),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result comprobarIdNfcEvent(ComprobarIdNfacEvent value),
    @required Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    @required Result getCoordenadasEvent(GetCoordenadasEvent value),
    @required Result leerIdNfConTelefonoEvent(LeerIdNfConTelefonoEvent value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result comprobarIdNfcEvent(ComprobarIdNfacEvent value),
    Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    Result getCoordenadasEvent(GetCoordenadasEvent value),
    Result leerIdNfConTelefonoEvent(LeerIdNfConTelefonoEvent value),
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
abstract class $ComprobarIdNfacEventCopyWith<$Res> {
  factory $ComprobarIdNfacEventCopyWith(ComprobarIdNfacEvent value,
          $Res Function(ComprobarIdNfacEvent) then) =
      _$ComprobarIdNfacEventCopyWithImpl<$Res>;
  $Res call({String idNfc});
}

/// @nodoc
class _$ComprobarIdNfacEventCopyWithImpl<$Res>
    extends _$ArbolMapaEventCopyWithImpl<$Res>
    implements $ComprobarIdNfacEventCopyWith<$Res> {
  _$ComprobarIdNfacEventCopyWithImpl(
      ComprobarIdNfacEvent _value, $Res Function(ComprobarIdNfacEvent) _then)
      : super(_value, (v) => _then(v as ComprobarIdNfacEvent));

  @override
  ComprobarIdNfacEvent get _value => super._value as ComprobarIdNfacEvent;

  @override
  $Res call({
    Object idNfc = freezed,
  }) {
    return _then(ComprobarIdNfacEvent(
      idNfc == freezed ? _value.idNfc : idNfc as String,
    ));
  }
}

/// @nodoc
class _$ComprobarIdNfacEvent implements ComprobarIdNfacEvent {
  const _$ComprobarIdNfacEvent(this.idNfc) : assert(idNfc != null);

  @override
  final String idNfc;

  @override
  String toString() {
    return 'ArbolMapaEvent.comprobarIdNfcEvent(idNfc: $idNfc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ComprobarIdNfacEvent &&
            (identical(other.idNfc, idNfc) ||
                const DeepCollectionEquality().equals(other.idNfc, idNfc)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(idNfc);

  @override
  $ComprobarIdNfacEventCopyWith<ComprobarIdNfacEvent> get copyWith =>
      _$ComprobarIdNfacEventCopyWithImpl<ComprobarIdNfacEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result comprobarIdNfcEvent(String idNfc),
    @required Result getArbolesCercanosEvent(String coordenadas),
    @required Result getCoordenadasEvent(),
    @required Result leerIdNfConTelefonoEvent(UserEntity usuario),
  }) {
    assert(comprobarIdNfcEvent != null);
    assert(getArbolesCercanosEvent != null);
    assert(getCoordenadasEvent != null);
    assert(leerIdNfConTelefonoEvent != null);
    return comprobarIdNfcEvent(idNfc);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result comprobarIdNfcEvent(String idNfc),
    Result getArbolesCercanosEvent(String coordenadas),
    Result getCoordenadasEvent(),
    Result leerIdNfConTelefonoEvent(UserEntity usuario),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (comprobarIdNfcEvent != null) {
      return comprobarIdNfcEvent(idNfc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result comprobarIdNfcEvent(ComprobarIdNfacEvent value),
    @required Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    @required Result getCoordenadasEvent(GetCoordenadasEvent value),
    @required Result leerIdNfConTelefonoEvent(LeerIdNfConTelefonoEvent value),
  }) {
    assert(comprobarIdNfcEvent != null);
    assert(getArbolesCercanosEvent != null);
    assert(getCoordenadasEvent != null);
    assert(leerIdNfConTelefonoEvent != null);
    return comprobarIdNfcEvent(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result comprobarIdNfcEvent(ComprobarIdNfacEvent value),
    Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    Result getCoordenadasEvent(GetCoordenadasEvent value),
    Result leerIdNfConTelefonoEvent(LeerIdNfConTelefonoEvent value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (comprobarIdNfcEvent != null) {
      return comprobarIdNfcEvent(this);
    }
    return orElse();
  }
}

abstract class ComprobarIdNfacEvent implements ArbolMapaEvent {
  const factory ComprobarIdNfacEvent(String idNfc) = _$ComprobarIdNfacEvent;

  String get idNfc;
  $ComprobarIdNfacEventCopyWith<ComprobarIdNfacEvent> get copyWith;
}

/// @nodoc
abstract class $GetArbolesCercanosEventCopyWith<$Res> {
  factory $GetArbolesCercanosEventCopyWith(GetArbolesCercanosEvent value,
          $Res Function(GetArbolesCercanosEvent) then) =
      _$GetArbolesCercanosEventCopyWithImpl<$Res>;
  $Res call({String coordenadas});
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
  }) {
    return _then(GetArbolesCercanosEvent(
      coordenadas == freezed ? _value.coordenadas : coordenadas as String,
    ));
  }
}

/// @nodoc
class _$GetArbolesCercanosEvent implements GetArbolesCercanosEvent {
  const _$GetArbolesCercanosEvent(this.coordenadas)
      : assert(coordenadas != null);

  @override
  final String coordenadas;

  @override
  String toString() {
    return 'ArbolMapaEvent.getArbolesCercanosEvent(coordenadas: $coordenadas)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetArbolesCercanosEvent &&
            (identical(other.coordenadas, coordenadas) ||
                const DeepCollectionEquality()
                    .equals(other.coordenadas, coordenadas)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(coordenadas);

  @override
  $GetArbolesCercanosEventCopyWith<GetArbolesCercanosEvent> get copyWith =>
      _$GetArbolesCercanosEventCopyWithImpl<GetArbolesCercanosEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result comprobarIdNfcEvent(String idNfc),
    @required Result getArbolesCercanosEvent(String coordenadas),
    @required Result getCoordenadasEvent(),
    @required Result leerIdNfConTelefonoEvent(UserEntity usuario),
  }) {
    assert(comprobarIdNfcEvent != null);
    assert(getArbolesCercanosEvent != null);
    assert(getCoordenadasEvent != null);
    assert(leerIdNfConTelefonoEvent != null);
    return getArbolesCercanosEvent(coordenadas);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result comprobarIdNfcEvent(String idNfc),
    Result getArbolesCercanosEvent(String coordenadas),
    Result getCoordenadasEvent(),
    Result leerIdNfConTelefonoEvent(UserEntity usuario),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (getArbolesCercanosEvent != null) {
      return getArbolesCercanosEvent(coordenadas);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result comprobarIdNfcEvent(ComprobarIdNfacEvent value),
    @required Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    @required Result getCoordenadasEvent(GetCoordenadasEvent value),
    @required Result leerIdNfConTelefonoEvent(LeerIdNfConTelefonoEvent value),
  }) {
    assert(comprobarIdNfcEvent != null);
    assert(getArbolesCercanosEvent != null);
    assert(getCoordenadasEvent != null);
    assert(leerIdNfConTelefonoEvent != null);
    return getArbolesCercanosEvent(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result comprobarIdNfcEvent(ComprobarIdNfacEvent value),
    Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    Result getCoordenadasEvent(GetCoordenadasEvent value),
    Result leerIdNfConTelefonoEvent(LeerIdNfConTelefonoEvent value),
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
  const factory GetArbolesCercanosEvent(String coordenadas) =
      _$GetArbolesCercanosEvent;

  String get coordenadas;
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
    @required Result comprobarIdNfcEvent(String idNfc),
    @required Result getArbolesCercanosEvent(String coordenadas),
    @required Result getCoordenadasEvent(),
    @required Result leerIdNfConTelefonoEvent(UserEntity usuario),
  }) {
    assert(comprobarIdNfcEvent != null);
    assert(getArbolesCercanosEvent != null);
    assert(getCoordenadasEvent != null);
    assert(leerIdNfConTelefonoEvent != null);
    return getCoordenadasEvent();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result comprobarIdNfcEvent(String idNfc),
    Result getArbolesCercanosEvent(String coordenadas),
    Result getCoordenadasEvent(),
    Result leerIdNfConTelefonoEvent(UserEntity usuario),
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
    @required Result comprobarIdNfcEvent(ComprobarIdNfacEvent value),
    @required Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    @required Result getCoordenadasEvent(GetCoordenadasEvent value),
    @required Result leerIdNfConTelefonoEvent(LeerIdNfConTelefonoEvent value),
  }) {
    assert(comprobarIdNfcEvent != null);
    assert(getArbolesCercanosEvent != null);
    assert(getCoordenadasEvent != null);
    assert(leerIdNfConTelefonoEvent != null);
    return getCoordenadasEvent(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result comprobarIdNfcEvent(ComprobarIdNfacEvent value),
    Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    Result getCoordenadasEvent(GetCoordenadasEvent value),
    Result leerIdNfConTelefonoEvent(LeerIdNfConTelefonoEvent value),
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
abstract class $LeerIdNfConTelefonoEventCopyWith<$Res> {
  factory $LeerIdNfConTelefonoEventCopyWith(LeerIdNfConTelefonoEvent value,
          $Res Function(LeerIdNfConTelefonoEvent) then) =
      _$LeerIdNfConTelefonoEventCopyWithImpl<$Res>;
  $Res call({UserEntity usuario});
}

/// @nodoc
class _$LeerIdNfConTelefonoEventCopyWithImpl<$Res>
    extends _$ArbolMapaEventCopyWithImpl<$Res>
    implements $LeerIdNfConTelefonoEventCopyWith<$Res> {
  _$LeerIdNfConTelefonoEventCopyWithImpl(LeerIdNfConTelefonoEvent _value,
      $Res Function(LeerIdNfConTelefonoEvent) _then)
      : super(_value, (v) => _then(v as LeerIdNfConTelefonoEvent));

  @override
  LeerIdNfConTelefonoEvent get _value =>
      super._value as LeerIdNfConTelefonoEvent;

  @override
  $Res call({
    Object usuario = freezed,
  }) {
    return _then(LeerIdNfConTelefonoEvent(
      usuario == freezed ? _value.usuario : usuario as UserEntity,
    ));
  }
}

/// @nodoc
class _$LeerIdNfConTelefonoEvent implements LeerIdNfConTelefonoEvent {
  const _$LeerIdNfConTelefonoEvent(this.usuario) : assert(usuario != null);

  @override
  final UserEntity usuario;

  @override
  String toString() {
    return 'ArbolMapaEvent.leerIdNfConTelefonoEvent(usuario: $usuario)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LeerIdNfConTelefonoEvent &&
            (identical(other.usuario, usuario) ||
                const DeepCollectionEquality().equals(other.usuario, usuario)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(usuario);

  @override
  $LeerIdNfConTelefonoEventCopyWith<LeerIdNfConTelefonoEvent> get copyWith =>
      _$LeerIdNfConTelefonoEventCopyWithImpl<LeerIdNfConTelefonoEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result comprobarIdNfcEvent(String idNfc),
    @required Result getArbolesCercanosEvent(String coordenadas),
    @required Result getCoordenadasEvent(),
    @required Result leerIdNfConTelefonoEvent(UserEntity usuario),
  }) {
    assert(comprobarIdNfcEvent != null);
    assert(getArbolesCercanosEvent != null);
    assert(getCoordenadasEvent != null);
    assert(leerIdNfConTelefonoEvent != null);
    return leerIdNfConTelefonoEvent(usuario);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result comprobarIdNfcEvent(String idNfc),
    Result getArbolesCercanosEvent(String coordenadas),
    Result getCoordenadasEvent(),
    Result leerIdNfConTelefonoEvent(UserEntity usuario),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (leerIdNfConTelefonoEvent != null) {
      return leerIdNfConTelefonoEvent(usuario);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result comprobarIdNfcEvent(ComprobarIdNfacEvent value),
    @required Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    @required Result getCoordenadasEvent(GetCoordenadasEvent value),
    @required Result leerIdNfConTelefonoEvent(LeerIdNfConTelefonoEvent value),
  }) {
    assert(comprobarIdNfcEvent != null);
    assert(getArbolesCercanosEvent != null);
    assert(getCoordenadasEvent != null);
    assert(leerIdNfConTelefonoEvent != null);
    return leerIdNfConTelefonoEvent(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result comprobarIdNfcEvent(ComprobarIdNfacEvent value),
    Result getArbolesCercanosEvent(GetArbolesCercanosEvent value),
    Result getCoordenadasEvent(GetCoordenadasEvent value),
    Result leerIdNfConTelefonoEvent(LeerIdNfConTelefonoEvent value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (leerIdNfConTelefonoEvent != null) {
      return leerIdNfConTelefonoEvent(this);
    }
    return orElse();
  }
}

abstract class LeerIdNfConTelefonoEvent implements ArbolMapaEvent {
  const factory LeerIdNfConTelefonoEvent(UserEntity usuario) =
      _$LeerIdNfConTelefonoEvent;

  UserEntity get usuario;
  $LeerIdNfConTelefonoEventCopyWith<LeerIdNfConTelefonoEvent> get copyWith;
}

/// @nodoc
class _$ArbolMapaStateTearOff {
  const _$ArbolMapaStateTearOff();

// ignore: unused_element
  InitialMapaState initial() {
    return const InitialMapaState();
  }

// ignore: unused_element
  ArbolesCercanosObtenidosMapaState arbolesCercanosObtenidos(
      {@required ArbolesEntity arboles}) {
    return ArbolesCercanosObtenidosMapaState(
      arboles: arboles,
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
  IdNfcObtenidoMapaState idNfcObtenido({@required NfcEntity nfcEntity}) {
    return IdNfcObtenidoMapaState(
      nfcEntity: nfcEntity,
    );
  }

// ignore: unused_element
  IdNfcChequeadoMapaState idNfcChequeado({@required bool existe}) {
    return IdNfcChequeadoMapaState(
      existe: existe,
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
}

/// @nodoc
// ignore: unused_element
const $ArbolMapaState = _$ArbolMapaStateTearOff();

/// @nodoc
mixin _$ArbolMapaState {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result arbolesCercanosObtenidos(ArbolesEntity arboles),
    @required Result coordenadasObtenidas(LatLng latLng),
    @required Result idNfcObtenido(NfcEntity nfcEntity),
    @required Result idNfcChequeado(bool existe),
    @required Result failure(String message),
    @required Result loading(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result arbolesCercanosObtenidos(ArbolesEntity arboles),
    Result coordenadasObtenidas(LatLng latLng),
    Result idNfcObtenido(NfcEntity nfcEntity),
    Result idNfcChequeado(bool existe),
    Result failure(String message),
    Result loading(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(InitialMapaState value),
    @required
        Result arbolesCercanosObtenidos(
            ArbolesCercanosObtenidosMapaState value),
    @required Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    @required Result idNfcObtenido(IdNfcObtenidoMapaState value),
    @required Result idNfcChequeado(IdNfcChequeadoMapaState value),
    @required Result failure(FailureMapaState value),
    @required Result loading(LoadingMapaState value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(InitialMapaState value),
    Result arbolesCercanosObtenidos(ArbolesCercanosObtenidosMapaState value),
    Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    Result idNfcObtenido(IdNfcObtenidoMapaState value),
    Result idNfcChequeado(IdNfcChequeadoMapaState value),
    Result failure(FailureMapaState value),
    Result loading(LoadingMapaState value),
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
    @required Result arbolesCercanosObtenidos(ArbolesEntity arboles),
    @required Result coordenadasObtenidas(LatLng latLng),
    @required Result idNfcObtenido(NfcEntity nfcEntity),
    @required Result idNfcChequeado(bool existe),
    @required Result failure(String message),
    @required Result loading(),
  }) {
    assert(initial != null);
    assert(arbolesCercanosObtenidos != null);
    assert(coordenadasObtenidas != null);
    assert(idNfcObtenido != null);
    assert(idNfcChequeado != null);
    assert(failure != null);
    assert(loading != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result arbolesCercanosObtenidos(ArbolesEntity arboles),
    Result coordenadasObtenidas(LatLng latLng),
    Result idNfcObtenido(NfcEntity nfcEntity),
    Result idNfcChequeado(bool existe),
    Result failure(String message),
    Result loading(),
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
        Result arbolesCercanosObtenidos(
            ArbolesCercanosObtenidosMapaState value),
    @required Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    @required Result idNfcObtenido(IdNfcObtenidoMapaState value),
    @required Result idNfcChequeado(IdNfcChequeadoMapaState value),
    @required Result failure(FailureMapaState value),
    @required Result loading(LoadingMapaState value),
  }) {
    assert(initial != null);
    assert(arbolesCercanosObtenidos != null);
    assert(coordenadasObtenidas != null);
    assert(idNfcObtenido != null);
    assert(idNfcChequeado != null);
    assert(failure != null);
    assert(loading != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(InitialMapaState value),
    Result arbolesCercanosObtenidos(ArbolesCercanosObtenidosMapaState value),
    Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    Result idNfcObtenido(IdNfcObtenidoMapaState value),
    Result idNfcChequeado(IdNfcChequeadoMapaState value),
    Result failure(FailureMapaState value),
    Result loading(LoadingMapaState value),
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
  $Res call({ArbolesEntity arboles});
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
  }) {
    return _then(ArbolesCercanosObtenidosMapaState(
      arboles: arboles == freezed ? _value.arboles : arboles as ArbolesEntity,
    ));
  }
}

/// @nodoc
class _$ArbolesCercanosObtenidosMapaState
    implements ArbolesCercanosObtenidosMapaState {
  const _$ArbolesCercanosObtenidosMapaState({@required this.arboles})
      : assert(arboles != null);

  @override
  final ArbolesEntity arboles;

  @override
  String toString() {
    return 'ArbolMapaState.arbolesCercanosObtenidos(arboles: $arboles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ArbolesCercanosObtenidosMapaState &&
            (identical(other.arboles, arboles) ||
                const DeepCollectionEquality().equals(other.arboles, arboles)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(arboles);

  @override
  $ArbolesCercanosObtenidosMapaStateCopyWith<ArbolesCercanosObtenidosMapaState>
      get copyWith => _$ArbolesCercanosObtenidosMapaStateCopyWithImpl<
          ArbolesCercanosObtenidosMapaState>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result arbolesCercanosObtenidos(ArbolesEntity arboles),
    @required Result coordenadasObtenidas(LatLng latLng),
    @required Result idNfcObtenido(NfcEntity nfcEntity),
    @required Result idNfcChequeado(bool existe),
    @required Result failure(String message),
    @required Result loading(),
  }) {
    assert(initial != null);
    assert(arbolesCercanosObtenidos != null);
    assert(coordenadasObtenidas != null);
    assert(idNfcObtenido != null);
    assert(idNfcChequeado != null);
    assert(failure != null);
    assert(loading != null);
    return arbolesCercanosObtenidos(arboles);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result arbolesCercanosObtenidos(ArbolesEntity arboles),
    Result coordenadasObtenidas(LatLng latLng),
    Result idNfcObtenido(NfcEntity nfcEntity),
    Result idNfcChequeado(bool existe),
    Result failure(String message),
    Result loading(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (arbolesCercanosObtenidos != null) {
      return arbolesCercanosObtenidos(arboles);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(InitialMapaState value),
    @required
        Result arbolesCercanosObtenidos(
            ArbolesCercanosObtenidosMapaState value),
    @required Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    @required Result idNfcObtenido(IdNfcObtenidoMapaState value),
    @required Result idNfcChequeado(IdNfcChequeadoMapaState value),
    @required Result failure(FailureMapaState value),
    @required Result loading(LoadingMapaState value),
  }) {
    assert(initial != null);
    assert(arbolesCercanosObtenidos != null);
    assert(coordenadasObtenidas != null);
    assert(idNfcObtenido != null);
    assert(idNfcChequeado != null);
    assert(failure != null);
    assert(loading != null);
    return arbolesCercanosObtenidos(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(InitialMapaState value),
    Result arbolesCercanosObtenidos(ArbolesCercanosObtenidosMapaState value),
    Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    Result idNfcObtenido(IdNfcObtenidoMapaState value),
    Result idNfcChequeado(IdNfcChequeadoMapaState value),
    Result failure(FailureMapaState value),
    Result loading(LoadingMapaState value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (arbolesCercanosObtenidos != null) {
      return arbolesCercanosObtenidos(this);
    }
    return orElse();
  }
}

abstract class ArbolesCercanosObtenidosMapaState implements ArbolMapaState {
  const factory ArbolesCercanosObtenidosMapaState(
      {@required ArbolesEntity arboles}) = _$ArbolesCercanosObtenidosMapaState;

  ArbolesEntity get arboles;
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
    @required Result arbolesCercanosObtenidos(ArbolesEntity arboles),
    @required Result coordenadasObtenidas(LatLng latLng),
    @required Result idNfcObtenido(NfcEntity nfcEntity),
    @required Result idNfcChequeado(bool existe),
    @required Result failure(String message),
    @required Result loading(),
  }) {
    assert(initial != null);
    assert(arbolesCercanosObtenidos != null);
    assert(coordenadasObtenidas != null);
    assert(idNfcObtenido != null);
    assert(idNfcChequeado != null);
    assert(failure != null);
    assert(loading != null);
    return coordenadasObtenidas(latLng);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result arbolesCercanosObtenidos(ArbolesEntity arboles),
    Result coordenadasObtenidas(LatLng latLng),
    Result idNfcObtenido(NfcEntity nfcEntity),
    Result idNfcChequeado(bool existe),
    Result failure(String message),
    Result loading(),
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
        Result arbolesCercanosObtenidos(
            ArbolesCercanosObtenidosMapaState value),
    @required Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    @required Result idNfcObtenido(IdNfcObtenidoMapaState value),
    @required Result idNfcChequeado(IdNfcChequeadoMapaState value),
    @required Result failure(FailureMapaState value),
    @required Result loading(LoadingMapaState value),
  }) {
    assert(initial != null);
    assert(arbolesCercanosObtenidos != null);
    assert(coordenadasObtenidas != null);
    assert(idNfcObtenido != null);
    assert(idNfcChequeado != null);
    assert(failure != null);
    assert(loading != null);
    return coordenadasObtenidas(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(InitialMapaState value),
    Result arbolesCercanosObtenidos(ArbolesCercanosObtenidosMapaState value),
    Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    Result idNfcObtenido(IdNfcObtenidoMapaState value),
    Result idNfcChequeado(IdNfcChequeadoMapaState value),
    Result failure(FailureMapaState value),
    Result loading(LoadingMapaState value),
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
abstract class $IdNfcObtenidoMapaStateCopyWith<$Res> {
  factory $IdNfcObtenidoMapaStateCopyWith(IdNfcObtenidoMapaState value,
          $Res Function(IdNfcObtenidoMapaState) then) =
      _$IdNfcObtenidoMapaStateCopyWithImpl<$Res>;
  $Res call({NfcEntity nfcEntity});
}

/// @nodoc
class _$IdNfcObtenidoMapaStateCopyWithImpl<$Res>
    extends _$ArbolMapaStateCopyWithImpl<$Res>
    implements $IdNfcObtenidoMapaStateCopyWith<$Res> {
  _$IdNfcObtenidoMapaStateCopyWithImpl(IdNfcObtenidoMapaState _value,
      $Res Function(IdNfcObtenidoMapaState) _then)
      : super(_value, (v) => _then(v as IdNfcObtenidoMapaState));

  @override
  IdNfcObtenidoMapaState get _value => super._value as IdNfcObtenidoMapaState;

  @override
  $Res call({
    Object nfcEntity = freezed,
  }) {
    return _then(IdNfcObtenidoMapaState(
      nfcEntity:
          nfcEntity == freezed ? _value.nfcEntity : nfcEntity as NfcEntity,
    ));
  }
}

/// @nodoc
class _$IdNfcObtenidoMapaState implements IdNfcObtenidoMapaState {
  const _$IdNfcObtenidoMapaState({@required this.nfcEntity})
      : assert(nfcEntity != null);

  @override
  final NfcEntity nfcEntity;

  @override
  String toString() {
    return 'ArbolMapaState.idNfcObtenido(nfcEntity: $nfcEntity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IdNfcObtenidoMapaState &&
            (identical(other.nfcEntity, nfcEntity) ||
                const DeepCollectionEquality()
                    .equals(other.nfcEntity, nfcEntity)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(nfcEntity);

  @override
  $IdNfcObtenidoMapaStateCopyWith<IdNfcObtenidoMapaState> get copyWith =>
      _$IdNfcObtenidoMapaStateCopyWithImpl<IdNfcObtenidoMapaState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result arbolesCercanosObtenidos(ArbolesEntity arboles),
    @required Result coordenadasObtenidas(LatLng latLng),
    @required Result idNfcObtenido(NfcEntity nfcEntity),
    @required Result idNfcChequeado(bool existe),
    @required Result failure(String message),
    @required Result loading(),
  }) {
    assert(initial != null);
    assert(arbolesCercanosObtenidos != null);
    assert(coordenadasObtenidas != null);
    assert(idNfcObtenido != null);
    assert(idNfcChequeado != null);
    assert(failure != null);
    assert(loading != null);
    return idNfcObtenido(nfcEntity);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result arbolesCercanosObtenidos(ArbolesEntity arboles),
    Result coordenadasObtenidas(LatLng latLng),
    Result idNfcObtenido(NfcEntity nfcEntity),
    Result idNfcChequeado(bool existe),
    Result failure(String message),
    Result loading(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idNfcObtenido != null) {
      return idNfcObtenido(nfcEntity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(InitialMapaState value),
    @required
        Result arbolesCercanosObtenidos(
            ArbolesCercanosObtenidosMapaState value),
    @required Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    @required Result idNfcObtenido(IdNfcObtenidoMapaState value),
    @required Result idNfcChequeado(IdNfcChequeadoMapaState value),
    @required Result failure(FailureMapaState value),
    @required Result loading(LoadingMapaState value),
  }) {
    assert(initial != null);
    assert(arbolesCercanosObtenidos != null);
    assert(coordenadasObtenidas != null);
    assert(idNfcObtenido != null);
    assert(idNfcChequeado != null);
    assert(failure != null);
    assert(loading != null);
    return idNfcObtenido(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(InitialMapaState value),
    Result arbolesCercanosObtenidos(ArbolesCercanosObtenidosMapaState value),
    Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    Result idNfcObtenido(IdNfcObtenidoMapaState value),
    Result idNfcChequeado(IdNfcChequeadoMapaState value),
    Result failure(FailureMapaState value),
    Result loading(LoadingMapaState value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idNfcObtenido != null) {
      return idNfcObtenido(this);
    }
    return orElse();
  }
}

abstract class IdNfcObtenidoMapaState implements ArbolMapaState {
  const factory IdNfcObtenidoMapaState({@required NfcEntity nfcEntity}) =
      _$IdNfcObtenidoMapaState;

  NfcEntity get nfcEntity;
  $IdNfcObtenidoMapaStateCopyWith<IdNfcObtenidoMapaState> get copyWith;
}

/// @nodoc
abstract class $IdNfcChequeadoMapaStateCopyWith<$Res> {
  factory $IdNfcChequeadoMapaStateCopyWith(IdNfcChequeadoMapaState value,
          $Res Function(IdNfcChequeadoMapaState) then) =
      _$IdNfcChequeadoMapaStateCopyWithImpl<$Res>;
  $Res call({bool existe});
}

/// @nodoc
class _$IdNfcChequeadoMapaStateCopyWithImpl<$Res>
    extends _$ArbolMapaStateCopyWithImpl<$Res>
    implements $IdNfcChequeadoMapaStateCopyWith<$Res> {
  _$IdNfcChequeadoMapaStateCopyWithImpl(IdNfcChequeadoMapaState _value,
      $Res Function(IdNfcChequeadoMapaState) _then)
      : super(_value, (v) => _then(v as IdNfcChequeadoMapaState));

  @override
  IdNfcChequeadoMapaState get _value => super._value as IdNfcChequeadoMapaState;

  @override
  $Res call({
    Object existe = freezed,
  }) {
    return _then(IdNfcChequeadoMapaState(
      existe: existe == freezed ? _value.existe : existe as bool,
    ));
  }
}

/// @nodoc
class _$IdNfcChequeadoMapaState implements IdNfcChequeadoMapaState {
  const _$IdNfcChequeadoMapaState({@required this.existe})
      : assert(existe != null);

  @override
  final bool existe;

  @override
  String toString() {
    return 'ArbolMapaState.idNfcChequeado(existe: $existe)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IdNfcChequeadoMapaState &&
            (identical(other.existe, existe) ||
                const DeepCollectionEquality().equals(other.existe, existe)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(existe);

  @override
  $IdNfcChequeadoMapaStateCopyWith<IdNfcChequeadoMapaState> get copyWith =>
      _$IdNfcChequeadoMapaStateCopyWithImpl<IdNfcChequeadoMapaState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result arbolesCercanosObtenidos(ArbolesEntity arboles),
    @required Result coordenadasObtenidas(LatLng latLng),
    @required Result idNfcObtenido(NfcEntity nfcEntity),
    @required Result idNfcChequeado(bool existe),
    @required Result failure(String message),
    @required Result loading(),
  }) {
    assert(initial != null);
    assert(arbolesCercanosObtenidos != null);
    assert(coordenadasObtenidas != null);
    assert(idNfcObtenido != null);
    assert(idNfcChequeado != null);
    assert(failure != null);
    assert(loading != null);
    return idNfcChequeado(existe);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result arbolesCercanosObtenidos(ArbolesEntity arboles),
    Result coordenadasObtenidas(LatLng latLng),
    Result idNfcObtenido(NfcEntity nfcEntity),
    Result idNfcChequeado(bool existe),
    Result failure(String message),
    Result loading(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idNfcChequeado != null) {
      return idNfcChequeado(existe);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(InitialMapaState value),
    @required
        Result arbolesCercanosObtenidos(
            ArbolesCercanosObtenidosMapaState value),
    @required Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    @required Result idNfcObtenido(IdNfcObtenidoMapaState value),
    @required Result idNfcChequeado(IdNfcChequeadoMapaState value),
    @required Result failure(FailureMapaState value),
    @required Result loading(LoadingMapaState value),
  }) {
    assert(initial != null);
    assert(arbolesCercanosObtenidos != null);
    assert(coordenadasObtenidas != null);
    assert(idNfcObtenido != null);
    assert(idNfcChequeado != null);
    assert(failure != null);
    assert(loading != null);
    return idNfcChequeado(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(InitialMapaState value),
    Result arbolesCercanosObtenidos(ArbolesCercanosObtenidosMapaState value),
    Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    Result idNfcObtenido(IdNfcObtenidoMapaState value),
    Result idNfcChequeado(IdNfcChequeadoMapaState value),
    Result failure(FailureMapaState value),
    Result loading(LoadingMapaState value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idNfcChequeado != null) {
      return idNfcChequeado(this);
    }
    return orElse();
  }
}

abstract class IdNfcChequeadoMapaState implements ArbolMapaState {
  const factory IdNfcChequeadoMapaState({@required bool existe}) =
      _$IdNfcChequeadoMapaState;

  bool get existe;
  $IdNfcChequeadoMapaStateCopyWith<IdNfcChequeadoMapaState> get copyWith;
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
    @required Result arbolesCercanosObtenidos(ArbolesEntity arboles),
    @required Result coordenadasObtenidas(LatLng latLng),
    @required Result idNfcObtenido(NfcEntity nfcEntity),
    @required Result idNfcChequeado(bool existe),
    @required Result failure(String message),
    @required Result loading(),
  }) {
    assert(initial != null);
    assert(arbolesCercanosObtenidos != null);
    assert(coordenadasObtenidas != null);
    assert(idNfcObtenido != null);
    assert(idNfcChequeado != null);
    assert(failure != null);
    assert(loading != null);
    return failure(message);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result arbolesCercanosObtenidos(ArbolesEntity arboles),
    Result coordenadasObtenidas(LatLng latLng),
    Result idNfcObtenido(NfcEntity nfcEntity),
    Result idNfcChequeado(bool existe),
    Result failure(String message),
    Result loading(),
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
        Result arbolesCercanosObtenidos(
            ArbolesCercanosObtenidosMapaState value),
    @required Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    @required Result idNfcObtenido(IdNfcObtenidoMapaState value),
    @required Result idNfcChequeado(IdNfcChequeadoMapaState value),
    @required Result failure(FailureMapaState value),
    @required Result loading(LoadingMapaState value),
  }) {
    assert(initial != null);
    assert(arbolesCercanosObtenidos != null);
    assert(coordenadasObtenidas != null);
    assert(idNfcObtenido != null);
    assert(idNfcChequeado != null);
    assert(failure != null);
    assert(loading != null);
    return failure(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(InitialMapaState value),
    Result arbolesCercanosObtenidos(ArbolesCercanosObtenidosMapaState value),
    Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    Result idNfcObtenido(IdNfcObtenidoMapaState value),
    Result idNfcChequeado(IdNfcChequeadoMapaState value),
    Result failure(FailureMapaState value),
    Result loading(LoadingMapaState value),
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
    @required Result arbolesCercanosObtenidos(ArbolesEntity arboles),
    @required Result coordenadasObtenidas(LatLng latLng),
    @required Result idNfcObtenido(NfcEntity nfcEntity),
    @required Result idNfcChequeado(bool existe),
    @required Result failure(String message),
    @required Result loading(),
  }) {
    assert(initial != null);
    assert(arbolesCercanosObtenidos != null);
    assert(coordenadasObtenidas != null);
    assert(idNfcObtenido != null);
    assert(idNfcChequeado != null);
    assert(failure != null);
    assert(loading != null);
    return loading();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result arbolesCercanosObtenidos(ArbolesEntity arboles),
    Result coordenadasObtenidas(LatLng latLng),
    Result idNfcObtenido(NfcEntity nfcEntity),
    Result idNfcChequeado(bool existe),
    Result failure(String message),
    Result loading(),
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
        Result arbolesCercanosObtenidos(
            ArbolesCercanosObtenidosMapaState value),
    @required Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    @required Result idNfcObtenido(IdNfcObtenidoMapaState value),
    @required Result idNfcChequeado(IdNfcChequeadoMapaState value),
    @required Result failure(FailureMapaState value),
    @required Result loading(LoadingMapaState value),
  }) {
    assert(initial != null);
    assert(arbolesCercanosObtenidos != null);
    assert(coordenadasObtenidas != null);
    assert(idNfcObtenido != null);
    assert(idNfcChequeado != null);
    assert(failure != null);
    assert(loading != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(InitialMapaState value),
    Result arbolesCercanosObtenidos(ArbolesCercanosObtenidosMapaState value),
    Result coordenadasObtenidas(CoordenadasObtenidasMapaState value),
    Result idNfcObtenido(IdNfcObtenidoMapaState value),
    Result idNfcChequeado(IdNfcChequeadoMapaState value),
    Result failure(FailureMapaState value),
    Result loading(LoadingMapaState value),
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
