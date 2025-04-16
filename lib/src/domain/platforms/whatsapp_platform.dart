abstract class WhatsAppPlatform {
  /// Shares a text message through WhatsApp
  /// 
  /// Returns true if the message was shared successfully, false otherwise
  Future<bool> shareText({required String text});
}