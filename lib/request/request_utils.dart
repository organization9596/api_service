import 'package:dio/dio.dart';
import 'package:api_service/request/result.dart';
import 'package:api_service/exception/base_exception.dart';
import '../error/error_handler.dart';

Future<AppResult<T>> safeApiCall<T>(Function callFunction) async {
  try {
    var data = await callFunction.call();
    return Success(data);
  } on DioError catch (e) {
    return Error(getDioException(e));
  } catch (e) {
    return Error(BaseException("Unknown error"));
  }
}
