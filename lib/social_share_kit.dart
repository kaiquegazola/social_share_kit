import 'package:social_share_kit/social_share_kit_platform_interface.dart';

class SocialShareKit {
  Future<String?> getPlatformVersion() {
    return SocialShareKitPlatform.instance.getPlatformVersion();
  }
}
