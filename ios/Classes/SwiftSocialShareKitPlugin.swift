import Flutter
import UIKit
import TikTokOpenSDK

public class SwiftSocialShareKitPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
                name: "social_share_kit", binaryMessenger: registrar.messenger()
        )
        let instance = SwiftSocialShareKitPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "share":
            guard let args = call.arguments as? [String: Any?] else {
                return
            }
            guard let platform = args["platform"] as? String else {
                return
            }
            guard let type = args["type"] as? String else {
                return
            }
            guard let content = args["content"] as? Dictionary<String, Any?> else {
                return
            }
            switch (platform) {
            case "tiktok":
                TikTokPlatform.threatType(type: type, content: content, result: result)
                break
            default:
                result(FlutterError(code: "platformNotImplemented", message: "Platform \(platform) is not implemented.", details: nil))
            }
            break
        case "getAvailableApps":
            getAvailableApps(result: result)
            break
        default:
            result(FlutterMethodNotImplemented)
        }
    }


    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable: Any] = [:]) -> Bool {
        TikTokOpenSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }


    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {

        guard let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
              let annotation = options[UIApplication.OpenURLOptionsKey.annotation]
        else {
            return false
        }

        if TikTokOpenSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: sourceApplication, annotation: annotation) {
            return true
        }
        return false
    }

    public func application(_ application: UIApplication, open url: URL, sourceApplication: String, annotation: Any) -> Bool {
        if TikTokOpenSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation) {
            return true
        }
        return false
    }

    public func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        if TikTokOpenSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: nil, annotation: "") {
            return true
        }
        return false
    }


    private func getAvailableApps(result: @escaping FlutterResult) -> Void {
        var availableAppsDict: Dictionary<String, Bool> = [:]

        availableAppsDict["tiktok"] = TikTokOpenSDKApplicationDelegate.sharedInstance().isAppInstalled()

        for platform in PlatformEnum.values {
            guard let url = URL(string: platform.rawValue) else {
                result(FlutterError(code: "getAvailableApps", message: "cannot create url to \(platform.rawValue)", details: nil))
                return
            }
            availableAppsDict["\(platform)"] = UIApplication.shared.canOpenURL(url)
        }

        result(availableAppsDict)
    }

}

