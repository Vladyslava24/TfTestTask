import 'dart:io';
import 'package:core/src/network_client/default/default_network_client.dart';

class NetworkRequest {
  final RequestType type;
  late String _endpoint;
  final Map<String, String>? _headers = {};
  Map<String, dynamic>? body;

  String? jwt;

  //for multipart request
  List<FileFormData>? files;

  NetworkRequest._({
    required String endpoint,
    required this.type,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    this.jwt,
    this.body,
    this.files,
  }) {
    Map<String, dynamic> _queryParams = {};

    if (queryParameters != null) {
      _queryParams.addAll(queryParameters);
    }

    _endpoint = "$endpoint${_makeQuery(_queryParams)}";
    _headers!.addAll(_defaultHeaders);
    if (headers != null) {
      _headers!.addAll(headers);
    }
    if (jwt != null) {
      _headers?.putIfAbsent("Authorization", () => "Bearer $jwt");
    }
  }

  factory NetworkRequest.post({
    required String endpoint,
    Map<String, String>? headers,
    String? jwt,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters}) =>
      NetworkRequest._(
        type: RequestType.post,
        endpoint: endpoint,
        headers: headers,
        jwt: jwt,
        body: body,
        queryParameters: queryParameters
      );

  factory NetworkRequest.get({
    required String endpoint,
    Map<String, String>? headers,
    String? jwt,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters
  }) =>
    NetworkRequest._(
      type: RequestType.get,
      endpoint: endpoint,
      headers: headers,
      jwt: jwt,
      body: body,
      queryParameters: queryParameters
    );

  factory NetworkRequest.put({
    required String endpoint,
    Map<String, String>? headers,
    String? jwt,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters
  }) =>
    NetworkRequest._(
      type: RequestType.put,
      endpoint: endpoint,
      headers: headers,
      jwt: jwt,
      body: body,
      queryParameters: queryParameters
    );

  factory NetworkRequest.delete({
    required String endpoint,
    Map<String, String>? headers,
    String? jwt,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters
  }) =>
    NetworkRequest._(
      type: RequestType.delete,
      endpoint: endpoint,
      headers: headers,
      jwt: jwt,
      body: body,
      queryParameters: queryParameters
    );

  factory NetworkRequest.postMultipart({
    required String endpoint,
    required List<FileFormData> files,
    Map<String, String>? headers,
    String? jwt,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters
  }) =>
    NetworkRequest._(
      type: RequestType.postMultipart,
      endpoint: endpoint,
      headers: headers,
      files: files,
      jwt: jwt,
      body: body,
      queryParameters: queryParameters
    );

  String get url => _endpoint;

  Map<String, String>? get headers => _headers;

  String _makeQuery(Map<String, dynamic>? queryParameters) {
    if (queryParameters == null) return "";

    var result = StringBuffer();
    result.write('?');
    var separator = "";

    void writeParameter(String key, String? value) {
      result.write(separator);
      separator = "&";
      result.write(key);
      if (value != null && value.isNotEmpty) {
        result.write("=");
        result.write(value);
      }
    }

    queryParameters.forEach((key, value) {
      if (value == null || value is String) {
        writeParameter(key, value);
      } else {
        Iterable values = value;
        for (String value in values) {
          writeParameter(key, value);
        }
      }
    });
    return result.toString();
  }

  @override
  String toString() => 'NetworkRequest: $url, type: $type';
}

enum RequestType { get, post, put, delete, postMultipart }

const _defaultHeaders = {
  "Accept": "application/json",
  "Content-Type": "application/json; charset=utf-8",
  'Charset': 'utf-8'
};

class AppLocale {
  final String locale;

  const AppLocale._({ required this.locale });

  Map<String, String> toMap() => { "locale": locale };

  static AppLocale get() {
    final locale = Platform.localeName.substring(0,2);
    return AppLocale._(locale: locale);
  }
}
