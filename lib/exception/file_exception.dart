class FileException implements Exception {
  final _prefix;
  final _message;

  String get message => _message;

  FileException([this._message, this._prefix]);

  @override
  String toString() {
    return 'BaseException{_prefix: $_prefix, _message: $_message}';
  }
}


