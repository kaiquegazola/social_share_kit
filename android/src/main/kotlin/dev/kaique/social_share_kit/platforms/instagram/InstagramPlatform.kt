package dev.kaique.social_share_kit.platforms.instagram

import android.app.Activity
import android.content.Context
import android.content.Intent
import dev.kaique.social_share_kit.services.FileService
import io.flutter.plugin.common.MethodChannel

object InstagramPlatform {

    private const val PARAM_NAME_PHOTO_PATH: String = "photoPath"
    private const val PARAM_NAME_BACKGROUND_PATH: String = "backgroundPath"
    private const val PACKAGE_NAME: String = "com.instagram.android"

    fun shareStoryPhoto(
        arguments: Any,
        context: Context,
        activity: Activity,
        result: MethodChannel.Result
    ) {

        try {
            val map = arguments as HashMap<*, *>
            val photoPath: String = map[InstagramPlatform.PARAM_NAME_PHOTO_PATH] as String
            val backgroundPath: String = map[InstagramPlatform.PARAM_NAME_BACKGROUND_PATH] as String

            val photoUri = FileService.exportUriForFile(context, photoPath)
            FileService.grantUriPermission(activity, PACKAGE_NAME, photoUri)

            val intent = Intent("com.instagram.share.ADD_TO_STORY")
            intent.type = "image/*"
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            intent.putExtra("interactive_asset_uri", photoUri)
            intent.putExtra("content_url", "https://qconcursos.com.br")
            activity.grantUriPermission(
                "com.instagram.android",
                photoUri,
                Intent.FLAG_GRANT_READ_URI_PERMISSION
            )
            if (activity.packageManager.resolveActivity(intent, 0) != null) {
                context.startActivity(intent)
                result.success("success")
            } else {
                result.success("error")
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