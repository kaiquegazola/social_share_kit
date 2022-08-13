package dev.kaique.social_share_kit.services


import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.core.content.FileProvider
import java.io.File

object FileService : FileProvider() {

    fun exportUriForFile(context: Context, filePath: String): Uri {
        return try {
            val file = File(filePath)
            val packageName = context.applicationContext.packageName
            val authority = "$packageName.dev.kaique.social_share_kit"
            getUriForFile(context, authority, file)
        } catch (e: Exception) {
            throw Exception("Error resolving FileProvider Uri for file $filePath", e)
        }
    }

    fun grantUriPermission(activity: Activity, packageName: String, uri: Uri) {
        activity.grantUriPermission(
            packageName,
            uri,
            Intent.FLAG_GRANT_READ_URI_PERMISSION
        )
    }

    fun getFileType(type: String): String {
        return when (type) {
            "video" -> {
                "video/*"
            }
            "image" -> {
                "image/*"
            }
            "audio" -> {
                "audio/*"
            }
            else -> {
                "*/*"
            }
        }
    }
}

