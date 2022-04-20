import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:core/src/logger/tf_logger.dart';

/*
*  Class use Flutter favorite package connectivity and provide service
*  for checking connection status.
*/
class ConnectionChecker {
  static ConnectionChecker? _instance;
  late TFLogger _logger;
  late ConnectivityResult _connectionStatus;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late Connectivity _connectivity;

  factory ConnectionChecker(TFLogger logger) => _instance ??= ConnectionChecker._(logger);

  ConnectionChecker._(TFLogger logger) {
    _logger = logger;
    _connectivity = Connectivity();
    _connectionStatus = ConnectivityResult.none;
    _connectivitySubscription =
      _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _logger.logInfo('🛰 Updated Connection Status: $result');
    _connectionStatus = result;
  }

  ConnectivityResult get status => _connectionStatus;

  cancel() {
    _connectivitySubscription.cancel();
  }
}