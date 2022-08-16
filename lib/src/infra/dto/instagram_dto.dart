import 'dart:io';

class InstagramDTO {
  InstagramDTO({
    this.file,
    this.backgroundFile,
    this.contentUrl,
  });

  final File? file;
  final File? backgroundFile;
  final String? contentUrl;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'filePath': file?.path,
      'backgroundPath': backgroundFile?.path,
      'contentUrl': contentUrl,
    };
  }
}
