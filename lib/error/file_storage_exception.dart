import 'package:api_service/exception/file_exception.dart';

class FileNotFoundStorageException extends FileException {
  FileNotFoundStorageException([String? message])
      : super(ErrorLocalException.FILE_NOT_FOUND, "");
}

class ErrorFileStorageException extends FileException {
  ErrorFileStorageException([String? message])
      : super(ErrorLocalException.FILE_STORAGE_IO_EXCEPTION, "");
}

class ErrorLocalException {
  static const String DATA_NOT_NULL = "data must be not null";
  static const String FILE_NOT_FOUND = "File not found";
  static const String FILE_STORAGE_IO_EXCEPTION =
      "read/write process has error";
}
