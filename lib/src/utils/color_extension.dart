import 'dart:ui';

extension ColorExtension on Color {
  String get colorToHex {
    return '#${value.toRadixString(16).substring(2)}';
  }
}
