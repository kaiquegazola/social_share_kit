import 'package:social_share_kit/src/domain/domain.dart';

abstract class SocialShare {
  Future<void> share(SocialShareEntity socialShare);
}
