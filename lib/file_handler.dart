import 'package:file_picker/file_picker.dart';
import 'dart:convert';

class FileHandler {
  Future<FilePickerResult?> pickFile() async {
    try {
      return await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['zip', 'json', 'html'],
        allowMultiple: false,
        withData: true,
      );
    } catch (e) {
      return null;
    }
  }

  String? getFileData(FilePickerResult result) {
    if (result.files.isNotEmpty) {
      final file = result.files.first;
      if (file.bytes != null) {
        return base64Encode(file.bytes!);
      }
    }
    return null;
  }

  String getFileType(String? extension) {
    return extension == 'zip' ? 'application/zip' : 'application/octet-stream';
  }

  String? getFileName(FilePickerResult result) {
    if (result.files.isNotEmpty) {
      return result.files.first.name;
    }
    return null;
  }
}
