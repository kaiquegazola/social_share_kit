class SocialShareEntity {
  SocialShareEntity({
    required this.platform,
    required this.content,
    required this.type,
  });

  final SocialPlaform platform;
  final Map content;
  final String type;
}

enum SocialPlaform {
  facebook,
  instagram,
  telegram,
  whatsapp,
  messenger,
  tiktok,
  twitter
}
