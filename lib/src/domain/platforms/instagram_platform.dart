import 'dart:io';

abstract class InstagramPlatform {
  Future<bool> story({required File file, String? contentUrl});
  Future<bool> post({required File file, String? contentUrl});
  Future<bool> direct({required File file, String? contentUrl});
  Future<bool> directMessage({required String message});
}
