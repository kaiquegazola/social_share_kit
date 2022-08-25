package dev.kaique.social_share_kit.platforms.instagram

import android.app.Activity
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.net.Uri
import dev.kaique.social_share_kit.services.FileService
import io.flutter.plugin.common.MethodChannel


object InstagramPlatform {

    private const val PARAM_NAME_FILE_PATH: String = "filePath"
    private const val PARAM_NAME_BACKGROUND_PATH: String = "backgroundPath"
    private const val PARAM_NAME_CONTENT_URL: String = "contentUrl"
    private const val PARAM_NAME_TEXT_MESSAGE: String = "textMessage"
    private const val PACKAGE_NAME: String = "com.instagram.android"

    fun threatType(
        type: String,
        content: HashMap<*, *>,
        context: Context,
        activity: Activity,
        result: MethodChannel.Result,
    ) = try {
        when (type) {
            "story" -> shareStory(content, context, activity, result)
            "post" -> sharePost(content, context, activity, result)
            "direct" -> shareDirect(content, context, activity, result)
            "directText" -> shareDirectText(content, context, activity, result)
            else -> throw Exception("$type is not a valid TelegramPlatform type")
        }

    } catch (e: Exception) {
        result.error(
            e.cause.toString(),
            e.message,
            null,
        )
    }

    private fun shareStory(
        content: HashMap<*, *>,
        context: Context,
        activity: Activity,
        result: MethodChannel.Result
    ) {

        try {
            val filePath: String = content[PARAM_NAME_FILE_PATH] as String
            val backgroundPath: String = content[PARAM_NAME_BACKGROUND_PATH] as String
            val contentUrl: String = content[PARAM_NAME_CONTENT_URL] as String

            val fileUri = FileService.exportUriForFile(context, filePath)
            FileService.grantUriPermission(activity, PACKAGE_NAME, fileUri)

            var backgroundUri: Uri? = null
            if (backgroundPath.isNotEmpty()) {
                backgroundUri = FileService.exportUriForFile(context, backgroundPath)
                FileService.grantUriPermission(activity, PACKAGE_NAME, backgroundUri)
            }

            val intent = Intent("com.instagram.share.ADD_TO_STORY")
            intent.type = FileService.getMimeType(context, fileUri)
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            intent.putExtra("source_application", context.packageName)
            intent.putExtra("interactive_asset_uri", fileUri)
            intent.putExtra("content_url", contentUrl)
            if (backgroundUri != null) {
                intent.setDataAndType(
                    backgroundUri,
                    FileService.getMimeType(context, backgroundUri)
                )
            }
            if (activity.packageManager.resolveActivity(intent, 0) != null) {
                context.startActivity(intent)
                result.success(true)
            } else {
                result.success(false)
            }

        } catch (e: Exception) {
            result.error(
                e.cause.toString(),
                e.message,
                null,
            )
        }
    }

    private fun sharePost(
        content: HashMap<*, *>,
        context: Context,
        activity: Activity,
        result: MethodChannel.Result
    ) {

        try {
            val filePath: String = content[PARAM_NAME_FILE_PATH] as String
            val backgroundPath: String = content[PARAM_NAME_BACKGROUND_PATH] as String
            val contentUrl: String = content[PARAM_NAME_CONTENT_URL] as String

            val fileUri = FileService.exportUriForFile(context, filePath)
            FileService.grantUriPermission(activity, PACKAGE_NAME, fileUri)

            var backgroundUri: Uri? = null
            if (backgroundPath.isNotEmpty()) {
                backgroundUri = FileService.exportUriForFile(context, backgroundPath)
                FileService.grantUriPermission(activity, PACKAGE_NAME, backgroundUri)
            }

            val intent = Intent("com.instagram.share.ADD_TO_FEED")
            intent.type = FileService.getMimeType(context, fileUri)
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            intent.putExtra("interactive_asset_uri", fileUri)
            intent.putExtra("content_url", contentUrl)
            if (backgroundUri != null) {
                intent.setDataAndType(
                    backgroundUri,
                    FileService.getMimeType(context, backgroundUri)
                )
            }
            if (activity.packageManager.resolveActivity(intent, 0) != null) {
                context.startActivity(intent)
                result.success(true)
            } else {
                result.success(false)
            }

        } catch (e: Exception) {
            result.error(
                e.cause.toString(),
                e.message,
                null,
            )
        }
    }

    private fun shareDirect(
        content: HashMap<*, *>,
        context: Context,
        activity: Activity,
        result: MethodChannel.Result
    ) {

        try {
            val filePath = content[PARAM_NAME_FILE_PATH] as String?
            val backgroundPath = content[PARAM_NAME_BACKGROUND_PATH] as String?
            val contentUrl = content[PARAM_NAME_CONTENT_URL] as String?


            var fileUri: Uri? = null
            if (filePath != null) {
                fileUri = FileService.exportUriForFile(context, filePath)
                FileService.grantUriPermission(activity, PACKAGE_NAME, fileUri)
            }

            var backgroundUri: Uri? = null
            if (backgroundPath != null) {
                backgroundUri = FileService.exportUriForFile(context, backgroundPath)
                FileService.grantUriPermission(activity, PACKAGE_NAME, backgroundUri)
            }

            val intent = Intent(Intent.ACTION_SEND)
            intent.type = fileUri?.let { FileService.getMimeType(context, it) }
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            intent.putExtra(Intent.EXTRA_STREAM, fileUri)
            intent.putExtra("content_url", contentUrl)
            intent.putExtra("source_application", context.packageName)
            intent.putExtra(Intent.EXTRA_TITLE, contentUrl)
            intent.setPackage("com.instagram.android")

            if (backgroundUri != null) {
                intent.setDataAndType(
                    backgroundUri,
                    FileService.getMimeType(context, backgroundUri)
                )
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

    private fun shareDirectText(
        content: HashMap<*, *>,
        context: Context,
        activity: Activity,
        result: MethodChannel.Result
    ) {

        try {
            val textMessage = content[PARAM_NAME_TEXT_MESSAGE] as String?

            val intent = Intent(Intent.ACTION_SEND)
            intent.type = "text/plain"
            intent.putExtra(Intent.EXTRA_TEXT, textMessage)
            intent.component = ComponentName(
                "com.instagram.android",
                "com.instagram.direct.share.handler.DirectShareHandlerActivity",
            )

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