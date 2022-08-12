import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// ImageLoader is a helper to load asset images into [File] type
class ImageLoader {
  ImageLoader._() {
    _createFile();
  }

  /// A mock image to share
  late final File file;

  /// A Singleton instance of [ImageLoader]
  static final ImageLoader instance = ImageLoader._();

  Future<void> _createFile() async {
    const imageName = 'spacex-unspash.jpg';
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;

    file = File('$tempPath/$imageName');
    if (!file.existsSync()) {
      final imageBytes = await rootBundle.load('assets/$imageName');
      file.writeAsBytesSync(
        imageBytes.buffer.asUint8List(
          imageBytes.offsetInBytes,
          imageBytes.lengthInBytes,
        ),
      );
    }
  }
}
