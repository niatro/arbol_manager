import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

/// Estas son failures generales

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NfcFailure extends Failure {}

class DataBaseFailure extends Failure {}
