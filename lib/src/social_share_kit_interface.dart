import 'package:social_share_kit/src/domain/platforms/platforms.dart';

abstract class SocialShareKitInterface {
  InstagramPlatform get instagram;
  TikTokPlatform get tiktok;
  Future<Map<String, bool>> getAvailableApps();
  Future<String?> getMd5Signature();
}
