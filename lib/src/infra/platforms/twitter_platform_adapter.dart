import 'package:social_share_kit/src/domain/domain.dart';
import 'package:social_share_kit/src/infra/model/model.dart';

class TwitterPlatformAdapter implements TwitterPlatform {
  TwitterPlatformAdapter({
    required SocialShareUseCase socialShare,
  }) : _socialShare = socialShare;

  final SocialShareUseCase _socialShare;
  final SocialPlaform _platform = SocialPlaform.twitter;

  @override
  Future<bool> textTweet({required String text}) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: _platform,
        content: TwitterModel(
          text: text,
        ).toTextMap(),
        type: TwitterShareType.text.name,
      ),
    );
  }
}
