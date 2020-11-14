import 'package:flutter/material.dart';

class ServerException implements Exception {}

///Cuando ocurren errores en el lado del servidor
class CacheException implements Exception {}

/// Cuando ocurren errores con la data en la parte local
///
class NfcException implements Exception {}

class DataBaseException implements Exception {}

class LocationException implements Exception {}

class PassException implements Exception {}

class InvalidEmailException implements Exception {
  final String failedValue;
  InvalidEmailException({@required this.failedValue});
}

/// Cuando ocurren errores con la lectura del NFC
