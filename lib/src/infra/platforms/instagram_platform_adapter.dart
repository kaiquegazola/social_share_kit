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
  Future<bool> storyImage({
    required File image,
    String? contentUrl,
    File? backgroundImage,
    Color? topBackgroundColor,
    Color? bottomBackgroundColor,
  }) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: platform,
        content: InstagramModel(
          file: image,
          backgroundFile: backgroundImage,
          contentUrl: contentUrl,
          bottomBackgroundColor: bottomBackgroundColor,
          topBackgroundColor: topBackgroundColor,
        ).toStoryMap(),
        type: InstagramShareType.storyImage.name,
      ),
    );
  }

  @override
  Future<bool> storyVideo({
    required File video,
    String? contentUrl,
  }) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: platform,
        content: InstagramModel(
          file: video,
          contentUrl: contentUrl,
        ).toStoryMap(),
        type: InstagramShareType.storyVideo.name,
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
