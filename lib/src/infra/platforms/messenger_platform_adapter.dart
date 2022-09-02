import 'package:social_share_kit/src/domain/domain.dart';
import 'package:social_share_kit/src/infra/dto/dtos.dart';

class MessengerPlatformAdapter implements MessengerPlatform {
  MessengerPlatformAdapter({
    required SocialShareUseCase socialShare,
  }) : _socialShare = socialShare;

  final SocialShareUseCase _socialShare;
  final SocialPlaform _platform = SocialPlaform.messenger;

  @override
  Future<bool> link({required String link}) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: _platform,
        content: MessengerDTO(
          link: link,
        ).toMap(),
        type: MessengerShareType.link.name,
      ),
    );
  }
}
