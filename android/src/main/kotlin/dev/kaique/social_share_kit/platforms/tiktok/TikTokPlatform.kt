package dev.kaique.social_share_kit.platforms.tiktok

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import com.bytedance.sdk.open.tiktok.TikTokOpenApiFactory
import com.bytedance.sdk.open.tiktok.TikTokOpenConfig
import com.bytedance.sdk.open.tiktok.api.TikTokOpenApi
import com.bytedance.sdk.open.tiktok.share.Share
import com.bytedance.sdk.open.tiktok.share.ShareRequest
import dev.kaique.social_share_kit.services.FileService
import dev.kaique.social_share_kit.services.PackageService
import io.flutter.plugin.common.MethodChannel


object TikTokPlatform {
    private const val PARAM_NAME_FILE_PATH: String = "filePath"

    fun threatType(
            type: String,
            content: HashMap<*, *>,
            context: Context,
            activity: Activity,
            result: MethodChannel.Result,
    ) = try {
        when (type) {
            "video" -> {
                shareToTikTok(
                        content, context, activity, result,
                        isVideo = true,
                        isGreenScreen = false
                )
            }
            "greenScreenVideo" -> {
                shareToTikTok(
                        content, context, activity, result,
                        isVideo = true,
                        isGreenScreen = true
                )
            }
            "image" -> shareToTikTok(
                    content, context, activity, result,
                    isVideo = false,
                    isGreenScreen = false
            )
            "greenScreenImage" -> shareToTikTok(
                    content, context, activity, result,
                    isVideo = false,
                    isGreenScreen = true
            )
            else -> throw Exception("$type is not a valid TikTokPlatform type")
        }

    } catch (e: Exception) {
        result.error(
                e.cause.toString(),
                e.message,
                null,
        )
    }

    private fun shareToTikTok(
            arguments: Any,
            context: Context,
            activity: Activity,
            result: MethodChannel.Result,
            isVideo: Boolean,
            isGreenScreen: Boolean,
    ) {
        try {
            val map = arguments as HashMap<*, *>
            val filePath: String = map[PARAM_NAME_FILE_PATH] as String

            val fileUri = FileService.exportUriForFile(context, filePath)

            giveTikTokUriPermissions(activity, fileUri)

            val tiktokApiId = PackageService.getBundleMetaData(context, "TikTokAppID")
            val tiktokOpenConfig = TikTokOpenConfig(tiktokApiId)
            TikTokOpenApiFactory.init(tiktokOpenConfig)

            val mUri = ArrayList<String>()
            mUri.add(fileUri.toString())

            val shareRequestBuilder = ShareRequest.builder()
                    .mediaPaths(mUri)

            if (isVideo) {
                shareRequestBuilder.mediaType(ShareRequest.MediaType.VIDEO)
            } else {
                shareRequestBuilder.mediaType(ShareRequest.MediaType.IMAGE)
            }

            if (isGreenScreen) {
                shareRequestBuilder.shareFormat(Share.Format.GREEN_SCREEN)
            } else {
                shareRequestBuilder.shareFormat(Share.Format.DEFAULT)
            }


            val shareRequest = shareRequestBuilder.build()
            val tiktokOpenApi: TikTokOpenApi = TikTokOpenApiFactory.create(activity)
            val shareResult = tiktokOpenApi.share(shareRequest)

            if (shareResult) {
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

    private fun giveTikTokUriPermissions(activity: Activity, fileUri: Uri) {
        val packages = listOf(
                "com.zhiliaoapp.musically",
                "com.ss.android.ugc.trill",
        )
        for (pkg in packages) {
            activity.grantUriPermission(
                    "com.zhiliaoapp.musically",
                    fileUri, Intent.FLAG_GRANT_READ_URI_PERMISSION,
            )
        }
    }
}