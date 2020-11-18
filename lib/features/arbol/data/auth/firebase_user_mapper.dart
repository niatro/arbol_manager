import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapparbol/features/arbol/domain/core/value_objects.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/user_entity_ddd.dart';

extension FirebaseUserDomainX on User {
  UserEntityDDD toDomain() {
    return UserEntityDDD(
      id: UniqueId.fromUniqueString(uid),
    );
  }
}
