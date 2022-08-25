import 'dart:io';

abstract class TikTokPlatform {
  Future<bool> image({File? file});
  Future<bool> video({File? file});
  Future<bool> greenSreenImage({File? file});
  Future<bool> greenSreenVideo({File? file});
}
