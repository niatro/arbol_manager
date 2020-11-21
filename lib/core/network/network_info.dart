import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:injectable/injectable.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

@lazySingleton
class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
