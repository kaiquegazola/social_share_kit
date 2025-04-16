import 'package:social_share_kit/src/domain/domain.dart';
import 'package:social_share_kit/src/infra/model/model.dart';

class WhatsAppPlatformAdapter implements WhatsAppPlatform {
  WhatsAppPlatformAdapter({
    required SocialShareUseCase socialShare,
  }) : _socialShare = socialShare;

  final SocialShareUseCase _socialShare;
  final SocialPlaform _platform = SocialPlaform.whatsapp;

  @override
  Future<bool> shareText({required String text}) {
    return _socialShare.share<bool>(
      SocialShareEntity(
        platform: _platform,
        content: WhatsAppModel(
          text: text,
        ).toTextMap(),
        type: WhatsAppShareTypes.text.name,
      ),
    );
  }
}
