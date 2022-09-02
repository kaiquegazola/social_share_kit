import Foundation

class MessengerPlatform {
    private static var PARAM_NAME_LINK: String = "link"

    static func threatType(type: String, content: Dictionary<String, Any?>, result: @escaping FlutterResult) {
        switch (type) {
        case "link":
            shareLink(content: content, result: result)
            break
        default:
            result(FlutterError(code: "invalid_type", message: "\(type) is not a valid MessengerPlatform type", details: nil))
            break
        }
    }

    private static func shareLink(content: Dictionary<String, Any?>, result: @escaping FlutterResult) {
        guard let link = content[PARAM_NAME_LINK] as? String else {
            result(FlutterError(code: "missing_link", message: "Missing link parameter to send", details: nil))
            return
        }


        DispatchQueue.main.async(execute: {
            let shareUrl = "fb-messenger://share?link=" + (link.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")

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


