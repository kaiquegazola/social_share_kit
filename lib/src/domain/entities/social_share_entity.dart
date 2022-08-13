class SocialShareEntity {
  SocialShareEntity({required this.platform, required this.content});

  final SocialPlaform platform;
  final dynamic content;
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
