import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

/// Estas son failures generales

class ServerFailure extends Failure {}

class ServerGrabarFailure extends Failure {}

class CacheFailure extends Failure {}

class NfcFailure extends Failure {}

class DataBaseFailure extends Failure {}

class ArbolNoGrabaYaExisteFailure extends Failure {}

class ArbolNoUpdateNoExisteFailure extends Failure {}

class LocalDataBaseFailure extends Failure {}

class ConexionFailure extends Failure {}

class LocalGpsFailure extends Failure {}

class ServerUpdateFailure extends Failure {}

class PassNoExisteFailure extends Failure {}

class SqlFailure extends Failure {}

class CoordFailure extends Failure {}
