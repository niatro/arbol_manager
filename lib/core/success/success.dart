import 'package:equatable/equatable.dart';

abstract class Success extends Equatable {
  Success([List properties = const <dynamic>[]]) : super(properties);
}

class ServerGrabarSuccess extends Success {}

class ServerActualizarFormSuccess extends Success {}

class SqfliteGrabarSuccess extends Success {}

class ServerUpdateSuccess extends Success {}

class LoginSuccess extends Success {}
