// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'nfc_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$NfcEventTearOff {
  const _$NfcEventTearOff();

// ignore: unused_element
  LeidoNfcEvent leidoNfc() {
    return const LeidoNfcEvent();
  }

// ignore: unused_element
  VerificadoIdNfcEvent verificadoIdNfc(String idNfc) {
    return VerificadoIdNfcEvent(
      idNfc,
    );
  }

// ignore: unused_element
  EscribirdNfcEvent escribirdNfc(String idNfc) {
    return EscribirdNfcEvent(
      idNfc,
    );
  }

// ignore: unused_element
  ArbolConseguidoPorIdNfcEvent arbolConseguidoPorIdNfc(String idNfc) {
    return ArbolConseguidoPorIdNfcEvent(
      idNfc,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $NfcEvent = _$NfcEventTearOff();

/// @nodoc
mixin _$NfcEvent {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result leidoNfc(),
    @required Result verificadoIdNfc(String idNfc),
    @required Result escribirdNfc(String idNfc),
    @required Result arbolConseguidoPorIdNfc(String idNfc),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result leidoNfc(),
    Result verificadoIdNfc(String idNfc),
    Result escribirdNfc(String idNfc),
    Result arbolConseguidoPorIdNfc(String idNfc),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result leidoNfc(LeidoNfcEvent value),
    @required Result verificadoIdNfc(VerificadoIdNfcEvent value),
    @required Result escribirdNfc(EscribirdNfcEvent value),
    @required
        Result arbolConseguidoPorIdNfc(ArbolConseguidoPorIdNfcEvent value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result leidoNfc(LeidoNfcEvent value),
    Result verificadoIdNfc(VerificadoIdNfcEvent value),
    Result escribirdNfc(EscribirdNfcEvent value),
    Result arbolConseguidoPorIdNfc(ArbolConseguidoPorIdNfcEvent value),
    @required Result orElse(),
  });
}

/// @nodoc
abstract class $NfcEventCopyWith<$Res> {
  factory $NfcEventCopyWith(NfcEvent value, $Res Function(NfcEvent) then) =
      _$NfcEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$NfcEventCopyWithImpl<$Res> implements $NfcEventCopyWith<$Res> {
  _$NfcEventCopyWithImpl(this._value, this._then);

  final NfcEvent _value;
  // ignore: unused_field
  final $Res Function(NfcEvent) _then;
}

/// @nodoc
abstract class $LeidoNfcEventCopyWith<$Res> {
  factory $LeidoNfcEventCopyWith(
          LeidoNfcEvent value, $Res Function(LeidoNfcEvent) then) =
      _$LeidoNfcEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$LeidoNfcEventCopyWithImpl<$Res> extends _$NfcEventCopyWithImpl<$Res>
    implements $LeidoNfcEventCopyWith<$Res> {
  _$LeidoNfcEventCopyWithImpl(
      LeidoNfcEvent _value, $Res Function(LeidoNfcEvent) _then)
      : super(_value, (v) => _then(v as LeidoNfcEvent));

  @override
  LeidoNfcEvent get _value => super._value as LeidoNfcEvent;
}

/// @nodoc
class _$LeidoNfcEvent implements LeidoNfcEvent {
  const _$LeidoNfcEvent();

  @override
  String toString() {
    return 'NfcEvent.leidoNfc()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is LeidoNfcEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result leidoNfc(),
    @required Result verificadoIdNfc(String idNfc),
    @required Result escribirdNfc(String idNfc),
    @required Result arbolConseguidoPorIdNfc(String idNfc),
  }) {
    assert(leidoNfc != null);
    assert(verificadoIdNfc != null);
    assert(escribirdNfc != null);
    assert(arbolConseguidoPorIdNfc != null);
    return leidoNfc();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result leidoNfc(),
    Result verificadoIdNfc(String idNfc),
    Result escribirdNfc(String idNfc),
    Result arbolConseguidoPorIdNfc(String idNfc),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (leidoNfc != null) {
      return leidoNfc();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result leidoNfc(LeidoNfcEvent value),
    @required Result verificadoIdNfc(VerificadoIdNfcEvent value),
    @required Result escribirdNfc(EscribirdNfcEvent value),
    @required
        Result arbolConseguidoPorIdNfc(ArbolConseguidoPorIdNfcEvent value),
  }) {
    assert(leidoNfc != null);
    assert(verificadoIdNfc != null);
    assert(escribirdNfc != null);
    assert(arbolConseguidoPorIdNfc != null);
    return leidoNfc(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result leidoNfc(LeidoNfcEvent value),
    Result verificadoIdNfc(VerificadoIdNfcEvent value),
    Result escribirdNfc(EscribirdNfcEvent value),
    Result arbolConseguidoPorIdNfc(ArbolConseguidoPorIdNfcEvent value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (leidoNfc != null) {
      return leidoNfc(this);
    }
    return orElse();
  }
}

abstract class LeidoNfcEvent implements NfcEvent {
  const factory LeidoNfcEvent() = _$LeidoNfcEvent;
}

/// @nodoc
abstract class $VerificadoIdNfcEventCopyWith<$Res> {
  factory $VerificadoIdNfcEventCopyWith(VerificadoIdNfcEvent value,
          $Res Function(VerificadoIdNfcEvent) then) =
      _$VerificadoIdNfcEventCopyWithImpl<$Res>;
  $Res call({String idNfc});
}

/// @nodoc
class _$VerificadoIdNfcEventCopyWithImpl<$Res>
    extends _$NfcEventCopyWithImpl<$Res>
    implements $VerificadoIdNfcEventCopyWith<$Res> {
  _$VerificadoIdNfcEventCopyWithImpl(
      VerificadoIdNfcEvent _value, $Res Function(VerificadoIdNfcEvent) _then)
      : super(_value, (v) => _then(v as VerificadoIdNfcEvent));

  @override
  VerificadoIdNfcEvent get _value => super._value as VerificadoIdNfcEvent;

  @override
  $Res call({
    Object idNfc = freezed,
  }) {
    return _then(VerificadoIdNfcEvent(
      idNfc == freezed ? _value.idNfc : idNfc as String,
    ));
  }
}

/// @nodoc
class _$VerificadoIdNfcEvent implements VerificadoIdNfcEvent {
  const _$VerificadoIdNfcEvent(this.idNfc) : assert(idNfc != null);

  @override
  final String idNfc;

  @override
  String toString() {
    return 'NfcEvent.verificadoIdNfc(idNfc: $idNfc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is VerificadoIdNfcEvent &&
            (identical(other.idNfc, idNfc) ||
                const DeepCollectionEquality().equals(other.idNfc, idNfc)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(idNfc);

  @override
  $VerificadoIdNfcEventCopyWith<VerificadoIdNfcEvent> get copyWith =>
      _$VerificadoIdNfcEventCopyWithImpl<VerificadoIdNfcEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result leidoNfc(),
    @required Result verificadoIdNfc(String idNfc),
    @required Result escribirdNfc(String idNfc),
    @required Result arbolConseguidoPorIdNfc(String idNfc),
  }) {
    assert(leidoNfc != null);
    assert(verificadoIdNfc != null);
    assert(escribirdNfc != null);
    assert(arbolConseguidoPorIdNfc != null);
    return verificadoIdNfc(idNfc);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result leidoNfc(),
    Result verificadoIdNfc(String idNfc),
    Result escribirdNfc(String idNfc),
    Result arbolConseguidoPorIdNfc(String idNfc),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (verificadoIdNfc != null) {
      return verificadoIdNfc(idNfc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result leidoNfc(LeidoNfcEvent value),
    @required Result verificadoIdNfc(VerificadoIdNfcEvent value),
    @required Result escribirdNfc(EscribirdNfcEvent value),
    @required
        Result arbolConseguidoPorIdNfc(ArbolConseguidoPorIdNfcEvent value),
  }) {
    assert(leidoNfc != null);
    assert(verificadoIdNfc != null);
    assert(escribirdNfc != null);
    assert(arbolConseguidoPorIdNfc != null);
    return verificadoIdNfc(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result leidoNfc(LeidoNfcEvent value),
    Result verificadoIdNfc(VerificadoIdNfcEvent value),
    Result escribirdNfc(EscribirdNfcEvent value),
    Result arbolConseguidoPorIdNfc(ArbolConseguidoPorIdNfcEvent value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (verificadoIdNfc != null) {
      return verificadoIdNfc(this);
    }
    return orElse();
  }
}

abstract class VerificadoIdNfcEvent implements NfcEvent {
  const factory VerificadoIdNfcEvent(String idNfc) = _$VerificadoIdNfcEvent;

  String get idNfc;
  $VerificadoIdNfcEventCopyWith<VerificadoIdNfcEvent> get copyWith;
}

/// @nodoc
abstract class $EscribirdNfcEventCopyWith<$Res> {
  factory $EscribirdNfcEventCopyWith(
          EscribirdNfcEvent value, $Res Function(EscribirdNfcEvent) then) =
      _$EscribirdNfcEventCopyWithImpl<$Res>;
  $Res call({String idNfc});
}

/// @nodoc
class _$EscribirdNfcEventCopyWithImpl<$Res> extends _$NfcEventCopyWithImpl<$Res>
    implements $EscribirdNfcEventCopyWith<$Res> {
  _$EscribirdNfcEventCopyWithImpl(
      EscribirdNfcEvent _value, $Res Function(EscribirdNfcEvent) _then)
      : super(_value, (v) => _then(v as EscribirdNfcEvent));

  @override
  EscribirdNfcEvent get _value => super._value as EscribirdNfcEvent;

  @override
  $Res call({
    Object idNfc = freezed,
  }) {
    return _then(EscribirdNfcEvent(
      idNfc == freezed ? _value.idNfc : idNfc as String,
    ));
  }
}

/// @nodoc
class _$EscribirdNfcEvent implements EscribirdNfcEvent {
  const _$EscribirdNfcEvent(this.idNfc) : assert(idNfc != null);

  @override
  final String idNfc;

  @override
  String toString() {
    return 'NfcEvent.escribirdNfc(idNfc: $idNfc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EscribirdNfcEvent &&
            (identical(other.idNfc, idNfc) ||
                const DeepCollectionEquality().equals(other.idNfc, idNfc)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(idNfc);

  @override
  $EscribirdNfcEventCopyWith<EscribirdNfcEvent> get copyWith =>
      _$EscribirdNfcEventCopyWithImpl<EscribirdNfcEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result leidoNfc(),
    @required Result verificadoIdNfc(String idNfc),
    @required Result escribirdNfc(String idNfc),
    @required Result arbolConseguidoPorIdNfc(String idNfc),
  }) {
    assert(leidoNfc != null);
    assert(verificadoIdNfc != null);
    assert(escribirdNfc != null);
    assert(arbolConseguidoPorIdNfc != null);
    return escribirdNfc(idNfc);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result leidoNfc(),
    Result verificadoIdNfc(String idNfc),
    Result escribirdNfc(String idNfc),
    Result arbolConseguidoPorIdNfc(String idNfc),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (escribirdNfc != null) {
      return escribirdNfc(idNfc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result leidoNfc(LeidoNfcEvent value),
    @required Result verificadoIdNfc(VerificadoIdNfcEvent value),
    @required Result escribirdNfc(EscribirdNfcEvent value),
    @required
        Result arbolConseguidoPorIdNfc(ArbolConseguidoPorIdNfcEvent value),
  }) {
    assert(leidoNfc != null);
    assert(verificadoIdNfc != null);
    assert(escribirdNfc != null);
    assert(arbolConseguidoPorIdNfc != null);
    return escribirdNfc(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result leidoNfc(LeidoNfcEvent value),
    Result verificadoIdNfc(VerificadoIdNfcEvent value),
    Result escribirdNfc(EscribirdNfcEvent value),
    Result arbolConseguidoPorIdNfc(ArbolConseguidoPorIdNfcEvent value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (escribirdNfc != null) {
      return escribirdNfc(this);
    }
    return orElse();
  }
}

abstract class EscribirdNfcEvent implements NfcEvent {
  const factory EscribirdNfcEvent(String idNfc) = _$EscribirdNfcEvent;

  String get idNfc;
  $EscribirdNfcEventCopyWith<EscribirdNfcEvent> get copyWith;
}

/// @nodoc
abstract class $ArbolConseguidoPorIdNfcEventCopyWith<$Res> {
  factory $ArbolConseguidoPorIdNfcEventCopyWith(
          ArbolConseguidoPorIdNfcEvent value,
          $Res Function(ArbolConseguidoPorIdNfcEvent) then) =
      _$ArbolConseguidoPorIdNfcEventCopyWithImpl<$Res>;
  $Res call({String idNfc});
}

/// @nodoc
class _$ArbolConseguidoPorIdNfcEventCopyWithImpl<$Res>
    extends _$NfcEventCopyWithImpl<$Res>
    implements $ArbolConseguidoPorIdNfcEventCopyWith<$Res> {
  _$ArbolConseguidoPorIdNfcEventCopyWithImpl(
      ArbolConseguidoPorIdNfcEvent _value,
      $Res Function(ArbolConseguidoPorIdNfcEvent) _then)
      : super(_value, (v) => _then(v as ArbolConseguidoPorIdNfcEvent));

  @override
  ArbolConseguidoPorIdNfcEvent get _value =>
      super._value as ArbolConseguidoPorIdNfcEvent;

  @override
  $Res call({
    Object idNfc = freezed,
  }) {
    return _then(ArbolConseguidoPorIdNfcEvent(
      idNfc == freezed ? _value.idNfc : idNfc as String,
    ));
  }
}

/// @nodoc
class _$ArbolConseguidoPorIdNfcEvent implements ArbolConseguidoPorIdNfcEvent {
  const _$ArbolConseguidoPorIdNfcEvent(this.idNfc) : assert(idNfc != null);

  @override
  final String idNfc;

  @override
  String toString() {
    return 'NfcEvent.arbolConseguidoPorIdNfc(idNfc: $idNfc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ArbolConseguidoPorIdNfcEvent &&
            (identical(other.idNfc, idNfc) ||
                const DeepCollectionEquality().equals(other.idNfc, idNfc)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(idNfc);

  @override
  $ArbolConseguidoPorIdNfcEventCopyWith<ArbolConseguidoPorIdNfcEvent>
      get copyWith => _$ArbolConseguidoPorIdNfcEventCopyWithImpl<
          ArbolConseguidoPorIdNfcEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result leidoNfc(),
    @required Result verificadoIdNfc(String idNfc),
    @required Result escribirdNfc(String idNfc),
    @required Result arbolConseguidoPorIdNfc(String idNfc),
  }) {
    assert(leidoNfc != null);
    assert(verificadoIdNfc != null);
    assert(escribirdNfc != null);
    assert(arbolConseguidoPorIdNfc != null);
    return arbolConseguidoPorIdNfc(idNfc);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result leidoNfc(),
    Result verificadoIdNfc(String idNfc),
    Result escribirdNfc(String idNfc),
    Result arbolConseguidoPorIdNfc(String idNfc),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (arbolConseguidoPorIdNfc != null) {
      return arbolConseguidoPorIdNfc(idNfc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result leidoNfc(LeidoNfcEvent value),
    @required Result verificadoIdNfc(VerificadoIdNfcEvent value),
    @required Result escribirdNfc(EscribirdNfcEvent value),
    @required
        Result arbolConseguidoPorIdNfc(ArbolConseguidoPorIdNfcEvent value),
  }) {
    assert(leidoNfc != null);
    assert(verificadoIdNfc != null);
    assert(escribirdNfc != null);
    assert(arbolConseguidoPorIdNfc != null);
    return arbolConseguidoPorIdNfc(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result leidoNfc(LeidoNfcEvent value),
    Result verificadoIdNfc(VerificadoIdNfcEvent value),
    Result escribirdNfc(EscribirdNfcEvent value),
    Result arbolConseguidoPorIdNfc(ArbolConseguidoPorIdNfcEvent value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (arbolConseguidoPorIdNfc != null) {
      return arbolConseguidoPorIdNfc(this);
    }
    return orElse();
  }
}

abstract class ArbolConseguidoPorIdNfcEvent implements NfcEvent {
  const factory ArbolConseguidoPorIdNfcEvent(String idNfc) =
      _$ArbolConseguidoPorIdNfcEvent;

  String get idNfc;
  $ArbolConseguidoPorIdNfcEventCopyWith<ArbolConseguidoPorIdNfcEvent>
      get copyWith;
}

/// @nodoc
class _$NfcStateTearOff {
  const _$NfcStateTearOff();

// ignore: unused_element
  _NfcState call(
      {@required NfcEntity nfcEntity,
      ArbolesEntity arbol,
      @required bool showErrorMessages,
      @required bool estaRegistrado,
      Failure failure}) {
    return _NfcState(
      nfcEntity: nfcEntity,
      arbol: arbol,
      showErrorMessages: showErrorMessages,
      estaRegistrado: estaRegistrado,
      failure: failure,
    );
  }

// ignore: unused_element
  LoadingNfcState loadingNfcState() {
    return const LoadingNfcState();
  }
}

/// @nodoc
// ignore: unused_element
const $NfcState = _$NfcStateTearOff();

/// @nodoc
mixin _$NfcState {
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(NfcEntity nfcEntity, ArbolesEntity arbol,
        bool showErrorMessages, bool estaRegistrado, Failure failure), {
    @required Result loadingNfcState(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(NfcEntity nfcEntity, ArbolesEntity arbol,
        bool showErrorMessages, bool estaRegistrado, Failure failure), {
    Result loadingNfcState(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(_NfcState value), {
    @required Result loadingNfcState(LoadingNfcState value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_NfcState value), {
    Result loadingNfcState(LoadingNfcState value),
    @required Result orElse(),
  });
}

/// @nodoc
abstract class $NfcStateCopyWith<$Res> {
  factory $NfcStateCopyWith(NfcState value, $Res Function(NfcState) then) =
      _$NfcStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$NfcStateCopyWithImpl<$Res> implements $NfcStateCopyWith<$Res> {
  _$NfcStateCopyWithImpl(this._value, this._then);

  final NfcState _value;
  // ignore: unused_field
  final $Res Function(NfcState) _then;
}

/// @nodoc
abstract class _$NfcStateCopyWith<$Res> {
  factory _$NfcStateCopyWith(_NfcState value, $Res Function(_NfcState) then) =
      __$NfcStateCopyWithImpl<$Res>;
  $Res call(
      {NfcEntity nfcEntity,
      ArbolesEntity arbol,
      bool showErrorMessages,
      bool estaRegistrado,
      Failure failure});
}

/// @nodoc
class __$NfcStateCopyWithImpl<$Res> extends _$NfcStateCopyWithImpl<$Res>
    implements _$NfcStateCopyWith<$Res> {
  __$NfcStateCopyWithImpl(_NfcState _value, $Res Function(_NfcState) _then)
      : super(_value, (v) => _then(v as _NfcState));

  @override
  _NfcState get _value => super._value as _NfcState;

  @override
  $Res call({
    Object nfcEntity = freezed,
    Object arbol = freezed,
    Object showErrorMessages = freezed,
    Object estaRegistrado = freezed,
    Object failure = freezed,
  }) {
    return _then(_NfcState(
      nfcEntity:
          nfcEntity == freezed ? _value.nfcEntity : nfcEntity as NfcEntity,
      arbol: arbol == freezed ? _value.arbol : arbol as ArbolesEntity,
      showErrorMessages: showErrorMessages == freezed
          ? _value.showErrorMessages
          : showErrorMessages as bool,
      estaRegistrado: estaRegistrado == freezed
          ? _value.estaRegistrado
          : estaRegistrado as bool,
      failure: failure == freezed ? _value.failure : failure as Failure,
    ));
  }
}

/// @nodoc
class _$_NfcState implements _NfcState {
  const _$_NfcState(
      {@required this.nfcEntity,
      this.arbol,
      @required this.showErrorMessages,
      @required this.estaRegistrado,
      this.failure})
      : assert(nfcEntity != null),
        assert(showErrorMessages != null),
        assert(estaRegistrado != null);

  @override
  final NfcEntity nfcEntity;
  @override
  final ArbolesEntity arbol;
  @override
  final bool showErrorMessages;
  @override
  final bool estaRegistrado;
  @override
  final Failure failure;

  @override
  String toString() {
    return 'NfcState(nfcEntity: $nfcEntity, arbol: $arbol, showErrorMessages: $showErrorMessages, estaRegistrado: $estaRegistrado, failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NfcState &&
            (identical(other.nfcEntity, nfcEntity) ||
                const DeepCollectionEquality()
                    .equals(other.nfcEntity, nfcEntity)) &&
            (identical(other.arbol, arbol) ||
                const DeepCollectionEquality().equals(other.arbol, arbol)) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                const DeepCollectionEquality()
                    .equals(other.showErrorMessages, showErrorMessages)) &&
            (identical(other.estaRegistrado, estaRegistrado) ||
                const DeepCollectionEquality()
                    .equals(other.estaRegistrado, estaRegistrado)) &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(nfcEntity) ^
      const DeepCollectionEquality().hash(arbol) ^
      const DeepCollectionEquality().hash(showErrorMessages) ^
      const DeepCollectionEquality().hash(estaRegistrado) ^
      const DeepCollectionEquality().hash(failure);

  @override
  _$NfcStateCopyWith<_NfcState> get copyWith =>
      __$NfcStateCopyWithImpl<_NfcState>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(NfcEntity nfcEntity, ArbolesEntity arbol,
        bool showErrorMessages, bool estaRegistrado, Failure failure), {
    @required Result loadingNfcState(),
  }) {
    assert($default != null);
    assert(loadingNfcState != null);
    return $default(
        nfcEntity, arbol, showErrorMessages, estaRegistrado, failure);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(NfcEntity nfcEntity, ArbolesEntity arbol,
        bool showErrorMessages, bool estaRegistrado, Failure failure), {
    Result loadingNfcState(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(
          nfcEntity, arbol, showErrorMessages, estaRegistrado, failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(_NfcState value), {
    @required Result loadingNfcState(LoadingNfcState value),
  }) {
    assert($default != null);
    assert(loadingNfcState != null);
    return $default(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_NfcState value), {
    Result loadingNfcState(LoadingNfcState value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _NfcState implements NfcState {
  const factory _NfcState(
      {@required NfcEntity nfcEntity,
      ArbolesEntity arbol,
      @required bool showErrorMessages,
      @required bool estaRegistrado,
      Failure failure}) = _$_NfcState;

  NfcEntity get nfcEntity;
  ArbolesEntity get arbol;
  bool get showErrorMessages;
  bool get estaRegistrado;
  Failure get failure;
  _$NfcStateCopyWith<_NfcState> get copyWith;
}

/// @nodoc
abstract class $LoadingNfcStateCopyWith<$Res> {
  factory $LoadingNfcStateCopyWith(
          LoadingNfcState value, $Res Function(LoadingNfcState) then) =
      _$LoadingNfcStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadingNfcStateCopyWithImpl<$Res> extends _$NfcStateCopyWithImpl<$Res>
    implements $LoadingNfcStateCopyWith<$Res> {
  _$LoadingNfcStateCopyWithImpl(
      LoadingNfcState _value, $Res Function(LoadingNfcState) _then)
      : super(_value, (v) => _then(v as LoadingNfcState));

  @override
  LoadingNfcState get _value => super._value as LoadingNfcState;
}

/// @nodoc
class _$LoadingNfcState implements LoadingNfcState {
  const _$LoadingNfcState();

  @override
  String toString() {
    return 'NfcState.loadingNfcState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is LoadingNfcState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(NfcEntity nfcEntity, ArbolesEntity arbol,
        bool showErrorMessages, bool estaRegistrado, Failure failure), {
    @required Result loadingNfcState(),
  }) {
    assert($default != null);
    assert(loadingNfcState != null);
    return loadingNfcState();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(NfcEntity nfcEntity, ArbolesEntity arbol,
        bool showErrorMessages, bool estaRegistrado, Failure failure), {
    Result loadingNfcState(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loadingNfcState != null) {
      return loadingNfcState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(_NfcState value), {
    @required Result loadingNfcState(LoadingNfcState value),
  }) {
    assert($default != null);
    assert(loadingNfcState != null);
    return loadingNfcState(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_NfcState value), {
    Result loadingNfcState(LoadingNfcState value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loadingNfcState != null) {
      return loadingNfcState(this);
    }
    return orElse();
  }
}

abstract class LoadingNfcState implements NfcState {
  const factory LoadingNfcState() = _$LoadingNfcState;
}
