package dev.kaique.social_share_kit.platforms.messenger

import android.app.Activity
import android.content.Context
import android.content.Intent
import io.flutter.plugin.common.MethodChannel


object MessengerPlatform {

    private const val PARAM_NAME_LINK: String = "link"
    private const val PACKAGE_NAME: String = "com.facebook.orca"

    fun threatType(
            type: String,
            content: HashMap<*, *>,
            context: Context,
            activity: Activity,
            result: MethodChannel.Result,
    ) = try {
        when (type) {
            "link" -> shareLink(content, context, activity, result)
            else -> throw Exception("$type is not a valid MessengerPlatform type")
        }

    } catch (e: Exception) {
        result.error(
                e.cause.toString(),
                e.message,
                null,
        )
    }

    private fun shareLink(
            content: HashMap<*, *>,
            context: Context,
            activity: Activity,
            result: MethodChannel.Result
    ) {

        try {
            val link = content[PARAM_NAME_LINK] as String?

            val intent = Intent(Intent.ACTION_SEND).apply {
                type = "text/plain"
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                putExtra(Intent.EXTRA_TEXT, link)
                setPackage(PACKAGE_NAME)
            }

            if (activity.packageManager.resolveActivity(intent, 0) != null) {
                context.startActivity(intent)
                result.success(true)
            } else {
                result.success(true)
            }

        } catch (e: Exception) {
            result.error(
                    e.cause.toString(),
                    e.message,
                    null,
            )
        }
    }
}