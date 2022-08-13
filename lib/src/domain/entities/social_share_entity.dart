class SocialShareEntity {
  SocialShareEntity({required this.platform, required this.content});

  final SocialPlaform platform;
  final Map content;
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
