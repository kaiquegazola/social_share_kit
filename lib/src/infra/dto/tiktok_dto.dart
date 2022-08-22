import 'dart:io';

class TikTokDTO {
  TikTokDTO({
    this.file,
  });

  final File? file;

  Map<String, dynamic> toVideoMap() {
    return <String, dynamic>{
      'videoPath': file?.path,
    };
  }

  Map<String, dynamic> toImageMap() {
    return <String, dynamic>{
      'imagePath': file?.path,
    };
  }
}
