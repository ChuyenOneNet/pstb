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

        let ok = super.application(application, didFinishLaunchingWithOptions: launchOptions)

        if let rootVC = rootFlutterVC {
            // Init “rỗng” ban đầu (nếu muốn)
            configureSDK(customerId: "", customerPhone: "", password: "")

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
                    // ✅ LẤY THAM SỐ TỪ FLUTTER
                    guard let args = call.arguments as? [String: Any] else {
                        result(FlutterError(code: "ARG_ERROR",
                                            message: "getMainInfo expects a Map",
                                            details: nil))
                        return
                    }
                    let customerPhone = (args["customerPhone"] as? String) ?? ""
                    let customerId    = (args["customerId"] as? String) ?? ""
                    let password = args["password"] as? String ?? ""

                    // ✅ Re-init SDK với custom params mới
                    DispatchQueue.main.async {
                        self.configureSDK(customerId: customerId, customerPhone: customerPhone, password: password)
                        // (Tuỳ SDK) Delay nhẹ giống Android 800ms
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
        }

        // Chỉ cần dòng này
        GeneratedPluginRegistrant.register(with: self)

        return ok
    }

    // MARK: - Re-init SDK với params mới (giống Android)
    private func configureSDK(customerId: String, customerPhone: String, password: String) {
        guard let rootVC = rootFlutterVC else { return }

        let customParams = CustomParams(
            customerId: customerId,
            borderRadiusBtn: 999,
            colorSecondBtn: "#FFFFFF",
            colorPrimaryBtn: "#4788FF",
            featuresLink: "https://www.google.com/?hl=vi",
            customerPhone: customerPhone,
            packageDefault: "",
            password: password,
            logoCustom: "",
            backgroundLogin: ""
        )

        // LƯU Ý: Đảm bảo env + clientId/secret trùng logic Android (DEMO vs PROD)
        let config = SDKConfig(
            clientId: "45ed-638918937172283188.apps.smartcaapi.com",
            clientSecret: "NDAwZDk0NGM-NWVmYi00NWVk",
            environment: ENVIRONMENT.PRODUCTION,
            //ENVIRONMENT.DEMO, // hoặc .PRODUCTION cho production
            lang: LANG.VI,
            isFlutterApp: true,
            customParams: customParams
        )

        // Re-init instance để nhận custom params mới
        vnptSmartCASDK = VNPTSmartCASDK(viewController: rootVC, config: config)
    }

    // MARK: - Wrapper methods
    private func getAuthentication() {
        vnptSmartCASDK?.getAuthentication { [weak self] result in
            self?.channelFlutter?.invokeMethod("getAuthenticationResult", arguments: result.toJson())
        }
    }

    private func getMainInfo() {
        vnptSmartCASDK?.getMainInfo { [weak self] result in
            self?.channelFlutter?.invokeMethod("getMainInfoResult", arguments: result.toJson())
        }
    }

    private func getWaitingTransaction(transactionId: String) {
        vnptSmartCASDK?.getWaitingTransaction(tranId: transactionId) { [weak self] result in
            self?.channelFlutter?.invokeMethod("getWaitingTransactionResult", arguments: result.toJson())
        }
    }

    private func signOut() {
        vnptSmartCASDK?.signOut { [weak self] result in
            self?.channelFlutter?.invokeMethod("signOutResult", arguments: result.toJson())
        }
    }

    private func createAccount() {
        vnptSmartCASDK?.createAccount { [weak self] result in
            self?.channelFlutter?.invokeMethod("createAccountResult", arguments: result.toJson())
        }
    }
}
