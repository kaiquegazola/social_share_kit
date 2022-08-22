import 'dart:io';

abstract class TikTokPlatform {
  Future<bool> image({File? file, String? contentUrl});
  Future<bool> video({File? file, String? contentUrl});
  Future<bool> greenSreenImage({File? file, String? contentUrl});
  Future<bool> greenSreenVideo({File? file, String? contentUrl});
}
