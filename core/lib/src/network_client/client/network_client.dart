import 'package:core/src/network_client/model/network_request.dart';
import 'package:core/src/network_client/model/network_response.dart';

abstract class NetworkClient {
  final String baseUrl;

  NetworkClient(this.baseUrl);

  Future<NetworkResponse> executeRequest(NetworkRequest request);
}
