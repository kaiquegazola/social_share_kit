import 'package:get_it/get_it.dart';
import 'package:social_share_kit/src/domain/domain.dart';
import 'package:social_share_kit/src/infra/infra.dart';
import 'package:social_share_kit/src/infra/platforms/twitter_platform_adapter.dart';

/// It's a class that can be used to inject dependencies into other classes
class Di {
  /// Init all project dependencies
  static void init() {
    _initMethodChannel();
    _initAvailableApps();
    _initAppSignature();
    _initSocialShare();
    _initInstagram();
    _initTikTok();
    _initMessenger();
    _initTwitter();
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

  static void _initAppSignature() {
    GetIt.I.registerFactory<AppSignaturePlatform>(
      () => AppSignaturePlatformAdapter(
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

  static void _initTikTok() {
    GetIt.I.registerFactory<TikTokPlatform>(
      () => TikTokPlatformAdapter(
        socialShare: GetIt.I.get(),
      ),
    );
  }

  static void _initMessenger() {
    GetIt.I.registerFactory<MessengerPlatform>(
      () => MessengerPlatformAdapter(
        socialShare: GetIt.I.get(),
      ),
    );
  }

  static void _initTwitter() {
    GetIt.I.registerFactory<TwitterPlatform>(
      () => TwitterPlatformAdapter(
        socialShare: GetIt.I.get(),
      ),
    );
  }
}
