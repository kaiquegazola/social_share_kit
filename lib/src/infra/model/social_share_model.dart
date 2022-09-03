import 'package:social_share_kit/src/domain/domain.dart';

class SocialShareModel extends SocialShareEntity {
  SocialShareModel({
    required super.platform,
    required super.content,
    required super.type,
  });

  factory SocialShareModel.fromEntity(SocialShareEntity entity) {
    return SocialShareModel(
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
