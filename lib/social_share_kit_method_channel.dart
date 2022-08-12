import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:social_share_kit/social_share_kit_platform_interface.dart';

/// An implementation of [SocialShareKitPlatform] that uses method channels.
class MethodChannelSocialShareKit extends SocialShareKitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('social_share_kit');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
