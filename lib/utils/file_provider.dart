import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileProvider {
  static Future<File> moveToTempDir(File file) async {
    try {
      final tempDir = await getTemporaryDirectory();
      if (file.path.startsWith(tempDir.path)) {
        return file;
      } else {
        return file.copy(tempDir.path);
      }
    } catch (_) {
      rethrow;
    }
  }
}
