import Foundation

class InstagramPlatform {
    private static var PARAM_NAME_VIDEO_PATH: String = "filePath"
    private static var PARAM_NAME_BACKGROUND_PATH: String = "backgroundPath"
    private static var PARAM_NAME_CONTENT_URL: String = "contentUrl"
    private static var PARAM_NAME_TEXT_MESSAGE: String = "textMessage"


    static func threatType(type: String, content: Dictionary<String, Any?>, result: @escaping FlutterResult) {
        switch (type) {
        case "story":
            break
        case "post":
            break
        case "direct":
            break
        case "directText":
            shareDirectText(content: content, result: result)
            break
        default:
            result(FlutterError(code: "invalid_type", message: "\(type) is not a valid InstagramPlatform type", details: nil))
            break
        }
    }


    private static func shareDirectText(content: Dictionary<String, Any?>, result: @escaping FlutterResult) {
        guard let textMessage = content[PARAM_NAME_TEXT_MESSAGE] as? String else {
            result(FlutterError(code: "missing_text", message: "Missing text parameter to send", details: nil))
            return
        }

        DispatchQueue.main.async {
            let shareUrl = "instagram://sharesheet?text=" + (textMessage.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")

            guard let url = URL(string: shareUrl) else {
                result(false)
                return
            }

            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            } else {
                result(false)
            }
        }

    }

}