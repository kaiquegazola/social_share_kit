package dev.kaique.social_share_kit.services

import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.content.pm.Signature
import android.os.Build
import dev.kaique.social_share_kit.utils.Md5Converter

object PackageService {
    fun verifyIfPackageIsInstalled(context: Context, appPackageName: String) {
        val installed = isPackageInstalled(context, appPackageName)
        if (!installed) {
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

    fun getAppSignatureMD5(context: Context): String? {
        return try {

            val manager: PackageManager = context.packageManager

            val pkgInfoFlag = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                PackageManager.GET_SIGNING_CERTIFICATES
            } else {
                @Suppress("DEPRECATION")
                PackageManager.GET_SIGNATURES
            }
            val packageInfo = manager.getPackageInfo(context.packageName, pkgInfoFlag)

            if (packageInfo != null) {
                return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                    val signInfo = packageInfo.signingInfo
                    val signatures: Array<Signature> = signInfo.apkContentsSigners
                    Md5Converter.hexDigest(signatures[0].toByteArray())
                } else {
                    @Suppress("DEPRECATION")
                    val signatures: Array<Signature> = packageInfo.signatures
                    Md5Converter.hexDigest(signatures[0].toByteArray())
                }

            }

            return null

        } catch (e: Exception) {
            null
        }
    }
}