import 'package:api_service/exception/base_exception.dart';

enum ResultType { SUCCESS, ERROR }

abstract class AppResult<T> {
  ResultType getResultType();
}

class Success<T> extends AppResult<T> {
  final T _data;

  Success(this._data);

  T get data => _data;

  @override
  ResultType getResultType() {
    return ResultType.SUCCESS;
  }
}

class Error<T> extends AppResult<T> {
  final BaseException _exception;

  Error(this._exception);

  BaseException get exception => _exception;

  @override
  ResultType getResultType() {
    return ResultType.ERROR;
  }
}
