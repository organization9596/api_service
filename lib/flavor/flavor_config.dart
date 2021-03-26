import 'package:api_service/service/service_config.dart';

enum Flavor { DEVELOP, PRODUCTION, MOCK }

// Use flutter_secure_storage for sensitive data
class FlavorValues {
  FlavorValues({required this.baseUrl});

  final String baseUrl;
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final FlavorValues values;
  static FlavorConfig? _instance;

  factory FlavorConfig({required Flavor flavor, required FlavorValues values}) {
    _instance ??= FlavorConfig._internal(flavor, flavor.toString(), values);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.values);

  static FlavorConfig get instance {
    return _instance!;
  }

  static bool isProduction() => _instance!.flavor == Flavor.PRODUCTION;

  static bool isDevelopment() => _instance!.flavor == Flavor.DEVELOP;

  static bool isMock() => _instance!.flavor == Flavor.MOCK;
}

FlavorValues getDevelopFlavorValue(ServerConfig serverConfig) =>
    FlavorValues(baseUrl: serverConfig.getDevelopBaseUrl());

FlavorValues getProductionFlavorValue(ServerConfig serverConfig) =>
    FlavorValues(baseUrl: serverConfig.getProductBaseUrl());

FlavorValues getMockFlavorValue(ServerConfig serverConfig) =>
    FlavorValues(baseUrl: serverConfig.getMockBaseUrl());


