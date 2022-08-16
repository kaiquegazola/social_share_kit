package dev.kaique.social_share_kit.platforms.tiktok

import android.app.Activity
import android.content.Context
import android.content.Intent
import androidx.core.content.FileProvider
import com.bytedance.sdk.open.tiktok.TikTokOpenApiFactory
import com.bytedance.sdk.open.tiktok.TikTokOpenConfig
import com.bytedance.sdk.open.tiktok.api.TikTokOpenApi
import com.bytedance.sdk.open.tiktok.base.ImageObject
import com.bytedance.sdk.open.tiktok.base.MediaContent
import com.bytedance.sdk.open.tiktok.share.Share
import com.bytedance.sdk.open.tiktok.share.ShareRequest
import dev.kaique.social_share_kit.platforms.instagram.InstagramPlatform
import dev.kaique.social_share_kit.services.FileService
import dev.kaique.social_share_kit.services.PackageService
import io.flutter.plugin.common.MethodChannel
import java.io.File

object TiktokPlatform {


    private const val PARAM_NAME_VIDEO_PATH: String = "videoPath"


    fun threatType(
        type: String,
        content: HashMap<*, *>,
        context: Context,
        activity: Activity,
        result: MethodChannel.Result,
    ) = try {
        when (type) {
//            "video" -> shareVideo(content, context, activity, result)
            "greenScreenVideo" -> shareGreenScreenVideo(content, context, activity, result)
//            "photo" -> sharePhoto(content, context, activity, result)
//            "greenScreenPhoto" -> shareGreenScreenPhoto(content, context, activity, result)
            else -> throw Exception("$type is not a valid TelegramPlatform type")
        }

    } catch (e: Exception) {
        result.error(
            e.cause.toString(),
            e.message,
            null,
        )
    }

    private fun shareGreenScreenVideo(
        arguments: Any,
        context: Context,
        activity: Activity,
        result: MethodChannel.Result
    ) {
        try {
            val map = arguments as HashMap<*, *>
            val videoPath: String = map[PARAM_NAME_VIDEO_PATH] as String

            val videoUri = FileService.exportUriForFile(context, videoPath)

            context.grantUriPermission(
                "com.zhiliaoapp.musically",
                videoUri, Intent.FLAG_GRANT_READ_URI_PERMISSION,
            )
            context.grantUriPermission(
                "com.ss.android.ugc.trill",
                videoUri, Intent.FLAG_GRANT_READ_URI_PERMISSION,
            )
            activity.grantUriPermission(
                "com.zhiliaoapp.musically",
                videoUri, Intent.FLAG_GRANT_READ_URI_PERMISSION,
            )
            activity.grantUriPermission(
                "com.ss.android.ugc.trill",
                videoUri, Intent.FLAG_GRANT_READ_URI_PERMISSION,
            )
            activity.grantUriPermission(
                "com.zhiliaoapp.musically",
                videoUri,
                Intent.FLAG_GRANT_READ_URI_PERMISSION,
            )

            val tiktokApiId = PackageService.getBundleMetaData(context, "TikTokAppID")
            val tiktokOpenConfig = TikTokOpenConfig(tiktokApiId)
            TikTokOpenApiFactory.init(tiktokOpenConfig)

            val mUri = ArrayList<String>()
            mUri.add(videoUri.toString())

            val request = Share.Request()
            mUri.add(videoUri.toString())


            val imageObject = ImageObject()
            imageObject.mImagePaths = mUri

            /*
            val videoObject = VideoObject()
            videoObject.mVideoPaths = mUri
             */

            val content = MediaContent()
            content.mMediaObject = imageObject
            request.mMediaContent = content
            request.mShareFormat = Share.Format.GREEN_SCREEN

            // Share request must specify media type


//            tiktokOpenApi.share(request);

            val shareRequest = ShareRequest.builder()
                .mediaType(ShareRequest.MediaType.IMAGE)
                .mediaPaths(mUri)
                .shareFormat(Share.Format.GREEN_SCREEN)
                .build()

            val tiktokOpenApi: TikTokOpenApi = TikTokOpenApiFactory.create(activity)
//            val shareResult = tiktokOpenApi.share(request)

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
}