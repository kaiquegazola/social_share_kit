import 'dart:io';
import 'dart:ui';

import 'package:social_share_kit/src/utils/color_extension.dart';

class InstagramModel {
  InstagramModel({
    this.file,
    this.backgroundFile,
    this.contentUrl,
    this.textMessage,
    this.topBackgroundColor,
    this.bottomBackgroundColor,
  });

  final File? file;
  final File? backgroundFile;
  final String? contentUrl;
  final String? textMessage;
  final Color? topBackgroundColor;
  final Color? bottomBackgroundColor;

  Map<String, dynamic> toPostMap() {
    return <String, dynamic>{
      'filePath': file?.path,
    };
  }

  Map<String, dynamic> toStoryImageMap() {
    return <String, dynamic>{
      'filePath': file?.path,
      'backgroundPath': backgroundFile?.path,
      'topBackgroundColor': topBackgroundColor?.colorToHex,
      'bottomBackgroundColor': bottomBackgroundColor?.colorToHex,
      'contentUrl': contentUrl,
    };
  }

  Map<String, dynamic> toStoryVideoMap() {
    return <String, dynamic>{
      'filePath': file?.path,
      'contentUrl': contentUrl,
    };
  }

  Map<String, dynamic> toDirectMap() {
    return <String, dynamic>{
      'textMessage': textMessage,
    };
  }
}
