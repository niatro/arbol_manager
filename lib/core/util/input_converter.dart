import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InputConverterStrToLatLng {
  Either<Failure, LatLng> stringToLatLng(String str) {
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

@lazySingleton
class InputConverterIdNFCToStr {
  Either<Failure, String> idNFCToStr(String str) {
    try {
      final String result = str != null ? str : FormatException;
      return Right(result);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
