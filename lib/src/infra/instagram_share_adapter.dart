import 'package:social_share_kit/src/domain/domain.dart';

class InstragramShareAdapter {
  const InstragramShareAdapter({required this.socialShare});

  final SocialShare socialShare;

  Future<void> story() async {
    try {
      await socialShare.share(SocialShareEntity(
        platform: SocialPlaform.instagram,
        content: {},
        type: '',
      ));
    } catch (_) {}
  }

  Future<void> post() async {
    try {
      await socialShare.share(SocialShareEntity(
        platform: SocialPlaform.instagram,
        content: {},
        type: '',
      ));
    } catch (_) {}
  }

  Future<void> direct() async {
    try {
      await socialShare.share(SocialShareEntity(
        platform: SocialPlaform.instagram,
        content: {},
        type: '',
      ));
    } catch (_) {}
  }
}
