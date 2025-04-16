package dev.kaique.social_share_kit.platforms

import android.app.Activity
import android.content.Context
import android.content.Intent
import io.flutter.plugin.common.MethodChannel.Result

class WhatsAppPlatform(private val context: Context, private val activity: Activity) {
    companion object {
        fun threatType(
            type: String,
            content: HashMap<*, *>,
            context: Context,
            activity: Activity,
            result: Result
        ) {
            when (type) {
                "text" -> {
                    val text = content["text"] as String
                    val success = WhatsAppPlatform(context, activity).shareText(text, result)
                    result.success(success)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun shareText(text: String, result: Result): Boolean {
        try {
            val intent = Intent(Intent.ACTION_SEND)
            intent.type = "text/plain"
            intent.setPackage("com.whatsapp")
            intent.putExtra(Intent.EXTRA_TEXT, text)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            
            if (activity.packageManager.resolveActivity(intent, 0) != null) {
                context.startActivity(intent)
                result.success(true)
                return true
            } else {
                result.success(false)
                return false
            }
        } catch (e: Exception) {
            return false
        }
    }
} 