import 'dart:io';
import 'dart:ui';

abstract class InstagramPlatform {
  Future<bool> storyImage({
    required File image,
    String? contentUrl,
    File? backgroundImage,
    Color? topBackgroundColor,
    Color? bottomBackgroundColor,
  });
  Future<bool> storyVideo({
    required File video,
    String? contentUrl,
  });
  Future<bool> post({required File file, String? contentUrl});
  Future<bool> direct({required File file, String? contentUrl});
  Future<bool> directText({required String message});
}
