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

  Map<String, dynamic> toPhotoMap() {
    return <String, dynamic>{
      'photoPath': file?.path,
    };
  }
}
