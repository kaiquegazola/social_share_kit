import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:social_share_kit/social_share_kit.dart';
import 'package:social_share_kit/social_share_kit_method_channel.dart';
import 'package:social_share_kit/social_share_kit_platform_interface.dart';

class MockSocialShareKitPlatform
    with MockPlatformInterfaceMixin
    implements SocialShareKitPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final initialPlatform = SocialShareKitPlatform.instance;

  test('$MethodChannelSocialShareKit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSocialShareKit>());
  });

  test('getPlatformVersion', () async {
    final socialShareKitPlugin = SocialShareKit();
    final fakePlatform = MockSocialShareKitPlatform();
    SocialShareKitPlatform.instance = fakePlatform;

    expect(await socialShareKitPlugin.getPlatformVersion(), '42');
  });
}
