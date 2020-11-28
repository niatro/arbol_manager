import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapparbol/core/network/network_info.dart';
import 'package:mockito/mockito.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfoImpl;
  MockDataConnectionChecker mockDataConnectionChecker;
  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    // Esto es la sustancia (verdadero o falso)
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
    // Esta es la cuchara que recoge sustancia
  });

  group('isConnected', () {
    test('DEBERÍA llamar a DataConnectionChecker.hasConnection', () async {
      // arrange
      final tHasConnectionFuture = Future.value(true);
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);
      // Cuando lo que se puede recoger por la cuchara es sustancia true (verdadero)
      // act
      final result = networkInfoImpl.isConnected;
      // decirle que guarde lo que recogió de la sustancia genérica en result,
      // que active la propiedad hasConnection y que retorne un futuro true
      // assert
      verify(mockDataConnectionChecker.hasConnection);
      expect(result, tHasConnectionFuture);
    });
  });
}
