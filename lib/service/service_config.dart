import 'package:dio/dio.dart';

class ServerConfig {
  String? productBaseUrl;
  String? mockBaseUrl;
  String? developBaseUrl;
  String? url;
  int? timeOut;
  Interceptor? interceptor;
  Dio? restClient;
  static ServerConfig? _instance;

  static ServerConfig getInstace(
      {String? url,
      int? timeOut,
      String? productBaseUrl,
      String? developBaseUrl,
      String? mockBaseUrl,
      Interceptor? interceptor}) {
    if (_instance == null) {
      _instance = ServerConfig.inital(
          url: url,
          timeOut: timeOut,
          productBaseUrl: productBaseUrl,
          mockBaseUrl: mockBaseUrl,
          developBaseUrl: developBaseUrl,
          interceptor: interceptor);
    }
    return _instance!;
  }

  ServerConfig.inital(
      {this.url,
      this.timeOut,
      this.productBaseUrl,
      this.developBaseUrl,
      this.mockBaseUrl,
      this.interceptor}) {
    restClient = Dio()
      ..options = BaseOptions(receiveTimeout: timeOut, connectTimeout: timeOut)
      ..interceptors?.addAll([interceptor ?? Interceptor()]);
  }
}
