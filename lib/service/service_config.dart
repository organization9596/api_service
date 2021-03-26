import 'package:dio/dio.dart';

class ServerConfig {
  final String? _productBaseUrl;
  final String? _mockBaseUrl;
  final String? _developBaseUrl;
  final int? _timeOut;
  final List<Interceptor>? _interceptors;
  Dio? _restClient;

  ServerConfig(ServiceConfigBuilder builder)
      : _productBaseUrl = builder.productBaseUrl,
        _mockBaseUrl = builder.mockBaseUrl,
        _developBaseUrl = builder.developBaseUrl,
        _timeOut = builder.timeOut,
        _interceptors = builder.interceptors;

  Dio getRestClient() {
    if (_restClient == null) {
      _restClient = Dio()
        ..options =
            BaseOptions(receiveTimeout: _timeOut, connectTimeout: _timeOut)
        ..interceptors?.addAll(_interceptors ?? [Interceptor()]);
    }
    return _restClient ?? Dio();
  }

  String getProductBaseUrl() {
    return _productBaseUrl ?? "";
  }

  String getMockBaseUrl() {
    return _mockBaseUrl ?? "";
  }

  String getDevelopBaseUrl() {
    return _developBaseUrl ?? "";
  }
}

class ServiceConfigBuilder {
  String? productBaseUrl;
  String? mockBaseUrl;
  String? developBaseUrl;
  int? timeOut;
  List<Interceptor>? interceptors;
}
