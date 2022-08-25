import 'dart:io';

class InstagramDTO {
  InstagramDTO({
    this.file,
    this.backgroundFile,
    this.contentUrl,
    this.textMessage,
  });

  final File? file;
  final File? backgroundFile;
  final String? contentUrl;
  final String? textMessage;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'filePath': file?.path,
      'backgroundPath': backgroundFile?.path,
      'contentUrl': contentUrl,
      'textMessage': textMessage,
    };
  }
}
