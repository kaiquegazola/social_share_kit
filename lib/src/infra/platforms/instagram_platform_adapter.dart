import 'dart:io';
import 'dart:ui';

import 'package:social_share_kit/src/domain/domain.dart';
import 'package:social_share_kit/src/infra/model/model.dart';

class InstagramPlatformAdapter implements InstagramPlatform {
  InstagramPlatformAdapter({
    required SocialShareUseCase socialShare,
  }) : _socialShare = socialShare;

  final SocialShareUseCase _socialShare;
  final SocialPlaform platform = SocialPlaform.instagram;

  @override
  Future<bool> post({required File file, String? contentUrl}) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: platform,
        content: InstagramModel(
          file: file,
        ).toPostMap(),
        type: InstagramShareType.post.name,
      ),
    );
  }

  @override
  Future<bool> story({
    required File file,
    String? contentUrl,
    File? backgroundImage,
    Color? topBackgroundColor,
    Color? bottomBackgroundColor,
  }) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: platform,
        content: InstagramModel(
          file: file,
          backgroundFile: backgroundImage,
          contentUrl: contentUrl,
          bottomBackgroundColor: bottomBackgroundColor,
          topBackgroundColor: topBackgroundColor,
        ).toStoryMap(),
        type: InstagramShareType.story.name,
      ),
    );
  }

  @override
  Future<bool> directText({required String message}) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: platform,
        content: InstagramModel(
          textMessage: message,
        ).toDirectMap(),
        type: InstagramShareType.directText.name,
      ),
    );
  }
}
