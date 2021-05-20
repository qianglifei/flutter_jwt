package com.mobile.qlf.jwt.application;

import android.app.Application;

/**
 * @author :qlf
 */
public class application extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
//        //初始化组件化基础库, 所有友盟业务SDK都必须调用此初始化接口。
//        UMConfigure.init(this, "59892f08310c9307b60023d0", "Umeng", UMConfigure.DEVICE_TYPE_PHONE, "");
//        //选择AUTO自动采集模式（必须！）
//        MobclickAgent.setPageCollectionMode(MobclickAgent.PageMode.AUTO);
    }
}
