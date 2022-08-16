import 'package:get_it/get_it.dart';
import 'package:social_share_kit/src/domain/domain.dart';
import 'package:social_share_kit/src/infra/infra.dart';

class Di {
  static void init() {
    _initMethodChannel();
    _initAvailableApps();
    _initSocialShare();
    _initInstagram();
    _tiktokInstagram();
  }

  static void _initMethodChannel() {
    GetIt.I.registerSingleton<PlatformServiceInterface>(
      MethodChannelPlatformService(),
    );
  }

  static void _initAvailableApps() {
    GetIt.I.registerFactory<AvailableAppsPlatform>(
      () => AvailableAppsPlatformAdapter(
        platformService: GetIt.I.get(),
      ),
    );
  }

  static void _initSocialShare() {
    GetIt.I.registerSingleton<SocialShareUseCase>(
      SocialShareUseCaseImpl(
        platformService: GetIt.I.get(),
      ),
    );
  }

  static void _initInstagram() {
    GetIt.I.registerFactory<InstagramPlatform>(
          () => InstagramPlatformAdapter(
        socialShare: GetIt.I.get(),
      ),
    );
  }

  static void _tiktokInstagram() {
    GetIt.I.registerFactory<TikTokPlatform>(
          () => TikTokPlatformAdapter(
        socialShare: GetIt.I.get(),
      ),
    );
  }
}
