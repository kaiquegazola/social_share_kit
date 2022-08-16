import 'package:social_share_kit/src/domain/entities/social_share_entity.dart';
import 'package:social_share_kit/src/domain/services/platform_service_interface.dart';
import 'package:social_share_kit/src/domain/usecases/usecases.dart';
import 'package:social_share_kit/src/infra/dto/dtos.dart';

class SocialShareUseCaseImpl implements SocialShareUseCase {
  SocialShareUseCaseImpl({
    required PlatformServiceInterface platformService,
  }) : _platformService = platformService;

  final PlatformServiceInterface _platformService;

  @override
  Future<T> share<T>(SocialShareEntity socialShare) {
    final dto = SocialShareDTO.fromEntity(socialShare);

    return _platformService.share<T>(
      dto.toMap(),
    );
  }
}
