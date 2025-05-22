package com.microchip.ble_charger_app

import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import com.here.sdk.core.engine.SDKNativeEngine
import com.here.sdk.core.engine.SDKOptions
import com.here.sdk.core.errors.InstantiationErrorException

class MainActivity : FlutterActivity() {
    private val TAG = "MainActivity"

    override fun onCreate(savedInstanceState: Bundle?) {
        // ✅ MUST call this before super.onCreate() to ensure SDK is ready
        initializeHereSDK()
        super.onCreate(savedInstanceState)
    }

    override fun onDestroy() {
        SDKNativeEngine.getSharedInstance()?.dispose()
        super.onDestroy()
    }

    private fun initializeHereSDK() {
        val accessKeyId = getMetaDataValue("com.here.sdk.access_key_id")
        val accessKeySecret = getMetaDataValue("com.here.sdk.access_key_secret")

        if (accessKeyId.isNullOrEmpty() || accessKeySecret.isNullOrEmpty()) {
            Log.e(TAG, "HERE credentials not found in manifest")
            return
        }

        Log.i(TAG, "Initializing HERE SDK with AccessKeyId: ${accessKeyId.take(10)}...")

        try {
            val options = SDKOptions(accessKeyId, accessKeySecret)
            SDKNativeEngine.makeSharedInstance(this, options)
            Log.i(TAG, "HERE SDK initialized successfully")
        } catch (e: InstantiationErrorException) {
            Log.e(TAG, "HERE SDK initialization failed: ${e.message}")
        } catch (e: Exception) {
            Log.e(TAG, "Unexpected error during HERE SDK initialization: ${e.message}")
        }
    }

    private fun getMetaDataValue(name: String): String? {
        return try {
            val appInfo = packageManager.getApplicationInfo(packageName, android.content.pm.PackageManager.GET_META_DATA)
            appInfo.metaData?.getString(name)
        } catch (e: Exception) {
            Log.e(TAG, "Error reading metadata $name: ${e.message}")
            null
        }
    }
}
