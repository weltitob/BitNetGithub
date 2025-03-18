package com.example.moonpay_flutter

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.OnBackPressedCallback
import com.moonpay.sdk.MoonPayAndroidSdk
import com.moonpay.sdk.MoonPayBuyQueryParams
import com.moonpay.sdk.MoonPayHandlers
import com.moonpay.sdk.MoonPayRenderingOptionAndroid
import com.moonpay.sdk.MoonPaySdkBuyConfig
import com.moonpay.sdk.MoonPayWidgetEnvironment
import io.flutter.Log
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel

class ComposeActivity : ComponentActivity() {
    companion object {
        const val WALLET_ADDRESS = "wallet_address"
        const val BTC_AMOUNT = "btc_amount"
        const val LANGUAGE = "language"
        const val BASE_CURRENCY_CODE = "base_currency_code"
        const val BASE_CURRENCY_AMOUNT = "base_currency_amount"
        const val SIGNATURE = "signature"
        const val CHANNEL_NAME = "channel_name"
        const val ACTION_SEND_SIGNATURE = "action_send_signature"
        const val PAYMENT_METHOD = "payment_method"
    }
    private var channel: MethodChannel? = null
    private var signature: String? = null
    private lateinit var moonPaySdk: MoonPayAndroidSdk
    private val TAG = "Flutter"

    private val signatureReceiver =
            object : BroadcastReceiver() {
                override fun onReceive(context: Context?, intent: Intent?) {
                    signature = intent?.getStringExtra(SIGNATURE)
                    Log.i("Flutter", "BROADCAST RECEIVED")
                    if (signature != null) {
                        continueWithMoonPay()
                    }
                }
            }
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.i(TAG, "COMPOSE ACTIVITY CREATED")
        AppController.getInstance()!!.composeActivity = this
        // Get data from Intent
        val walletAddress = intent.getStringExtra(WALLET_ADDRESS) ?: ""
        val btcAmount = intent.getDoubleExtra(BTC_AMOUNT, 0.0)
        val language = intent.getStringExtra(LANGUAGE) ?: ""
        val baseCurrencyCode = intent.getStringExtra(BASE_CURRENCY_CODE) ?: ""
        val baseCurrencyAmount = intent.getDoubleExtra(BASE_CURRENCY_AMOUNT, 0.0)
        val channelName = intent.getStringExtra(CHANNEL_NAME)
        val paymentMethod = intent.getStringExtra(PAYMENT_METHOD)
        val flutterEngine = FlutterEngineCache.getInstance().get("main_flutter_engine")
        if (channelName != null) {
            if (flutterEngine != null) {
                channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            }
        }

        // Configure MoonPay SDK
        val params = MoonPayBuyQueryParams(apiKey = "pk_test_HInzm5oiHpMjfu7cC2CLzQ31YgH7LaA")
        params.setCurrencyCode("btc")
        params.setWalletAddress(walletAddress)
        params.setBaseCurrencyAmount(baseCurrencyAmount)
        params.setBaseCurrencyCode(baseCurrencyCode)
        params.setLanguage(language)
        params.setQuoteCurrencyAmount(btcAmount)
        params.setPaymentMethod(paymentMethod)
        params.setShowWalletAddressForm("true")

        val config =
                MoonPaySdkBuyConfig(
                        environment = MoonPayWidgetEnvironment.Sandbox,
                        debug = true,
                        params = params,
                        handlers =
                                MoonPayHandlers(
                                        onTransactionCompleted = {
                                            Log.i("HANDLER CALLED", "onKmsWalletCreated called!")
                                        },
                                )
                )

        // Initialize and show MoonPay SDK
        moonPaySdk = MoonPayAndroidSdk(config = config, activity = this)
        channel?.invokeMethod("onUrlForSigningGenerated", moonPaySdk.generateUrlForSigning())
        Log.i(TAG, "CHANNEL METHOD INVOKED SHOULD BE INVOKED AAAa ${channel == null}, ")

        // Handle back press
        val onBackPressedCallback =
                object : OnBackPressedCallback(true) {
                    override fun handleOnBackPressed() {
                        Log.d(TAG, "Back button pressed!")

                        finish()
                    }
                }
        onBackPressedDispatcher.addCallback(this, onBackPressedCallback)

        val filter = IntentFilter(ACTION_SEND_SIGNATURE)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            registerReceiver(signatureReceiver, filter, RECEIVER_NOT_EXPORTED)
        } else {
            registerReceiver(signatureReceiver, filter)
        }
    }
    private fun continueWithMoonPay() {
        if (signature != null) {
            moonPaySdk.updateSignature(signature!!)

            moonPaySdk.show(MoonPayRenderingOptionAndroid.InAppBrowser)
            finish()
        }
    }
    public fun continueWithMoonPay(sign: String) {
        moonPaySdk.updateSignature(sign)

        moonPaySdk.show(MoonPayRenderingOptionAndroid.InAppBrowser)
    }
    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(signatureReceiver)
    }

    override fun onResume() {
        super.onResume()
        Log.i(TAG, "COMPOSE ACTIVITY RESUMED")
    }

    override fun onPause() {
        super.onPause()
        Log.i(TAG, "Compose Activity paused")
    }
}
