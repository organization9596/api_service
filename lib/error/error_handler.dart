import 'package:dio/dio.dart';
import 'package:api_service/exception/base_exception.dart';

BaseException getDioException(DioError dioError) {
  String errorMes = "";
  switch (dioError.type) {
    case DioErrorType.CANCEL:
      errorMes = "Request was cancelled";
      break;
    case DioErrorType.CONNECT_TIMEOUT:
      errorMes = "Connection timeout";
      break;
    case DioErrorType.DEFAULT:
      errorMes = "Connection failed due to internet connection";
      break;
    case DioErrorType.RECEIVE_TIMEOUT:
      errorMes = "Receive timeout in connection";
      break;
    case DioErrorType.RESPONSE:
      // check json message in data to convert error
      errorMes = "Error: ${dioError.response?.data?.toString()}";
      break;
    case DioErrorType.SEND_TIMEOUT:
      errorMes = "Receive timeout in send request";
      break;
  }
  return BaseException(errorMes, errorCode: dioError.response?.statusCode);
}
