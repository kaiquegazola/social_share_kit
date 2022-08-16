import 'dart:io';

abstract class InstagramPlatform {
  Future<bool> story({File? file, String? contentUrl});
  Future<bool> post({File? file, String? contentUrl});
  Future<bool> direct({File? file, String? contentUrl});
}
