import 'dart:io';
import 'dart:ui';

abstract class InstagramPlatform {
  Future<bool> story({
    required File file,
    String? contentUrl,
    File? backgroundImage,
    Color? topBackgroundColor,
    Color? bottomBackgroundColor,
  });
  Future<bool> post({required File file, String? contentUrl});
  Future<bool> directText({required String message});
}
