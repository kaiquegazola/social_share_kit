import 'package:social_share_kit/src/domain/platforms/platforms.dart';
import 'package:social_share_kit/src/domain/services/platform_service_interface.dart';

class AvailableAppsPlatformAdapter implements AvailableAppsPlatform {
  AvailableAppsPlatformAdapter({
    required PlatformServiceInterface platformService,
  }) : _platformService = platformService;

  final PlatformServiceInterface _platformService;

  @override
  Future<Map<String, bool>> getAvailableApps() {
    return _platformService.getAvailableApps();
  }
}
