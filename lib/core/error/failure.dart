import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

/// Estas son failures generales

class ServerFailure extends Failure {}

class ServerFailureGrabando extends Failure {}

class CacheFailure extends Failure {}

class NfcFailure extends Failure {}

class DataBaseFailure extends Failure {}

class IdNfcNoGrabaYaExisteFailure extends Failure {}

class LocalDataBaseFailure extends Failure {}

class ConexionFailure extends Failure {}

class LocalGpsFailure extends Failure {}
