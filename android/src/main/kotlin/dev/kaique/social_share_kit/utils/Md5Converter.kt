package dev.kaique.social_share_kit.utils

import java.security.MessageDigest

object Md5Converter {

    private val hexDigits = charArrayOf(
            48.toChar(),
            49.toChar(),
            50.toChar(),
            51.toChar(),
            52.toChar(),
            53.toChar(),
            54.toChar(),
            55.toChar(),
            56.toChar(),
            57.toChar(),
            97.toChar(),
            98.toChar(),
            99.toChar(),
            100.toChar(),
            101.toChar(),
            102.toChar()
    )

    fun hexDigest(paramArrayOfByte: ByteArray?): String? {
        try {
            val localMessageDigest: MessageDigest = MessageDigest.getInstance("MD5")
            localMessageDigest.update(paramArrayOfByte)
            val arrayOfByte: ByteArray = localMessageDigest.digest()
            val arrayOfChar = CharArray(32)
            var i = 0
            var j = 0
            while (true) {
                if (i >= 16) return String(arrayOfChar)
                val k = arrayOfByte[i].toInt()
                val m = j + 1
                arrayOfChar[j] = hexDigits[0xF and k ushr 4]
                j = m + 1
                arrayOfChar[m] = hexDigits[k and 0xF]
                i++
            }
        } catch (localException: java.lang.Exception) {
        }
        return null
    }
}
