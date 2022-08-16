package dev.kaique.social_share_kit.services

import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.net.Uri

object PackageService {
    fun verifyIfPackageIsInstalled(context: Context, appPackageName: String) {
        val installed = isPackageInstalled(context, appPackageName)
        if(!installed){
            throw Exception("$appPackageName is not installed.")
        }
    }

    private fun isPackageInstalled(context: Context, appPackageName: String): Boolean {
        return try {
            val packageManager = context.packageManager
            packageManager.getPackageInfo(appPackageName, 0)
            true
        } catch (e: PackageManager.NameNotFoundException) {
            false
        }
    }

    fun getBundleMetaData(context: Context, key: String): String? {
        return try {
            val ai: ApplicationInfo = context.packageManager.getApplicationInfo(
                context.packageName,
                PackageManager.GET_META_DATA
            )
            val bundle = ai.metaData
            bundle.getString(key)

        } catch (e: Exception) {
            null
        }

    }
}