import Foundation
import Photos

class FileUtils {

    static func createAssetURL(url: URL, result: @escaping FlutterResult, fileType: PHAssetMediaType, completion: @escaping (PHAsset) -> Void) {
        var localIdentifier = "";

        switch fileType {
        case PHAssetMediaType.image:
            do {
                try PHPhotoLibrary.shared().performChangesAndWait {
                    let imgReq = PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
                    localIdentifier = imgReq?.placeholderForCreatedAsset?.localIdentifier ?? ""
                }
            } catch {
                result(FlutterError.init(code: "createAssetURL", message: error.localizedDescription, details: nil))
            }
            break
        case PHAssetMediaType.video:
            do {
                try PHPhotoLibrary.shared().performChangesAndWait {
                    let videoReq = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
                    localIdentifier = videoReq?.placeholderForCreatedAsset?.localIdentifier ?? ""
                }
            } catch {
                result(FlutterError.init(code: "createAssetURL", message: error.localizedDescription, details: nil))
            }
            break
        default:
            return
        }

        if (!localIdentifier.isEmpty) {
            guard let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: [localIdentifier], options: nil).firstObject else {
                return
            }
            completion(fetchResult)
        } else {
            result(false)
        }
    }

    static func deleteTempAsset(assetToDelete: PHAsset) {
        //This will ask permission/prompt user before delete
        /*
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.deleteAssets([assetToDelete] as NSFastEnumeration)
        })
         */
    }


}