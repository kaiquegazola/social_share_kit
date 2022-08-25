import Foundation
import TikTokOpenSDK
import Photos
import UIKit


class TikTokPlatform {
    private static var PARAM_NAME_VIDEO_PATH: String = "videoPath"
    private static var PARAM_NAME_IMAGE_PATH: String = "imagePath"
    private var assetToDelete: PHAsset?

    static func threatType(type: String, content: Dictionary<String, Any?>, result: @escaping FlutterResult) {
        switch (type) {
        case "image":
            shareImage(content: content, result: result, greenScreen: false)
            break
        case "video":
            shareVideo(content: content, result: result, greenScreen: false)
            break
        case "greenScreenVideo":
            shareVideo(content: content, result: result, greenScreen: true)
            break
        case "greenScreenImage":
            shareImage(content: content, result: result, greenScreen: true)
            break
        default:
            result(FlutterError(code: "invalid_type", message: "\(type) is not a valid TikTokPlatform type", details: nil))
            break
        }
    }

    private static func shareVideo(content: Dictionary<String, Any?>, result: @escaping FlutterResult, greenScreen: Bool) {
        guard let videoPath = content[PARAM_NAME_VIDEO_PATH] as? String else {
            return
        }

        let fileURL = URL(fileURLWithPath: videoPath)

        FileUtils.createAssetURL(url: fileURL, result: result, fileType: PHAssetMediaType.video) { asset in

            let request = TikTokOpenSDKShareRequest()
            let localIdentifier = asset.localIdentifier
            let mediaLocalIdentifiers: [String] = [localIdentifier]

            request.mediaType = TikTokOpenSDKShareMediaType.video
            request.localIdentifiers = mediaLocalIdentifiers
            request.shareFormat = greenScreen ? TikTokOpenSDKShareFormatType.greenScreen : TikTokOpenSDKShareFormatType.normal

            let isSuccess = request.send(completionBlock: { resp -> Void in
                FileUtils.deleteTempAsset(assetToDelete: asset)
                result(resp.isSucceed)
            })

            if (isSuccess) {
                FileUtils.deleteTempAsset(assetToDelete: asset)
                result(true)
            } else {
                result(false)
            }
        }
    }


    private static func shareImage(content: Dictionary<String, Any?>, result: @escaping FlutterResult, greenScreen: Bool) {
        guard let imagePath = content[PARAM_NAME_IMAGE_PATH] as? String else {
            return
        }

        let fileURL = URL(fileURLWithPath: imagePath)

        FileUtils.createAssetURL(url: fileURL, result: result, fileType: PHAssetMediaType.image) { asset in

            let request = TikTokOpenSDKShareRequest()
            let localIdentifier = asset.localIdentifier
            let mediaLocalIdentifiers: [String] = [localIdentifier]

            request.mediaType = TikTokOpenSDKShareMediaType.image
            request.localIdentifiers = mediaLocalIdentifiers
            request.shareFormat = greenScreen ? TikTokOpenSDKShareFormatType.greenScreen : TikTokOpenSDKShareFormatType.normal

            let isSuccess = request.send(completionBlock: { resp -> Void in
                FileUtils.deleteTempAsset(assetToDelete: asset)
                result(resp.isSucceed)
            })

            if (isSuccess) {
                FileUtils.deleteTempAsset(assetToDelete: asset)
                result(true)
            } else {
                result(false)
            }
        }
    }
}


