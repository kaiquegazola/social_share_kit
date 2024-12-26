import Foundation
import Photos
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
            shareDirect(content: content, result: result)
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
    
    
    private static func determineFileType(from filePath: String) -> PHAssetMediaType {
        let fileExtension = (filePath as NSString).pathExtension.lowercased()

        switch fileExtension {
        case "jpg", "jpeg", "png", "heic", "gif":
            return .image
        case "mp4", "mov", "m4v", "avi":
            return .video
        default:
            return .unknown
        }
    }
    
    private static func createAssetURL(url: URL, fileType: PHAssetMediaType, result: @escaping FlutterResult, completion: @escaping (PHAsset) -> Void) {
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {
                result(FlutterError(code: "permission_denied", message: "Photos permission is required", details: nil))
                return
            }

            var assetPlaceholder: PHObjectPlaceholder?

            PHPhotoLibrary.shared().performChanges({
                if fileType == .image {
                    let request = PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
                    assetPlaceholder = request?.placeholderForCreatedAsset
                } else if fileType == .video {
                    let request = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
                    assetPlaceholder = request?.placeholderForCreatedAsset
                }
            }) { success, error in
                if success, let localID = assetPlaceholder?.localIdentifier {
                    let assets = PHAsset.fetchAssets(withLocalIdentifiers: [localID], options: nil)
                    if let asset = assets.firstObject {
                        completion(asset)
                    } else {
                        result(FlutterError(code: "asset_not_found", message: "Failed to fetch created asset", details: nil))
                    }
                } else {
                    result(FlutterError(code: "creation_failed", message: error?.localizedDescription ?? "Failed to create asset", details: nil))
                }
            }
        }
    }
    private static func shareDirect(content: [String: Any?], result: @escaping FlutterResult) {
        guard let filePath = content[PARAM_NAME_FILE_PATH] as? String else {
            result(FlutterError(code: "missing_file", message: "File path is missing", details: nil))
            return
        }

        // 动态判断文件类型
        let fileType = determineFileType(from: filePath)
        guard fileType != .unknown else {
            result(FlutterError(code: "unsupported_file", message: "Unsupported file type", details: nil))
            return
        }

        let fileURL = URL(fileURLWithPath: filePath)

        if UIApplication.shared.canOpenURL(URL(string: "instagram://app")!) {
            createAssetURL(url: fileURL, fileType: fileType, result: result) { asset in
                let localIdentifier = asset.localIdentifier
                let shareURLString = "instagram://library?LocalIdentifier=\(localIdentifier)"
                guard let shareURL = URL(string: shareURLString) else {
                    result(FlutterError(code: "invalid_url", message: "Failed to construct Instagram share URL", details: nil))
                    return
                }

                UIApplication.shared.open(shareURL, options: [:]) { success in
                    success ? result(true) : result(FlutterError(code: "open_failed", message: "Failed to open Instagram", details: nil))
                }
            }
        } else {
            let appStoreURL = URL(string: "itms-apps://itunes.apple.com/us/app/apple-store/id389801252")!
            UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
            result(FlutterError(code: "instagram_not_installed", message: "Instagram app is not installed", details: nil))
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
