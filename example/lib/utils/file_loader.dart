import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// ImageLoader is a helper to load asset images into [File] type
class FileLoader {
  FileLoader._() {
    _loadAssetsInTemporaryDir();
  }

  /// A Singleton instance of [FileLoader]
  static final FileLoader instance = FileLoader._();

  /// A mock image to share
  late final File image;

  /// A mock video to share
  late final File video;

  /// Returns true if FileLoader completed load files
  bool get isFilesReady => _completer.isCompleted;

  final _completer = Completer<bool>();

  Future<void> _loadAssetsInTemporaryDir() async {
    await _createImage();
    await _createVideo();
    _completer.complete(true);
  }

  Future<void> _createImage() async {
    const imageName = 'spacex-unsplash.jpg';
    image = await _createFile(imageName);
  }

  Future<void> _createVideo() async {
    const videoName = 'iguassu-falls.mp4';
    video = await _createFile(videoName);
  }

  Future<File> _createFile(String fileName) async {
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;

    final file = File('$tempPath/$fileName');
    if (!file.existsSync()) {
      final fileBytes = await rootBundle.load('assets/$fileName');
      file.writeAsBytesSync(
        fileBytes.buffer.asUint8List(
          fileBytes.offsetInBytes,
          fileBytes.lengthInBytes,
        ),
      );
    }
    return file;
  }
}
