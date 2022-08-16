import 'package:social_share_kit/src/domain/domain.dart';

abstract class SocialShareUseCase {
  Future<T> share<T>(SocialShareEntity socialShare);
}
