import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InputConverter {
  Either<Failure, LatLng> stringToUnsignedLatLng(String str) {
    //TODO:
    try {
      final LatLng result = str != null
          ? LatLng(
              double.parse(str.split(',')[0]), double.parse(str.split(',')[1]))
          : FormatException;
      return Right(result);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
