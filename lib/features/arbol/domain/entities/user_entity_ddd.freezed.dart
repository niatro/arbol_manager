// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'user_entity_ddd.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$UserEntityDDDTearOff {
  const _$UserEntityDDDTearOff();

// ignore: unused_element
  _UserEntityDDD call({@required UniqueId id}) {
    return _UserEntityDDD(
      id: id,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $UserEntityDDD = _$UserEntityDDDTearOff();

/// @nodoc
mixin _$UserEntityDDD {
  UniqueId get id;

  $UserEntityDDDCopyWith<UserEntityDDD> get copyWith;
}

/// @nodoc
abstract class $UserEntityDDDCopyWith<$Res> {
  factory $UserEntityDDDCopyWith(
          UserEntityDDD value, $Res Function(UserEntityDDD) then) =
      _$UserEntityDDDCopyWithImpl<$Res>;
  $Res call({UniqueId id});
}

/// @nodoc
class _$UserEntityDDDCopyWithImpl<$Res>
    implements $UserEntityDDDCopyWith<$Res> {
  _$UserEntityDDDCopyWithImpl(this._value, this._then);

  final UserEntityDDD _value;
  // ignore: unused_field
  final $Res Function(UserEntityDDD) _then;

  @override
  $Res call({
    Object id = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as UniqueId,
    ));
  }
}

/// @nodoc
abstract class _$UserEntityDDDCopyWith<$Res>
    implements $UserEntityDDDCopyWith<$Res> {
  factory _$UserEntityDDDCopyWith(
          _UserEntityDDD value, $Res Function(_UserEntityDDD) then) =
      __$UserEntityDDDCopyWithImpl<$Res>;
  @override
  $Res call({UniqueId id});
}

/// @nodoc
class __$UserEntityDDDCopyWithImpl<$Res>
    extends _$UserEntityDDDCopyWithImpl<$Res>
    implements _$UserEntityDDDCopyWith<$Res> {
  __$UserEntityDDDCopyWithImpl(
      _UserEntityDDD _value, $Res Function(_UserEntityDDD) _then)
      : super(_value, (v) => _then(v as _UserEntityDDD));

  @override
  _UserEntityDDD get _value => super._value as _UserEntityDDD;

  @override
  $Res call({
    Object id = freezed,
  }) {
    return _then(_UserEntityDDD(
      id: id == freezed ? _value.id : id as UniqueId,
    ));
  }
}

/// @nodoc
class _$_UserEntityDDD implements _UserEntityDDD {
  const _$_UserEntityDDD({@required this.id}) : assert(id != null);

  @override
  final UniqueId id;

  @override
  String toString() {
    return 'UserEntityDDD(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserEntityDDD &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(id);

  @override
  _$UserEntityDDDCopyWith<_UserEntityDDD> get copyWith =>
      __$UserEntityDDDCopyWithImpl<_UserEntityDDD>(this, _$identity);
}

abstract class _UserEntityDDD implements UserEntityDDD {
  const factory _UserEntityDDD({@required UniqueId id}) = _$_UserEntityDDD;

  @override
  UniqueId get id;
  @override
  _$UserEntityDDDCopyWith<_UserEntityDDD> get copyWith;
}
