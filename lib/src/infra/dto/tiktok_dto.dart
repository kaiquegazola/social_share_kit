import 'dart:io';

class TikTokDTO {
  TikTokDTO({
    this.file,
  });

  final File? file;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'filePath': file?.path,
    };
  }
}
