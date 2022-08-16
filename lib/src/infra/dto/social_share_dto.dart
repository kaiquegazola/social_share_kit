import 'package:social_share_kit/src/domain/domain.dart';

class SocialShareDTO extends SocialShareEntity {
  SocialShareDTO({
    required super.platform,
    required super.content,
    required super.type,
  });

  factory SocialShareDTO.fromEntity(SocialShareEntity entity) {
    return SocialShareDTO(
      platform: entity.platform,
      content: entity.content,
      type: entity.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'platform': platform.name,
      'content': content,
      'type': type,
    };
  }
}
