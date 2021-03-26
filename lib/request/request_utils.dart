import 'package:api_service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:api_service/request/result.dart';
import 'package:api_service/exception/base_exception.dart';
import '../error/error_handler.dart';

/// Call this in repo api
Future<AppResult<T>> safeApiCall<T>(
    {Function? callFunctionMock,
    Function? callFunctionDevelop,
    Function? callFunctionProduct}) async {
  try {
    if (FlavorConfig.isMock()) {
      var data = await callFunctionMock?.call();
      return Success(data);
    } else if (FlavorConfig.isDevelopment()) {
      var data = await callFunctionDevelop?.call();
      return Success(data);
    } else {
      var data = await callFunctionProduct?.call();
      return Success(data);
    }
  } on DioError catch (e) {
    return Error(getDioException(e));
  } catch (e) {
    return Error(BaseException("Unknown error"));
  }
}
