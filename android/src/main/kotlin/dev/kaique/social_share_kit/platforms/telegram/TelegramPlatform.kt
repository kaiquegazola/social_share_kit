package dev.kaique.social_share_kit.platforms.telegram

import android.app.Activity
import android.content.Context
import android.content.Intent
import dev.kaique.social_share_kit.services.FileService
import dev.kaique.social_share_kit.services.PackageService
import io.flutter.plugin.common.MethodChannel

object TelegramPlatform {
    private const val PARAM_NAME_FILE_PATH: String = "filePath"
    private const val PARAM_NAME_TEXT_MESSAGE: String = "textMessage"
    private const val PACKAGE_NAME: String = "org.telegram.messenger"

    fun threatType(
            type: String,
            content: HashMap<*, *>,
            context: Context,
            activity: Activity,
            result: MethodChannel.Result,
    ) {
        try {
            when (type) {
                "file" -> {
                    shareFile(content, context, activity, result)
                }
                "text" -> {
                    shareText(content, context, result)
                }
                else -> {
                    throw Exception("$type is not a valid TelegramPlatform type")
                }
            }

        } catch (e: Exception) {
            result.error(
                    e.cause.toString(),
                    e.message,
                    null,
            )
        }
    }

    private fun shareFile(
            content: HashMap<*, *>,
            context: Context,
            activity: Activity,
            result: MethodChannel.Result,
    ) {
        try {
            PackageService.verifyIfPackageIsInstalled(context, PACKAGE_NAME)

            val filePath: String = content[PARAM_NAME_FILE_PATH] as String
            val fileUri = FileService.exportUriForFile(context, filePath)

            FileService.grantUriPermission(activity, PACKAGE_NAME, fileUri)

            val intent = Intent(Intent.ACTION_SEND)
            intent.type = FileService.getMimeType(context, fileUri)
            intent.putExtra(Intent.EXTRA_STREAM, fileUri)
            intent.flags = Intent.FLAG_GRANT_READ_URI_PERMISSION
            intent.setPackage(PACKAGE_NAME)

            if (context.packageManager.resolveActivity(intent, 0) != null) {
                context.startActivity(intent, null)
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

    private fun shareText(
            content: HashMap<*, *>,
            context: Context,
            result: MethodChannel.Result,
    ) {
        try {
            PackageService.verifyIfPackageIsInstalled(context, PACKAGE_NAME)

            val message: String = content[PARAM_NAME_TEXT_MESSAGE] as String

            val intent = Intent(Intent.ACTION_SEND)
            intent.putExtra(
                    Intent.EXTRA_TEXT,
                    message,
            )
            intent.type = "text/plain"
            intent.setPackage(PACKAGE_NAME)

            if (context.packageManager.resolveActivity(intent, 0) != null) {
                context.startActivity(intent, null)
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
}