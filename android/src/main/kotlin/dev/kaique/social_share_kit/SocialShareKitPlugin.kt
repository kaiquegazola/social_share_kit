package dev.kaique.social_share_kit

import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import dev.kaique.social_share_kit.enums.PlatformEnum
import dev.kaique.social_share_kit.platforms.instagram.InstagramPlatform
import dev.kaique.social_share_kit.platforms.telegram.TelegramPlatform
import dev.kaique.social_share_kit.platforms.tiktok.TiktokPlatform
import dev.kaique.social_share_kit.services.PackageService
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** SocialShareKitPlugin */
class SocialShareKitPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var activity: Activity

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "social_share_kit")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "share" -> {
                val map = call.arguments as HashMap<*, *>
                val platform: String = map["platform"] as String
                val type: String = map["type"] as String
                val content = map["content"] as HashMap<*, *>
                when (platform) {
                    "telegram" -> {
                        TelegramPlatform.threatType(type, content, context, activity, result)
                    }
                    "instagram" -> {
                        InstagramPlatform.threatType(type, content, context, activity, result)
                    }
                    "tiktok" -> {
                        TiktokPlatform.threatType(type, content, context, activity, result)
                    }
                }
            }
            "getAvailableApps" -> {
                getAvailableApps(context, result)
            }
            "getMd5Signature" -> {
                getMd5Signature(context, result)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun getAvailableApps(context: Context, result: Result) {
        try {
            val apps: MutableMap<String, Boolean> = HashMap()
            val pm: PackageManager = context.packageManager
            val packages = pm.getInstalledApplications(PackageManager.GET_META_DATA)
            PlatformEnum.values().forEach { platform ->
                apps[platform.name] = packages.any {
                    it.packageName.toString().contentEquals(platform.packageName)
                }
            }
            result.success(apps)
        } catch (e: Exception) {
            result.error(
                e.cause.toString(),
                e.message,
                null,
            )
        }
    }


    private fun getMd5Signature(context: Context, result: Result) {
        try {
            val signature = PackageService.getAppSignatureMD5(context)
            result.success(signature)
        } catch (e: Exception) {
            result.error(
                e.cause.toString(),
                e.message,
                null,
            )
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivity() {}
}
