import 'dart:io';

class TikTokModel {
  TikTokModel({
    this.file,
  });

  final File? file;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'filePath': file?.path,
    };
  }
}
