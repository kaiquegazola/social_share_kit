import 'dart:io';

import 'package:social_share_kit/src/domain/domain.dart';
import 'package:social_share_kit/src/infra/dto/dtos.dart';

class TikTokPlatformAdapter implements TikTokPlatform {
  TikTokPlatformAdapter({
    required SocialShareUseCase socialShare,
  }) : _socialShare = socialShare;

  final SocialShareUseCase _socialShare;
  final SocialPlaform _platform = SocialPlaform.tiktok;

  @override
  Future<bool> greenSreenImage({File? file}) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: _platform,
        content: TikTokDTO(
          file: file,
        ).toMap(),
        type: TikTokShareType.greenScreenImage.name,
      ),
    );
  }

  @override
  Future<bool> greenSreenVideo({File? file}) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: _platform,
        content: TikTokDTO(
          file: file,
        ).toMap(),
        type: TikTokShareType.greenScreenVideo.name,
      ),
    );
  }

  @override
  Future<bool> image({File? file}) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: _platform,
        content: TikTokDTO(
          file: file,
        ).toMap(),
        type: TikTokShareType.image.name,
      ),
    );
  }

  @override
  Future<bool> video({File? file}) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: _platform,
        content: TikTokDTO(
          file: file,
        ).toMap(),
        type: TikTokShareType.video.name,
      ),
    );
  }
}
