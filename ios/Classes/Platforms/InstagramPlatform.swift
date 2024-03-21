import Foundation

class InstagramPlatform {
    private static var PARAM_NAME_FILE_PATH: String = "filePath"
    private static var PARAM_NAME_BACKGROUND_PATH: String = "backgroundPath"
    private static var PARAM_NAME_TOP_BACKGROUND_COLOR: String = "topBackgroundColor"
    private static var PARAM_NAME_BOTTOM_BACKGROUND_COLOR: String = "bottomBackgroundColor"
    private static var PARAM_NAME_CONTENT_URL: String = "contentUrl"
    private static var PARAM_NAME_TEXT_MESSAGE: String = "textMessage"

    static func threatType(type: String, content: [String: Any?], result: @escaping FlutterResult) {
        switch type {
        case "storyImage":
            shareStoryImage(content: content, result: result)
        case "storyVideo":
            shareStoryVideo(content: content, result: result)
        case "post":
            break
        case "direct":
            break
        case "directText":
            shareDirectText(content: content, result: result)
        default:
            result(FlutterError(code: "invalid_type", message: "\(type) is not a valid InstagramPlatform type", details: nil))
        }
    }

    private static func shareStoryImage(content: [String: Any?], result: @escaping FlutterResult) {
        guard let imagePath = content[PARAM_NAME_FILE_PATH] as? String else {
            result(FlutterError(code: "missing_image", message: "Missing image path parameter", details: nil))
            return
        }

        guard let image = UIImage(contentsOfFile: imagePath)?.pngData() else {
            result(FlutterError(code: "invalid_image", message: "Could not convert image to PNG data", details: nil))
            return
        }

        let backgroundPath = content[PARAM_NAME_BACKGROUND_PATH] as? String
        var backgroundImageData: Data?
        if let backgroundPath = backgroundPath, let backgroundImage = UIImage(contentsOfFile: backgroundPath)?.pngData() {
            backgroundImageData = backgroundImage
        }

        let topBackgroundColor = content[PARAM_NAME_TOP_BACKGROUND_COLOR] as? String
        let bottomBackgroundColor = content[PARAM_NAME_BOTTOM_BACKGROUND_COLOR] as? String
        let contentUrl = content[PARAM_NAME_CONTENT_URL] as? String
        let appID = Bundle.main.object(forInfoDictionaryKey: "FacebookAppID") as? String

        DispatchQueue.main.async {
            guard let appID = appID, let urlScheme = URL(string: "instagram-stories://share?source_application=\(appID)") else {
                result(false)
                return
            }

            var items: [[String: Any]] = [["com.instagram.sharedSticker.stickerImage": image]]
            if let backgroundImageData = backgroundImageData {
                items.append(["com.instagram.sharedSticker.backgroundImage": backgroundImageData])
            }
            if let topBackgroundColor = topBackgroundColor, let bottomBackgroundColor = bottomBackgroundColor {
                items.append(["com.instagram.sharedSticker.backgroundTopColor": topBackgroundColor, "com.instagram.sharedSticker.backgroundBottomColor": bottomBackgroundColor])
            }
            if let contentUrl = contentUrl {
                items.append(["com.instagram.sharedSticker.contentURL": contentUrl])
            }

            if UIApplication.shared.canOpenURL(urlScheme) {
                UIPasteboard.general.setItems(items)
                UIApplication.shared.open(urlScheme)
                result(true)
            } else {
                result(false)
            }
        }
    }

    private static func shareStoryVideo(content: [String: Any?], result: @escaping FlutterResult) {
        guard let videoPath = content[PARAM_NAME_FILE_PATH] as? String else {
            result(FlutterError(code: "missing_video", message: "Missing video path parameter", details: nil))
            return
        }

        guard let appID = Bundle.main.object(forInfoDictionaryKey: "FacebookAppID") as? String else {
            result(FlutterError(code: "missing_fb_app_id", message: "Missing FacebookAppID in Info.plist", details: nil))
            return
        }

        let videoURL = URL(fileURLWithPath: videoPath)
        var videoData: Data?

        do {
            try videoData = Data(contentsOf: videoURL)
        } catch {
            result(FlutterError(code: "error_accessing_video", message: error.localizedDescription, details: nil))
        }

        let contentUrl = content[PARAM_NAME_CONTENT_URL] as? String

        DispatchQueue.main.async {
            let shareScheme = "instagram-stories://share"

            guard let url = URL(string: shareScheme) else {
                result(false)
                return
            }

            var items: [[String: Any]] = []
            if videoData != nil {
                items.append(["com.instagram.sharedSticker.backgroundVideo": videoData!])
            }
            if contentUrl != nil {
                items.append(["com.instagram.sharedSticker.contentURL": contentUrl!])
            }
            items.append(["com.instagram.sharedSticker.appID": appID])

            if UIApplication.shared.canOpenURL(url) {
                UIPasteboard.general.setItems(items)
                UIApplication.shared.open(url)
            } else {
                result(false)
            }
        }
    }

    private static func shareDirectText(content: [String: Any?], result: @escaping FlutterResult) {
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
                UIApplication.shared.open(url)
            } else {
                result(false)
            }
        }
    }
}
