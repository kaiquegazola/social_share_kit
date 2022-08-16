import 'dart:io';

abstract class TikTokPlatform {
  Future<bool> photo({File? file, String? contentUrl});
  Future<bool> video({File? file, String? contentUrl});
  Future<bool> greenSreenPhoto({File? file, String? contentUrl});
  Future<bool> greenSreenVideo({File? file, String? contentUrl});
}
