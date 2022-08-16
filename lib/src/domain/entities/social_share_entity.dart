import 'package:social_share_kit/src/domain/domain.dart';

class SocialShareEntity {
  SocialShareEntity({
    required this.platform,
    required this.content,
    required this.type,
  });

  final SocialPlaform platform;
  final Map<String, dynamic> content;
  final String type;
}
