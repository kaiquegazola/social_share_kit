import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:social_share_kit/social_share_kit_method_channel.dart';

abstract class SocialShareKitPlatform extends PlatformInterface {
  /// Constructs a SocialShareKitPlatform.
  SocialShareKitPlatform() : super(token: _token);

  static final Object _token = Object();

  static SocialShareKitPlatform _instance = MethodChannelSocialShareKit();

  /// The default instance of [SocialShareKitPlatform] to use.
  ///
  /// Defaults to [MethodChannelSocialShareKit].
  static SocialShareKitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SocialShareKitPlatform] when
  /// they register themselves.
  static set instance(SocialShareKitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
