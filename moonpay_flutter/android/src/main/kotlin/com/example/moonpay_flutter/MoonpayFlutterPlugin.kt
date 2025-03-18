package com.example.moonpay_flutter

import android.app.Activity
import android.content.Intent
import android.os.Build
import androidx.activity.ComponentActivity
import androidx.annotation.NonNull
import com.moonpay.sdk.MoonPayAndroidSdk
import com.moonpay.sdk.MoonPayBuyQueryParams
import com.moonpay.sdk.MoonPayHandlers
import com.moonpay.sdk.MoonPayRenderingOptionAndroid
import com.moonpay.sdk.MoonPaySdkBuyConfig
import com.moonpay.sdk.MoonPayWidgetEnvironment
import io.flutter.Log
import io.flutter.embedding.engine.FlutterEngineCache

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** MoonpayFlutterPlugin */
class MoonpayFlutterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null


  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "moonpay_flutter")
    channel.setMethodCallHandler(this)

      FlutterEngineCache.getInstance().put("main_flutter_engine", flutterPluginBinding.flutterEngine)


  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "show_moon_pay") {
       // Get data from arguments
        val arguments = call.arguments as List<Any?>
        val walletAddress = arguments[0] as String
        val btcAmount = arguments[1] as Double
        val language = arguments[2] as String
        val baseCurrencyCode = arguments[3] as String
        val baseCurrencyAmount = arguments[4] as Double
        val paymentMethod = arguments[5] as String
        // Create Intent to launch ComposeActivity
        val intent = Intent(activity, ComposeActivity::class.java)
        intent.putExtra(ComposeActivity.WALLET_ADDRESS, walletAddress)
        intent.putExtra(ComposeActivity.BTC_AMOUNT, btcAmount)
        intent.putExtra(ComposeActivity.LANGUAGE, language)
        intent.putExtra(ComposeActivity.BASE_CURRENCY_CODE, baseCurrencyCode)
        intent.putExtra(ComposeActivity.BASE_CURRENCY_AMOUNT, baseCurrencyAmount)
        intent.putExtra(ComposeActivity.CHANNEL_NAME, "moonpay_flutter")
        intent.putExtra(ComposeActivity.PAYMENT_METHOD, paymentMethod)

        // Start ComposeActivity
        activity?.startActivity(intent)


        result.success(true) // Indicate success to Flutter
    }else if(call.method =="send_signature") {
        Log.i("Flutter", "Send SIGNATURE CALLED")

        val arguments = call.arguments as List<Any?>

        val signature = arguments[0] as String
        val intent = Intent(ComposeActivity.ACTION_SEND_SIGNATURE)
        intent.putExtra(ComposeActivity.SIGNATURE, signature)
        Log.i("Flutter", "activity is component? ${activity is ComponentActivity}")

        AppController.getInstance()!!.composeActivity?.continueWithMoonPay(signature)
        Log.i("Flutter", "activity is null? ${AppController.getInstance()!!.composeActivity == null}")
        Log.i("Flutter", "BROADCAST SENT")

        result.success(null)

    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)

  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

}
