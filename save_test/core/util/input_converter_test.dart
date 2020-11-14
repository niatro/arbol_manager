import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapparbol/core/util/input_converter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  InputConverterStrToLatLng inputConverter;
  setUp(() {
    inputConverter = InputConverterStrToLatLng();
  });
  group('String To Unsigned LatLng', () {
    test(
        'DEBERIA retornar un LatLong CUANDO el String representa un Unsigned LatLong',
        () async {
      // arrange
      final strCoordenadas = "-33.398827188275405,-70.59860965002224";
      // act
      final result = inputConverter.stringToLatLng(strCoordenadas);
      // assert
      expect(result, Right(LatLng(-33.398827188275405, -70.59860965002224)));
    });
    test('DEBERIA retornar un Failure CUANDO el string no representa un LatLng',
        () async {
      // arrange
      final strCoordenadas = "dsfergeh";
      // act
      final result = inputConverter.stringToLatLng(strCoordenadas);
      // assert
      expect(result, Left(InvalidInputFailure()));
    });
    test('DEBERIA retornar un Failure CUANDO el string es un null ', () async {
      // arrange
      final strCoordenadas = "";
      // act
      final result = inputConverter.stringToLatLng(strCoordenadas);
      // assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
