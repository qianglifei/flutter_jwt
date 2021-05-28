package com.mobile.qlf.jwt

import android.app.ProgressDialog.show
import android.os.Bundle
import android.os.PersistableBundle
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.SplashScreen
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.umeng.analytics.MobclickAgent;
import com.umeng.commonsdk.UMConfigure

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        //在此调用，实现引导页屏幕的显示
    }


    override fun onResume() {
        super.onResume()
        MobclickAgent.onResume(this);
    }

    override fun onPause() {
        super.onPause()
        MobclickAgent.onPause(this);
    }


    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        UMConfigure.init(this,"60b064a56c421a3d97d05e3a", "cps_1.1.0", UMConfigure.DEVICE_TYPE_PHONE, null);
        UMConfigure.setLogEnabled(true);
    }
}
