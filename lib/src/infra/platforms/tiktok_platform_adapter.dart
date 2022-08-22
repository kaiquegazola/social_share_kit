import 'dart:io';

import 'package:social_share_kit/src/domain/domain.dart';
import 'package:social_share_kit/src/infra/dto/dtos.dart';

class TikTokPlatformAdapter implements TikTokPlatform {
  TikTokPlatformAdapter({
    required SocialShareUseCase socialShare,
  }) : _socialShare = socialShare;

  final SocialShareUseCase _socialShare;
  final SocialPlaform platform = SocialPlaform.tiktok;

  @override
  Future<bool> greenSreenImage({File? file, String? contentUrl}) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: platform,
        content: TikTokDTO(
          file: file,
        ).toImageMap(),
        type: TikTokShareType.greenScreenImage.name,
      ),
    );
  }

  @override
  Future<bool> greenSreenVideo({File? file, String? contentUrl}) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: platform,
        content: TikTokDTO(
          file: file,
        ).toVideoMap(),
        type: TikTokShareType.greenScreenVideo.name,
      ),
    );
  }

  @override
  Future<bool> image({File? file, String? contentUrl}) {
    // TODO: implement image
    throw UnimplementedError();
  }

  @override
  Future<bool> video({File? file, String? contentUrl}) {
    // TODO: implement video
    throw UnimplementedError();
  }
}
