class BaseException {
  final int? errorCode;
  final String errorMessage;

  BaseException(this.errorMessage, {this.errorCode});
}