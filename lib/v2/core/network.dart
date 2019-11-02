
import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {

  NetworkInfoImpl();

  final DataConnectionChecker _dataConnectionChecker = DataConnectionChecker();

  @override
  Future<bool> get isConnected async => await _dataConnectionChecker.hasConnection;
}