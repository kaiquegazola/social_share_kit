import 'package:social_share_kit/src/domain/platforms/platforms.dart';
import 'package:social_share_kit/src/domain/services/platform_service_interface.dart';

class AppSignaturePlatformAdapter implements AppSignaturePlatform {
  AppSignaturePlatformAdapter({
    required PlatformServiceInterface platformService,
  }) : _platformService = platformService;

  final PlatformServiceInterface _platformService;

  @override
  Future<String?> getMd5AppSignature() {
    return _platformService.getMd5Signature();
  }
}
