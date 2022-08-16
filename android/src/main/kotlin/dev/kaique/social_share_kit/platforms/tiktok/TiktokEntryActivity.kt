package dev.kaique.social_share_kit.platforms.tiktok

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.annotation.Nullable
import com.bytedance.sdk.open.tiktok.TikTokOpenApiFactory
import com.bytedance.sdk.open.tiktok.api.TikTokOpenApi
import com.bytedance.sdk.open.tiktok.common.handler.IApiEventHandler
import com.bytedance.sdk.open.tiktok.common.model.BaseReq
import com.bytedance.sdk.open.tiktok.common.model.BaseResp
import com.bytedance.sdk.open.tiktok.share.Share

internal class TiktokEntryActivity : Activity(), IApiEventHandler {
    val ACTION_STAY_IN_TT = "com.aweme.opensdk.action.stay.in.dy"

    var ttOpenApi: TikTokOpenApi? = null
    public override fun onCreate(@Nullable savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        ttOpenApi = TikTokOpenApiFactory.create(this)
//        ttOpenApi.handleIntent(intent, this) // receive and parse callback
    }

    override fun onReq(req: BaseReq) {
        Log.d("TikTokEntryActivity", req.toString())
    }
    override fun onResp(resp: BaseResp) {
        Log.d("TikTokEntryActivity", resp.toString())
        /*
        if (resp.type == TikTokConstants.ModeType.SHARE_CONTENT_TO_TT_RESP) {
            val response = resp as Share.Response
            Toast.makeText(
                this,
                " code：" + response.errorCode + " errorMessage：" + response.errorMsg,
                Toast.LENGTH_SHORT
            ).show()
        }

         */
    }

    override fun onErrorIntent(@Nullable intent: Intent) {
        Toast.makeText(this, "Intent Error", Toast.LENGTH_LONG).show()
    }
}
