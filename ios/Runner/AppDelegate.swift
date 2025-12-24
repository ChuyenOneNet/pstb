// import UIKit
// import Flutter
//
// @main
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     // Gọi hàm khởi tạo Flutter mặc định
//     let result = super.application(application, didFinishLaunchingWithOptions: launchOptions)
//
//     // Đăng ký plugin Flutter
//     GeneratedPluginRegistrant.register(with: self)
//
//     return result
//   }
// }

//
//
// import UIKit
// import Flutter
// import SmartCASDK
//
// @main
// @objc class AppDelegate: FlutterAppDelegate {
//
//     private var channelFlutter: FlutterMethodChannel?
//     private var vnptSmartCASDK: VNPTSmartCASDK?
//
//     private var rootFlutterVC: FlutterViewController? {
//         return window?.rootViewController as? FlutterViewController
//     }
//
//     override func application(
//         _ application: UIApplication,
//         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//     ) -> Bool {
//
//         let ok = super.application(application, didFinishLaunchingWithOptions: launchOptions)
//
//         if let rootVC = rootFlutterVC {
//             // Init “rỗng” ban đầu (nếu muốn)
//             configureSDK(customerId: "", customerPhone: "", password: "")
//
//             let channel = FlutterMethodChannel(
//                 name: "com.vnpt.flutter/partner",
//                 binaryMessenger: rootVC.binaryMessenger
//             )
//             channelFlutter = channel
//
//             channel.setMethodCallHandler { [weak self] call, result in
//                 guard let self = self else { return }
//
//                 switch call.method {
//                 case "getAuthentication":
//                     self.getAuthentication()
//                     result(nil)
//
//                 case "getMainInfo":
//                     // ✅ LẤY THAM SỐ TỪ FLUTTER
//                     guard let args = call.arguments as? [String: Any] else {
//                         result(FlutterError(code: "ARG_ERROR",
//                                             message: "getMainInfo expects a Map",
//                                             details: nil))
//                         return
//                     }
//                     let customerPhone = (args["customerPhone"] as? String) ?? ""
//                     let customerId    = (args["customerId"] as? String) ?? ""
//                     let password = args["password"] as? String ?? ""
//
//                     // ✅ Re-init SDK với custom params mới
//                     DispatchQueue.main.async {
//                         self.configureSDK(customerId: customerId, customerPhone: customerPhone, password: password)
//                         // (Tuỳ SDK) Delay nhẹ giống Android 800ms
//                         DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
//                             self.getMainInfo()
//                         }
//                     }
//                     result(nil)
//
//                 case "getWaitingTransaction":
//                     let transactionId = call.arguments as? String ?? ""
//                     self.getWaitingTransaction(transactionId: transactionId)
//                     result(nil)
//
//                 case "signOut":
//                     self.signOut()
//                     result(nil)
//
//                 case "createAccount":
//                     self.createAccount()
//                     result(nil)
//
//                 default:
//                     result(FlutterMethodNotImplemented)
//                 }
//             }
//         }
//
//         // Chỉ cần dòng này
//         GeneratedPluginRegistrant.register(with: self)
//
//         return ok
//     }
//
//     // MARK: - Re-init SDK với params mới (giống Android)
//     private func configureSDK(customerId: String, customerPhone: String, password: String) {
//         guard let rootVC = rootFlutterVC else { return }
//
//         let customParams = CustomParams(
//             customerId: customerId,
//             borderRadiusBtn: 999,
//             colorSecondBtn: "#FFFFFF",
//             colorPrimaryBtn: "#4788FF",
//             featuresLink: "https://www.google.com/?hl=vi",
//             customerPhone: customerPhone,
//             customerEmail: "",
//             packageDefault: "",
//             password: password,
//             logoCustom: "",
//             backgroundLogin: ""
//         )
//
//         // LƯU Ý: Đảm bảo env + clientId/secret trùng logic Android (DEMO vs PROD)
//         let config = SDKConfig(
//             clientId: "45ed-638918937172283188.apps.smartcaapi.com",
//             clientSecret: "NDAwZDk0NGM-NWVmYi00NWVk",
//             environment: ENVIRONMENT.PRODUCTION,
//             //ENVIRONMENT.DEMO, // hoặc .PRODUCTION cho production
//             lang: LANG.VI,
//             isFlutterApp: true,
//             customParams: customParams
//         )
//
//         // Re-init instance để nhận custom params mới
//         vnptSmartCASDK = VNPTSmartCASDK(viewController: rootVC, config: config)
//     }
//
//     // MARK: - Wrapper methods
//     private func getAuthentication() {
//         vnptSmartCASDK?.getAuthentication { [weak self] result in
//             self?.channelFlutter?.invokeMethod("getAuthenticationResult", arguments: result.toJson())
//         }
//     }
//
//     private func getMainInfo() {
//         vnptSmartCASDK?.getMainInfo { [weak self] result in
//             self?.channelFlutter?.invokeMethod("getMainInfoResult", arguments: result.toJson())
//         }
//     }
//
//     private func getWaitingTransaction(transactionId: String) {
//         vnptSmartCASDK?.getWaitingTransaction(tranId: transactionId) { [weak self] result in
//             self?.channelFlutter?.invokeMethod("getWaitingTransactionResult", arguments: result.toJson())
//         }
//     }
//
//     private func signOut() {
//         vnptSmartCASDK?.signOut { [weak self] result in
//             self?.channelFlutter?.invokeMethod("signOutResult", arguments: result.toJson())
//         }
//     }
//
//     private func createAccount() {
//         vnptSmartCASDK?.createAccount { [weak self] result in
//             self?.channelFlutter?.invokeMethod("createAccountResult", arguments: result.toJson())
//         }
//     }
// }

// import UIKit
// import Flutter
// import SmartCASDK
//
// @main
// @objc class AppDelegate: FlutterAppDelegate {
//
//     var channelFlutter: FlutterMethodChannel?
//     var vnptSmartCASDK: VNPTSmartCASDK?
//
//     override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//         if let rootView = window?.rootViewController as? FlutterViewController {
//             let customParams = CustomParams(
//                 customerId: "",
//                 borderRadiusBtn: 999,
//                 colorSecondBtn: "#FFFFFF",
//                 colorPrimaryBtn: "#4788FF",
//                 featuresLink: "https://www.google.com/?hl=vi",
//                 customerPhone: "",
//                 customerEmail: "",
//                 packageDefault: "",
//                 password: "",
//                 logoCustom: "",
//                 backgroundLogin: ""
//             )
//
//             let config = SDKConfig(
//                 clientId: "45ed-638918937172283188.apps.smartcaapi.com",
//                 clientSecret: "NDAwZDk0NGM-NWVmYi00NWVk",
//                 environment: ENVIRONMENT.PRODUCTION,
//                 lang: LANG.VI,
//                 isFlutterApp: true,
//                 customParams: customParams
//             );
//
//             self.vnptSmartCASDK = VNPTSmartCASDK(
//                 viewController: rootView,
//                 config: config)
//
//             let channel = FlutterMethodChannel(name: "com.vnpt.flutter/partner", binaryMessenger: rootView.binaryMessenger)
//             channel.setMethodCallHandler({ (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
//                 self.channelFlutter = channel
//
//                 if call.method == "getAuthentication" {
//                     self.getAuthentication()
//                 } else if call.method == "getMainInfo" {
//                     self.getMainInfo()
//                 } else if call.method == "getWaitingTransaction" {
//                     let transactionId = call.arguments as? String ?? ""
//                     self.getWaitingTransaction(transactionId: transactionId)
//                 } else if call.method == "signOut"{
//                     self.signOut()
//                 } else if call.method == "createAccount" {
//                     self.createAccount()
//                 }
//             })
//         }
//
//         GeneratedPluginRegistrant.register(with: self)
//         GeneratedPluginRegistrant.register(with: self.vnptSmartCASDK?.flutterEngine as! FlutterPluginRegistry);
//
//         return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//     }
//
//     // Lấy thông tin về AccessToken & CredentialId
//     func getAuthentication() {
//         self.vnptSmartCASDK?.getAuthentication(callback: { result in
//             self.channelFlutter?.invokeMethod("getAuthenticationResult", arguments: result.toJson())
//         });
//     }
//
//     func getMainInfo() {
//         self.vnptSmartCASDK?.getMainInfo(callback: { result in
//             self.channelFlutter?.invokeMethod("getMainInfoResult", arguments: result.toJson())
//         })
//     }
//
//     // Khách hàng xác nhận / hủy giao dịch.
//     func getWaitingTransaction(transactionId: String) {
//         self.vnptSmartCASDK?.getWaitingTransaction(tranId: transactionId, callback: { result in
//             self.channelFlutter?.invokeMethod("getWaitingTransactionResult", arguments: result.toJson())
//         })
//     }
//
//     func signOut() {
//         self.vnptSmartCASDK?.signOut(callback: { result in
//             self.channelFlutter?.invokeMethod("signOutResult", arguments: result.toJson())
//         })
//     }
//
//     func createAccount() {
//         self.vnptSmartCASDK?.createAccount(callback: { result in
//             self.channelFlutter?.invokeMethod("createAccountResult", arguments: result.toJson())
//         })
//     }
// }
import UIKit
import Flutter
import SmartCASDK

@main
@objc class AppDelegate: FlutterAppDelegate {

    private var channelFlutter: FlutterMethodChannel?
    private var vnptSmartCASDK: VNPTSmartCASDK?

    private var rootFlutterVC: FlutterViewController? {
        return window?.rootViewController as? FlutterViewController
    }

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // Register plugins for the main Flutter engine (root app)
        let ok = super.application(application, didFinishLaunchingWithOptions: launchOptions)
        GeneratedPluginRegistrant.register(with: self)

        guard let rootVC = rootFlutterVC else {
            return ok
        }

        // Init SDK (empty/default) at startup
        configureSDK(customerId: "", customerPhone: "", password: "")

        // Setup method channel
        let channel = FlutterMethodChannel(
            name: "com.vnpt.flutter/partner",
            binaryMessenger: rootVC.binaryMessenger
        )
        channelFlutter = channel

        channel.setMethodCallHandler { [weak self] call, result in
            guard let self = self else { return }

            switch call.method {

            case "getAuthentication":
                self.getAuthentication()
                result(nil)

            case "getMainInfo":
                // Expect Map from Flutter
                guard let args = call.arguments as? [String: Any] else {
                    result(FlutterError(
                        code: "ARG_ERROR",
                        message: "getMainInfo expects a Map<String, dynamic>",
                        details: call.arguments
                    ))
                    return
                }

                let customerPhone = (args["customerPhone"] as? String) ?? ""
                let customerId    = (args["customerId"] as? String) ?? ""
                let password      = (args["password"] as? String) ?? ""

                // Re-init SDK with new params (ensure on main thread)
                DispatchQueue.main.async {
                    self.configureSDK(
                        customerId: customerId,
                        customerPhone: customerPhone,
                        password: password
                    )

                    // Some SDKs need a short delay after init before calling APIs
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        self.getMainInfo()
                    }
                }

                result(nil)

            case "getWaitingTransaction":
                let transactionId = call.arguments as? String ?? ""
                self.getWaitingTransaction(transactionId: transactionId)
                result(nil)

            case "signOut":
                self.signOut()
                result(nil)

            case "createAccount":
                self.createAccount()
                result(nil)

            default:
                result(FlutterMethodNotImplemented)
            }
        }

        return ok
    }

    // MARK: - Re-init SDK with params (important: register plugins for SDK engine)
    private func configureSDK(customerId: String, customerPhone: String, password: String) {
        guard let rootVC = rootFlutterVC else { return }

        let customParams = CustomParams(
            customerId: customerId,
            borderRadiusBtn: 999,
            colorSecondBtn: "#FFFFFF",
            colorPrimaryBtn: "#4788FF",
            featuresLink: "https://www.google.com/?hl=vi",
            customerPhone: customerPhone,
            customerEmail: "",
            packageDefault: "",
            password: password,
            logoCustom: "",
            backgroundLogin: ""
        )

        let config = SDKConfig(
            clientId: "45ed-638918937172283188.apps.smartcaapi.com",
            clientSecret: "NDAwZDk0NGM-NWVmYi00NWVk",
            environment: ENVIRONMENT.PRODUCTION,
            lang: LANG.VI,
            isFlutterApp: true,
            customParams: customParams
        )

        // Re-init SDK instance
        vnptSmartCASDK = VNPTSmartCASDK(viewController: rootVC, config: config)

        // ✅ Critical fix:
        // SmartCA SDK often runs with its own FlutterEngine. If that engine
        // doesn't register plugins, calls like flutter_secure_storage.write()
        // will throw "no implementation found for method write..."
        if let engine = vnptSmartCASDK?.flutterEngine {
            GeneratedPluginRegistrant.register(with: engine)
        }
    }

    // MARK: - Wrapper methods
    private func getAuthentication() {
        vnptSmartCASDK?.getAuthentication { [weak self] sdkResult in
            self?.channelFlutter?.invokeMethod(
                "getAuthenticationResult",
                arguments: sdkResult.toJson()
            )
        }
    }

    private func getMainInfo() {
        vnptSmartCASDK?.getMainInfo { [weak self] sdkResult in
            self?.channelFlutter?.invokeMethod(
                "getMainInfoResult",
                arguments: sdkResult.toJson()
            )
        }
    }

    private func getWaitingTransaction(transactionId: String) {
        vnptSmartCASDK?.getWaitingTransaction(tranId: transactionId) { [weak self] sdkResult in
            self?.channelFlutter?.invokeMethod(
                "getWaitingTransactionResult",
                arguments: sdkResult.toJson()
            )
        }
    }

    private func signOut() {
        vnptSmartCASDK?.signOut { [weak self] sdkResult in
            self?.channelFlutter?.invokeMethod(
                "signOutResult",
                arguments: sdkResult.toJson()
            )
        }
    }

    private func createAccount() {
        vnptSmartCASDK?.createAccount { [weak self] sdkResult in
            self?.channelFlutter?.invokeMethod(
                "createAccountResult",
                arguments: sdkResult.toJson()
            )
        }
    }
}
