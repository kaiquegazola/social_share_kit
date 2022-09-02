import 'package:get_it/get_it.dart';
import 'package:social_share_kit/src/di.dart';
import 'package:social_share_kit/src/domain/domain.dart';
import 'package:social_share_kit/src/domain/platforms/platforms.dart';
import 'package:social_share_kit/src/social_share_kit_interface.dart';

class _SocialShareKit implements SocialShareKitInterface {
  _SocialShareKit._() {
    Di.init();
  }

  static final _SocialShareKit instance = _SocialShareKit._();

  /// Static getter to get the Facebook share instance
  @override
  InstagramPlatform get instagram => GetIt.I.get();

  /// Static getter to get the TikTok share instance
  @override
  TikTokPlatform get tiktok => GetIt.I.get();

  /// Static getter to get the Messenger share instance
  @override
  MessengerPlatform get messenger => GetIt.I.get();

  /// Returns an Map with the possible apps to share
  ///
  /// May return an empty map if it is not possible to get the share available
  /// apps list.
  @override
  Future<Map<String, bool>> getAvailableApps() {
    return GetIt.I.get<AvailableAppsPlatform>().getAvailableApps();
  }

  @override

  /// This function returns the md5 signature of the application, useful for
  /// registering in TikTok Developers.
  ///
  /// Only works on Android
  @override
  Future<String?> getMd5Signature() {
    return GetIt.I.get<AppSignaturePlatform>().getMd5AppSignature();
  }
}

// ignore: non_constant_identifier_names
SocialShareKitInterface get SocialShareKit => _SocialShareKit.instance;
