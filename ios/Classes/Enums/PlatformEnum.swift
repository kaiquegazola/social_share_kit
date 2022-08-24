public enum PlatformEnum: String {
    case facebook = "facebook-stories://share",
         instagram = "instagram-stories://",
         telegram = "tg://",
         whatsapp = "whatsapp://",
         messenger = "fb-messenger://",
         twitter = "twitter://"

    public static let values = [facebook, instagram, telegram, whatsapp, messenger, twitter]
}
