import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterapparbol/features/arbol/domain/auth/auth_failure.dart';
import 'package:flutterapparbol/features/arbol/domain/auth/value_objects.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/user_entity_ddd.dart';

abstract class IAuthFacade {
  Future<Option<UserEntityDDD>> getSignedInUser();
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    @required EmailAddress emailAddress,
    @required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    @required EmailAddress emailAddress,
    @required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithRutAndPassword({
    @required EmailAddress emailAddress,
    @required Rut rut,
  });
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
  Future<void> signOut();
}
