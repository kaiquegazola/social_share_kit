import Foundation

class TwitterPlatform {
    private static var PARAM_NAME_TWEET_TEXT: String = "tweetText"

    static func threatType(type: String, content: Dictionary<String, Any?>, result: @escaping FlutterResult) {
        switch (type) {
        case "text":
            shareTweetText(content: content, result: result)
            break
        default:
            result(FlutterError(code: "invalid_type", message: "\(type) is not a valid TwitterPlatform type", details: nil))
            break
        }
    }

    private static func shareTweetText(content: Dictionary<String, Any?>, result: @escaping FlutterResult) {
        guard let textMessage = content[PARAM_NAME_TWEET_TEXT] as? String else {
            result(FlutterError(code: "missing_text", message: "Missing text parameter to send", details: nil))
            return
        }

        DispatchQueue.main.async(execute: {
            let shareUrl = "twitter://post?text=" + (textMessage.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")

            guard let url = URL(string: shareUrl) else {
                result(false)
                return
            }

            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                result(false)
            }
        })

    }

}
