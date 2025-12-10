package com.onenet.tbps

import android.os.Bundle
import com.vnpt.smartca.*
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Handler
import android.os.Looper

class MainActivity : FlutterFragmentActivity() {

    private val smartCA by lazy { VNPTSmartCASDK() }
    private lateinit var methodChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Bridge Flutter <-> Native
        methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.vnpt.flutter/partner"
        )

        // Khởi tạo SDK bằng Activity context (UI thread)
        runOnUiThread {
            try {
                val customParams = CustomParams(
                    customerId = "",
                    customerPhone = "",
                    borderRadiusBtn = 999.0,
                    colorSecondBtn = "#DEF7EB",
                    colorPrimaryBtn = "#33CC80",
                    featuresLink = "",
                    packageDefault = "",
                    password = "",
                    logoCustom = "",
                    backgroundLogin = ""
                )

                val config = ConfigSDK(
                    env =
                    SmartCAEnvironment.PROD_ENV,
                    //SmartCAEnvironment.DEMO_ENV,
                    // TODO: điền giá trị thật
                    clientId =

                    "45ed-638918937172283188.apps.smartcaapi.com",
                    //"4cbb-638966544758480303.apps.smartcaapi.com",
                    clientSecret =

                    "NDAwZDk0NGM-NWVmYi00NWVk",
                    //"ZThlN2U5NDY-ZWYzMC00Y2Ji",
                    lang = SmartCALanguage.VI,
                    isFlutter = true,
                    customParams = customParams
                )
                // smartCA.setDebugMode(true)
                smartCA.initSDK(this@MainActivity, config)
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }

        // Handler các method từ Flutter
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "createAccount" -> createAccount()
                "getAuthentication" -> getAuthentication()
                "getMainInfo" -> {
                    val args = call.arguments as? Map<*, *>
                    val customerPhone =
                        //"0342702590"
                        args?.get("customerPhone") as? String ?: ""
                    val personalId = args?.get("customerId") as? String ?: ""
                    val password = args?.get("password") as? String ?: ""
                    getMainInfo(customerPhone, personalId, password)
                }

                "getWaitingTransaction" ->
                    (call.arguments as? String)?.let { getWaitingTransaction(it) }
                "signOut" -> signOut()
                else -> result.notImplemented()
            }
        }
    }

    private fun createAccount() {
        runOnUiThread {
            try {
                smartCA.createAccount { sdkResult ->
                    runOnUiThread {
                        if (::methodChannel.isInitialized) {
                            methodChannel.invokeMethod("createAccountResult", getMap(sdkResult))
                        }
                    }
                }
            } catch (e: Exception) {
                e.printStackTrace()
                runOnUiThread {
                    if (::methodChannel.isInitialized) {
                        methodChannel.invokeMethod(
                            "createAccountResult",
                            hashMapOf("status" to false, "statusDesc" to (e.message ?: "error"))
                        )
                    }
                }
            }
        }
    }

    private fun getAuthentication() {
        runOnUiThread {
            try {
                smartCA.getAuthentication { sdkResult ->
                    methodChannel.invokeMethod("getAuthenticationResult", getMap(sdkResult))
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }

    private fun getMainInfo(customerPhone: String, personalId: String, password: String) {
        runOnUiThread {
            try {
                val customParams = CustomParams(
                    customerId = personalId,
                    customerPhone = customerPhone,
                    borderRadiusBtn = 999.0,
                    colorSecondBtn = "#DEF7EB",
                    colorPrimaryBtn = "#33CC80",
                    featuresLink = "",
                    packageDefault = "",
                    password = password,
                    logoCustom = "",
                    backgroundLogin = ""
                )

                val config = ConfigSDK(
                    env =
                    //SmartCAEnvironment.DEMO_ENV,
                    SmartCAEnvironment.PROD_ENV,
                    clientId =
                    //"4cbb-638966544758480303.apps.smartcaapi.com",
                    "45ed-638918937172283188.apps.smartcaapi.com",
                    clientSecret =
                    //"ZThlN2U5NDY-ZWYzMC00Y2Ji",
                    "NDAwZDk0NGM-NWVmYi00NWVk",
                    lang = SmartCALanguage.VI,
                    isFlutter = true,
                    customParams = customParams
                )

                smartCA.initSDK(this@MainActivity, config)
                Handler(Looper.getMainLooper()).postDelayed({
                    smartCA.getMainInfo { sdkResult ->
                        methodChannel.invokeMethod("getMainInfoResult", getMap(sdkResult))
                    }
                }, 1500)
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }


    private fun getWaitingTransaction(transId: String) {
        runOnUiThread {
            try {
                smartCA.getWaitingTransaction(transId) { sdkResult ->
                    methodChannel.invokeMethod("getWaitingTransactionResult", getMap(sdkResult))
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }

    private fun signOut() {
        runOnUiThread {
            try {
                smartCA.signOut { sdkResult ->
                    methodChannel.invokeMethod("signOutResult", getMap(sdkResult))
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }

    private fun getMap(result: SmartCAResult): HashMap<String, Any> {
        val map = HashMap<String, Any>()
        map["status"] = result.status
        result.statusDesc?.let { map["statusDesc"] = it }
        result.data?.let { map["data"] = it }
        return map
    }
}

//package com.example.pstb
//
//import android.os.Bundle
//import android.os.Handler
//import android.os.Looper
//import com.vnpt.smartca.*
//import io.flutter.embedding.android.FlutterFragmentActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodChannel
//
//class MainActivity : FlutterFragmentActivity() {
//
//    private val smartCA by lazy { VNPTSmartCASDK() }
//    private lateinit var methodChannel: MethodChannel
//
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//
//        // Bridge Flutter <-> Native
//        methodChannel = MethodChannel(
//            flutterEngine.dartExecutor.binaryMessenger,
//            "com.vnpt.flutter/partner"
//        )
//
//        // Khởi tạo SDK bằng Activity context (UI thread)
//        runOnUiThread {
//            try {
//                val customParams = CustomParams(
//                    customerId = "",
//                    customerPhone = "",
//                    borderRadiusBtn = 999.0,
//                    colorSecondBtn = "#DEF7EB",
//                    colorPrimaryBtn = "#33CC80",
//                    featuresLink = "",
//                    packageDefault = "",
//                    password = "",
//                    logoCustom = "",
//                    backgroundLogin = ""
//                )
//
//                val config = ConfigSDK(
//                    env = SmartCAEnvironment.PROD_ENV, // SmartCAEnvironment.DEMO_ENV
//                    clientId = "45ed-638918937172283188.apps.smartcaapi.com",
//                    clientSecret = "NDAwZDk0NGM-NWVmYi00NWVk",
//                    lang = SmartCALanguage.VI,
//                    isFlutter = true,
//                    customParams = customParams
//                )
//
//                // smartCA.setDebugMode(true)
//                smartCA.initSDK(this@MainActivity, config)
//            } catch (e: Exception) {
//                e.printStackTrace()
//            }
//        }
//
//        // Handler các method từ Flutter
//        methodChannel.setMethodCallHandler { call, result ->
//            when (call.method) {
//                "createAccount" -> createAccount()
//                "getAuthentication" -> getAuthentication()
//                "getMainInfo" -> {
//                    val args = call.arguments as? Map<*, *>
//                    val customerPhone = args?.get("customerPhone") as? String ?: ""
//                    val personalId = args?.get("customerId") as? String ?: ""
//                    getMainInfo(customerPhone, personalId)
//                }
//                "getWaitingTransaction" -> (call.arguments as? String)?.let { getWaitingTransaction(it) }
//                "signOut" -> signOut()
//                else -> result.notImplemented()
//            }
//        }
//    }
//
//    private fun createAccount() {
//        runOnUiThread {
//            try {
//                smartCA.createAccount { sdkResult ->
//                    runOnUiThread {
//                        if (::methodChannel.isInitialized) {
//                            methodChannel.invokeMethod("createAccountResult", getMap(sdkResult))
//                        }
//                    }
//                }
//            } catch (e: Exception) {
//                e.printStackTrace()
//                runOnUiThread {
//                    if (::methodChannel.isInitialized) {
//                        methodChannel.invokeMethod(
//                            "createAccountResult",
//                            hashMapOf(
//                                "status" to false,
//                                "statusDesc" to (e.message ?: "error")
//                            )
//                        )
//                    }
//                }
//            }
//        }
//    }
//
//    private fun getAuthentication() {
//        runOnUiThread {
//            try {
//                smartCA.getAuthentication { sdkResult ->
//                    methodChannel.invokeMethod("getAuthenticationResult", getMap(sdkResult))
//                }
//            } catch (e: Exception) {
//                e.printStackTrace()
//            }
//        }
//    }
//
//    private fun getMainInfo(customerPhone: String, personalId: String) {
//        runOnUiThread {
//            try {
//                val customParams = CustomParams(
//                    customerId = personalId,
//                    customerPhone = customerPhone,
//                    borderRadiusBtn = 999.0,
//                    colorSecondBtn = "#DEF7EB",
//                    colorPrimaryBtn = "#33CC80",
//                    featuresLink = "",
//                    packageDefault = "",
//                    password = "",
//                    logoCustom = "",
//                    backgroundLogin = ""
//                )
//
//                val config = ConfigSDK(
//                    env = SmartCAEnvironment.PROD_ENV,
//                    clientId = "45ed-638918937172283188.apps.smartcaapi.com",
//                    clientSecret = "NDAwZDk0NGM-NWVmYi00NWVk",
//                    lang = SmartCALanguage.VI,
//                    isFlutter = true,
//                    customParams = customParams
//                )
//
//                smartCA.initSDK(this@MainActivity, config)
//
//                Handler(Looper.getMainLooper()).postDelayed({
//                    smartCA.getMainInfo { sdkResult ->
//                        methodChannel.invokeMethod("getMainInfoResult", getMap(sdkResult))
//                    }
//                }, 1500)
//            } catch (e: Exception) {
//                e.printStackTrace()
//            }
//        }
//    }
//
//    private fun getWaitingTransaction(transId: String) {
//        runOnUiThread {
//            try {
//                smartCA.getWaitingTransaction(transId) { sdkResult ->
//                    methodChannel.invokeMethod("getWaitingTransactionResult", getMap(sdkResult))
//                }
//            } catch (e: Exception) {
//                e.printStackTrace()
//            }
//        }
//    }
//
//    private fun signOut() {
//        runOnUiThread {
//            try {
//                smartCA.signOut { sdkResult ->
//                    methodChannel.invokeMethod("signOutResult", getMap(sdkResult))
//                }
//            } catch (e: Exception) {
//                e.printStackTrace()
//            }
//        }
//    }
//
//    private fun getMap(result: SmartCAResult): HashMap<String, Any> {
//        val map = HashMap<String, Any>()
//        map["status"] = result.status
//        result.statusDesc?.let { map["statusDesc"] = it }
//        result.data?.let { map["data"] = it }
//        return map
//    }
//}
