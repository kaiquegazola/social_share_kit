import 'dart:io';

import 'package:social_share_kit/src/domain/domain.dart';
import 'package:social_share_kit/src/infra/dto/dtos.dart';

class InstagramPlatformAdapter implements InstagramPlatform {
  InstagramPlatformAdapter({
    required SocialShareUseCase socialShare,
  }) : _socialShare = socialShare;

  final SocialShareUseCase _socialShare;
  final SocialPlaform platform = SocialPlaform.instagram;

  @override
  Future<bool> direct({required File file, String? contentUrl}) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: platform,
        content: InstagramDTO(
          file: file,
          backgroundFile: file,
          contentUrl: contentUrl,
        ).toMap(),
        type: InstagramShareType.direct.name,
      ),
    );
  }

  @override
  Future<bool> post({required File file, String? contentUrl}) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: platform,
        content: InstagramDTO(
          file: file,
          backgroundFile: file,
          contentUrl: contentUrl,
        ).toMap(),
        type: InstagramShareType.post.name,
      ),
    );
  }

  @override
  Future<bool> story({required File file, String? contentUrl}) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: platform,
        content: InstagramDTO(
          file: file,
          backgroundFile: file,
          contentUrl: contentUrl,
        ).toMap(),
        type: InstagramShareType.story.name,
      ),
    );
  }

  @override
  Future<bool> directMessage({required String message}) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: platform,
        content: InstagramDTO(
          textMessage: message,
        ).toMap(),
        type: InstagramShareType.directText.name,
      ),
    );
  }
}
