import 'package:flutterapparbol/features/arbol/domain/core/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity_ddd.freezed.dart';

@freezed
abstract class UserEntityDDD with _$UserEntityDDD {
  const factory UserEntityDDD({
    @required UniqueId id,
  }) = _UserEntityDDD;
}
