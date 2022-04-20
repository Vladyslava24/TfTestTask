import 'dart:convert';
import 'dart:typed_data';
import 'package:core/src/logger/tf_logger.dart';
import 'package:core/src/network_client/client/network_client.dart';
import 'package:core/src/network_client/exception/api_exception.dart';
import 'package:core/src/network_client/model/network_request.dart';
import 'package:core/src/network_client/model/network_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class DefaultHttpClient extends NetworkClient {
  DefaultHttpClient(String baseUrl, TFLogger logger) : super(baseUrl) {
    _logger = logger;
  }

  TFLogger? _logger;

  @override
  Future<NetworkResponse> executeRequest(NetworkRequest request) async {
    final uri = Uri.parse('$baseUrl${request.url}');
    _logger!.logInfo('${request.type}: $uri');
    Object? body;
    final b = request.body;
    if (b != null) {
      body = json.encode(request.body);
    }

    try {
      switch (request.type) {
        case RequestType.get:
          final response = await http.get(uri, headers: request.headers);
          return response.toHttpResponse();
        case RequestType.post:
          final response = await http.post(uri, headers: request.headers, body: body);
          return response.toHttpResponse();
        case RequestType.put:
          final response = await http.put(uri, headers: request.headers, body: body);
          return response.toHttpResponse();
        case RequestType.delete:
          final response = await http.delete(uri, headers: request.headers, body: body);
          return response.toHttpResponse();
        case RequestType.postMultipart:
          var multipartRequest = http.MultipartRequest('POST', uri);
          multipartRequest.files
              .addAll(request.files!.map((e) => http.MultipartFile.fromBytes('file', e.bytes, filename: e.name)));
          var response = await http.Response.fromStream(await multipartRequest.send());

          return response.toHttpResponse();
      }
    } on ApiException catch(e) {
      _logger!.logError('ApiException: $uri request error: $e, ${e.message}, ${e.serverLogMessage}');
      rethrow;
    } catch (e) {
      _logger!.logError('Exception: $uri, request error: $e');
      rethrow;
    }
  }
}

class FileFormData {
  final Uint8List bytes;
  final String name;

  FileFormData({required this.bytes, required this.name});
}

extension on Response {
  NetworkResponse toHttpResponse() {

    final stringResponse = utf8.decode(bodyBytes);
    final decodedResponse = stringResponse.isNotEmpty ?
      json.decode(stringResponse) : '';
    final decodedHeaders = Map<String, dynamic>.of(headers);

    if (statusCode != 200 && statusCode != 201) {
      decodedResponse.isNotEmpty ?
        throw ApiException.fromErrorBody(decodedResponse) :
        throw ApiException(
          serverErrorCode: statusCode,
          serverErrorMessage: 'Unhandled empty response',
          serverLogMessage: 'Unhandled empty response',
        );
    }

    return NetworkResponse(
      statusCode: statusCode,
      headers: decodedHeaders,
      body: decodedResponse
    );
  }
}
