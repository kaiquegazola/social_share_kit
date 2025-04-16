import Foundation
import UIKit
import Flutter

class WhatsAppPlatform {
    static func threatType(type: String, content: Dictionary<String, Any?>, result: @escaping FlutterResult) {
        switch type {
        case "text":
            if let text = content["text"] as? String {
                let success = shareText(text: text)
                result(success)
            } else {
                result(false)
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private static func shareText(text: String) -> Bool {
        let whatsappURL = URL(string: "whatsapp://send?text=\(text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")
        
        if let url = whatsappURL, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return true
        }
        return false
    }
} 