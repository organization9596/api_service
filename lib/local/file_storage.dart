import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:api_service/error/file_storage_exception.dart';

class FileStorage {
  Future<String> readFile(String filePath) async {
    Directory directory = await getApplicationDocumentsDirectory();
    if (directory == null) {
      throw ErrorFileStorageException();
    }

    File file = File(directory.path + "/" + filePath);
    bool isExist = await file.exists();
    if (isExist) {
      return file.readAsString();
    } else {
      throw FileNotFoundStorageException();
    }
  }

  Future<void> writeFile(String filePath, String content) async {
    Directory directory = await getApplicationDocumentsDirectory();
    if (directory == null) {
      throw ErrorFileStorageException();
    }
    File file = File(directory.path + "/" + filePath);

    bool isExist = await file.exists();
    if (!isExist) {
      await file.create(recursive: true);
    }
    await file.writeAsString(content);
  }

  Future<void> deleteFolder(String folderName) async {
    Directory directory = await getApplicationDocumentsDirectory();
    Directory folder = Directory(directory.path + "/" + folderName);
    await folder.delete(recursive: true);
  }

  Future<void> deleteFile(String filePath) async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File(directory.path + "/" + filePath);
    await file.delete();
  }
}
