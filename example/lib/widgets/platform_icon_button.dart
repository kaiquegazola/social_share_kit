import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlatformIconButton extends StatelessWidget {
  const PlatformIconButton({
    super.key,
    required this.platformName,
    required this.action,
    required this.onPressed,
  });

  final String platformName;
  final VoidCallback onPressed;
  final String action;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: FaIcon(_icon),
      onPressed: onPressed,
      label: Text(platformName),
    );
  }

  IconData get _icon {
    switch (platformName.toLowerCase()) {
      case 'facebook':
        return FontAwesomeIcons.facebook;
      case 'instagram':
        return FontAwesomeIcons.instagram;
      case 'telegram':
        return FontAwesomeIcons.telegram;
      case 'whatsapp':
        return FontAwesomeIcons.whatsapp;
      case 'messenger':
        return FontAwesomeIcons.facebookMessenger;
      case 'tiktok':
        return FontAwesomeIcons.tiktok;
      case 'twitter':
        return FontAwesomeIcons.twitter;
    }
    return FontAwesomeIcons.asterisk;
  }
}
