import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/utils/sessions/local_secure.dart';

import '../app/models/sign/common_sign_channel_response.dart';
import '../app/models/sign/confirm_or_cancel_all_trans_model.dart';
import '../app/models/sign/sign_transaction_model.dart';
import '../widgets/stateless/content_easy_loading_widget.dart';
import 'colors.dart';
import 'constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUtil {
  static const MethodChannel _channel =
      MethodChannel('benhvienhuunghivietduc.com.vn/platform');
  static bool fakeActivated = false;
  static bool fakePreActivate = false;

  // static Future<CommonSignChannelResponse?> initWithSendOTP() async {
  //   try {
  //     final res = await _channel.invokeMethod('initWithSendOTP');
  //     return CommonSignChannelResponse.fromJson(Map<String, dynamic>.from(res));
  //   } on PlatformException catch (e) {
  //     print("Failed to initWithSendOTP: '${e.message}'.");
  //     return null;
  //   }
  // }

  static Future<ListSignTransactionResponse?> getTransactionsList() async {
    try {
      if (fakeActivated) {
        print("myApp_f getTransactionsList test");
        return ListSignTransactionResponse(isSuccess: true);
      }
      final transactionsList =
          await _channel.invokeMethod('getTransactionsList');

      return ListSignTransactionResponse.fromJson(
          Map<String, dynamic>.from(transactionsList));
    } on PlatformException catch (e) {
      print("myApp_f Failed to getTransactionsList: '${e.message}'.");
      return null;
    }
  }

  static Future<CommonSignChannelResponse?> selectTransaction(
      String idTran) async {
    try {
      final res = await _channel
          .invokeMethod('selectTransaction', {'transactionID': idTran});

      return CommonSignChannelResponse.fromJson(Map<String, dynamic>.from(res));
    } on PlatformException catch (e) {
      print("myApp_f Failed to selectTransaction: '${e.message}'.");

      return null;
    }
  }

  static Future<CommonSignChannelResponse?> confirmTransaction() async {
    try {
      final res = await _channel.invokeMethod('confirmTransaction');

      return CommonSignChannelResponse.fromJson(Map<String, dynamic>.from(res));
    } on PlatformException catch (e) {
      print("myApp_f Failed to confirmTransaction: '${e.message}'.");

      return null;
    }
  }

  static Future<CommonSignChannelResponse?> cancelTransaction() async {
    try {
      final res = await _channel.invokeMethod('cancelTransaction');

      return CommonSignChannelResponse.fromJson(Map<String, dynamic>.from(res));
    } on PlatformException catch (e) {
      print("myApp_f Failed to cancelTransaction: '${e.message}'.");

      return null;
    }
  }

  static Future<CommonSignChannelResponse?> verifyOTP(String otp) async {
    if (fakeActivated) {
      print("myApp_f verifyOTP test ");
      return CommonSignChannelResponse(isSuccess: true);
    }
    try {
      final res = await _channel.invokeMethod('verifyOTP', {'otp': otp});

      return CommonSignChannelResponse.fromJson(Map<String, dynamic>.from(res));
    } on PlatformException catch (e) {
      print("myApp_f Failed to verifyOTP: '${e.message}'.");

      return null;
    }
  }

  static Future<CommonSignChannelResponse?> resendOTP() async {
    try {
      final res = await _channel.invokeMethod('resendOTP');

      return CommonSignChannelResponse.fromJson(Map<String, dynamic>.from(res));
    } on PlatformException catch (e) {
      print("myApp_f Failed to resendOTP: '${e.message}'.");

      return null;
    }
  }

  static Future<bool> isActivatedDevice() async {
    if (fakeActivated) {
      print("myApp_f isActive test $fakeActivated}");
      return true;
    }
    try {
      final bool? res = await _channel.invokeMethod('isActivatedDevice');

      return res ?? false;
    } on PlatformException catch (e) {
      print("myApp_f Failed to isActivatedDevice: '${e.message}'.");

      return false;
    }
  }

  static Future<CommonSignChannelResponse?> setUsername(String userName) async {
    if (fakePreActivate) {
      print("myApp_f setUsername test");
      return CommonSignChannelResponse(isSuccess: true);
    }
    try {
      final res =
          await _channel.invokeMethod('setUsername', {'userName': userName});

      return CommonSignChannelResponse.fromJson(Map<String, dynamic>.from(res));
    } on PlatformException catch (e) {
      print("myApp_f Failed to setUsername: '${e.message}'.");

      return null;
    }
  }

  //
  static Future<CommonSignChannelResponse?> setPassword(String pass) async {
    if (fakePreActivate) {
      print("myApp_f setPassword test");
      return CommonSignChannelResponse(isSuccess: true);
    }
    try {
      final res = await _channel.invokeMethod('setPassword', {'pass': pass});

      return CommonSignChannelResponse.fromJson(Map<String, dynamic>.from(res));
    } on PlatformException catch (e) {
      print("myApp_f Failed to setPassword: '${e.message}'.");

      return null;
    }
  }

  static Future<CommonSignChannelResponse?> setActivationCode(
      String activationCode) async {
    if (fakePreActivate) {
      print("myApp_f setActivationCode test");
      return CommonSignChannelResponse(isSuccess: true);
    }
    try {
      final res = await _channel.invokeMethod(
          'setActivationCode', {'activationCode': activationCode});

      return CommonSignChannelResponse.fromJson(Map<String, dynamic>.from(res));
    } on PlatformException catch (e) {
      print("myApp_f Failed to setActivationCode: '${e.message}'.");

      return null;
    }
  }

  static Future<String?> setFirebaseID(String firebaseId) async {
    if (fakePreActivate) return "setFirebaseID test";
    try {
      final String? res = await _channel
          .invokeMethod('setFirebaseID', {'firebaseId': firebaseId});

      return res;
    } on PlatformException catch (e) {
      print("myApp_f Failed to setFirebaseID: '${e.message}'.");

      return null;
    }
  }

  static Future<String?> setSicPin(String pin) async {
    if (fakePreActivate) return "setSicPin test";
    try {
      final String? res =
          await _channel.invokeMethod('setSicPin', {'pin': pin});

      return res;
    } on PlatformException catch (e) {
      print("myApp_f Failed to setSicPin: '${e.message}'.");

      return null;
    }
  }

  static Future<CommonSignChannelResponse?> finishActivationDevice(
      String recoveryCode) async {
    if (fakePreActivate) {
      print("myApp_f finishActivationDevice test");
      return CommonSignChannelResponse(isSuccess: true);
    }
    try {
      final res = await _channel.invokeMethod(
          'finishActivationDevice', {'recoveryCode': recoveryCode});

      return CommonSignChannelResponse.fromJson(Map<String, dynamic>.from(res));
    } on PlatformException catch (e) {
      print("myApp_f Failed to finishActivationDevice: '${e.message}'.");

      return null;
    }
  }

  static Future<String?> startSecurityService() async {
    try {
      final String? res = await _channel.invokeMethod('startSecurityService');

      return res;
    } on PlatformException catch (e) {
      print("myApp_f Failed to startSecurityService: '${e.message}'.");

      return null;
    }
  }

  static Future<CommonSignChannelResponse?> unlockDevice(String pinCode,
      {bool? generateNewToken = false}) async {
    if (fakePreActivate) {
      print("myApp_f unlockDevice test");
      return CommonSignChannelResponse(isSuccess: true);
    }
    try {
      final res = await _channel.invokeMethod('unlockDevice',
          {'pinCode': pinCode, 'generateNewToken': generateNewToken});

      return CommonSignChannelResponse.fromJson(Map<String, dynamic>.from(res));
    } on PlatformException catch (e) {
      print("myApp_f Failed to unlockDevice: '${e.message}'.");

      return null;
    }
  }

  static Future<CommonSignChannelResponse?> loginWithPass(
    String pass,
  ) async {
    try {
      final res = await _channel.invokeMethod('loginWithPass', {'pass': pass});

      return CommonSignChannelResponse.fromJson(Map<String, dynamic>.from(res));
    } on PlatformException catch (e) {
      print("myApp_f Failed to loginWithPass: '${e.message}'.");

      return null;
    }
  }

  static Future<ConfirmOrCancelAllTransModel> confirmOrCancelAllTransaction(
      Future Function() pushSignpstbFunc, int count,
      {bool isConfirm = true}) async {
    var listTransRes = await SignUtil.getTransactionsList();
    if (listTransRes == null || !listTransRes.isSuccess) {
      final _secure = FlutterSecure();
      var unlockRes = await SignUtil.unlockDevice(
          await _secure.readKeyStorage(key: Constants.keyPinSign) ?? "");
      if (unlockRes == null || !unlockRes.isSuccess) {
        var pass = await _secure.readKeyStorage(key: Constants.keyPASign);
        if (pass != null && pass.isNotEmpty) {
          var logWPass = await SignUtil.loginWithPass(pass);
          if (logWPass == null || !logWPass.isSuccess) {
            return ConfirmOrCancelAllTransModel(isSuccess: false);
          }
        } else {
          return ConfirmOrCancelAllTransModel(isSuccess: false);
        }
      }
    }

    // pushSignpstbFunc;
    // var listTransRes2 = await SignUtil.getTransactionsList();
    // if (listTransRes2 != null && listTransRes2.isSuccess) {
    //   var listSDKTrans = <SignTransactionModel>[];
    //   if (listTransRes2.data == null || listTransRes2.data!.isEmpty) {
    //     await Future.delayed(Duration(seconds: 1), () async {
    //       var listTransRes3 = await SignUtil.getTransactionsList();
    //       if (listTransRes3 != null && listTransRes3.data != null)
    //         listSDKTrans = listTransRes3.data!;
    //     });
    //   } else {
    //     listSDKTrans = listTransRes2.data!;
    //   }
    //   if (listSDKTrans.isNotEmpty) {
    //     var listSuccess = <SignTransactionModel>[];
    //     var listFail = <SignTransactionModel>[];
    //     for (var itemTran in listSDKTrans) {
    //       if (itemTran.type == "SIGN") {
    //         var selectRes =
    //             await SignUtil.selectTransaction(itemTran.transactionID);
    //         if (selectRes != null && selectRes.isSuccess) {
    //           var signRes = isConfirm
    //               ? await SignUtil.confirmTransaction()
    //               : await SignUtil.cancelTransaction();
    //           if (signRes != null && signRes.isSuccess) {
    //             listSuccess.add(itemTran);
    //           } else {
    //             listFail.add(itemTran);
    //           }
    //         } else {
    //           listFail.add(itemTran);
    //         }
    //       }
    //     }
    //     return ConfirmOrCancelAllTransModel(
    //         isSuccess: true, successItems: listSuccess, failItems: listFail);
    //   }
    // }
    // return ConfirmOrCancelAllTransModel(isSuccess: false);

    final allRes = await Future.wait([
      pushSignpstbFunc(),
      confirmOrCancelAllTransactionPart(count, isConfirm: isConfirm)
    ]);

    print("myApp_f ${DateTime.now().toIso8601String()} END allRes");
    return allRes[1];
  }

  static Future<ConfirmOrCancelAllTransModel> confirmOrCancelAllTransactionPart(
      int count,
      {bool isConfirm = true}) async {
    //wait BE push SDK
    var currentCount = 0;
    var emptyCount = 0;
    return await Future.delayed(Duration(seconds: 2), () async {
      var listSuccess = <SignTransactionModel>[];
      var listFail = <SignTransactionModel>[];
      var isOut = false;

      do {
        var listTransRes = await SignUtil.getTransactionsList();
        if (listTransRes != null &&
            listTransRes.isSuccess &&
            listTransRes.data != null &&
            listTransRes.data!.isNotEmpty) {
          for (var itemTran in listTransRes.data!) {
            if (itemTran.type == "SIGN") {
              currentCount += 1;
              emptyCount -= 1;
              var selectRes =
                  await SignUtil.selectTransaction(itemTran.transactionID);
              if (selectRes != null && selectRes.isSuccess) {
                var signRes = isConfirm
                    ? await SignUtil.confirmTransaction()
                    : await SignUtil.cancelTransaction();
                if (signRes != null && signRes.isSuccess) {
                  listSuccess.add(itemTran);
                  emptyCount = 0;
                } else {
                  listFail.add(itemTran);
                }
              } else {
                listFail.add(itemTran);
              }
              await Future.delayed(Duration(milliseconds: 300), () {});
            }
          }
        } else {
          emptyCount += 1;
        }

        if (currentCount >= count || emptyCount >= 5) {
          isOut = true;
        }
        if (!isOut) await Future.delayed(Duration(seconds: 2), () {});
        print(
            "myApp_f ${DateTime.now().toIso8601String()} currentCount: $currentCount/$count | emptyCount: $emptyCount");
      } while (!isOut);

      //=============================================================
      // var listTransRes2 = await SignUtil.getTransactionsList();
      // if (listTransRes2 != null && listTransRes2.isSuccess) {
      //   var listSDKTrans = <SignTransactionModel>[];
      //   if (listTransRes2.data == null || listTransRes2.data!.isEmpty) {
      //     print(
      //         "myApp_f flutter confirmOrCancelAllTransactionPart start delay 2");
      //     await Future.delayed(Duration(seconds: 2), () async {
      //       print(
      //           "myApp_f flutter confirmOrCancelAllTransactionPart end delay 2");
      //       var listTransRes3 = await SignUtil.getTransactionsList();
      //       if (listTransRes3 != null && listTransRes3.data != null)
      //         listSDKTrans = listTransRes3.data!;
      //     });
      //   } else {
      //     listSDKTrans = listTransRes2.data!;
      //   }
      //   if (listSDKTrans.isNotEmpty) {
      //     var listSuccess = <SignTransactionModel>[];
      //     var listFail = <SignTransactionModel>[];
      //     for (var itemTran in listSDKTrans) {
      //       if (itemTran.type == "SIGN") {
      //         var selectRes =
      //             await SignUtil.selectTransaction(itemTran.transactionID);
      //         if (selectRes != null && selectRes.isSuccess) {
      //           var signRes = isConfirm
      //               ? await SignUtil.confirmTransaction()
      //               : await SignUtil.cancelTransaction();
      //           if (signRes != null && signRes.isSuccess) {
      //             listSuccess.add(itemTran);
      //           } else {
      //             listFail.add(itemTran);
      //           }
      //         } else {
      //           listFail.add(itemTran);
      //         }
      //       }
      //     }
      //     return ConfirmOrCancelAllTransModel(
      //         isSuccess: true, successItems: listSuccess, failItems: listFail);
      //   }
      // }

      print(
          "myApp_f ${DateTime.now().toIso8601String()} END confirmOrCancelAllTransaction");
      return ConfirmOrCancelAllTransModel(
          isSuccess: true, successItems: listSuccess, failItems: listFail);
      //return ConfirmOrCancelAllTransModel(isSuccess: false);
    });
  }

  // static Future<bool> checkActiveUI(BuildContext context) async {
  //   var allowEnter = true;
  //   final _secure = FlutterSecure();
  //   var un = await _secure.readKeyStorage(key: Constants.keyUNSign);
  //   var pa = await _secure.readKeyStorage(key: Constants.keyPASign);
  //
  //   //if ( Platform.isAndroid || !await SignUtil.isActivatedDevice()) {
  //   //var un = await _secure.readKeyStorage(key: Constants.keyUNSign);
  //   //var pa = await _secure.readKeyStorage(key: Constants.keyPASign);
  //   if (un != null && un.isNotEmpty && pa != null && pa.isNotEmpty) {
  //     await EasyLoading.show(indicator: ContentEasyLoadingWidget());
  //     var setUsernameRes = await SignUtil.setUsername(un);
  //     if (setUsernameRes != null && setUsernameRes.isSuccess) {
  //       if (Platform.isAndroid) {
  //         await EasyLoading.show(indicator: ContentEasyLoadingWidget());
  //         var unlockRes = await SignUtil.unlockDevice(
  //             await _secure.readKeyStorage(key: Constants.keyPinSign) ?? "");
  //
  //         if (unlockRes != null && unlockRes.isSuccess) {
  //           var listTransRes = await SignUtil.getTransactionsList();
  //           if (listTransRes != null && listTransRes.isSuccess) {
  //             await EasyLoading.dismiss();
  //             return true;
  //           }
  //         }
  //       } else {
  //         if (await SignUtil.isActivatedDevice()) {
  //           var listTransRes = await SignUtil.getTransactionsList();
  //           if (listTransRes != null && listTransRes.isSuccess) {
  //             await EasyLoading.dismiss();
  //             return true;
  //           }
  //         }
  //       }
  //
  //       var setPassRes = await SignUtil.setPassword(pa);
  //       if (setPassRes != null && setPassRes.isSuccess) {
  //       } else {
  //         await EasyLoading.dismiss();
  //         if (!allowEnter) {
  //           Fluttertoast.showToast(
  //               msg: 'Không xác định được tài khoản ký',
  //               gravity: ToastGravity.BOTTOM,
  //               backgroundColor: AppColors.error500);
  //           return false;
  //         }
  //         var rsLogin = await showDialog(
  //           context: context,
  //           barrierDismissible: false,
  //           builder: (BuildContext context) {
  //             return SicLoginPopup();
  //           },
  //         );
  //         if (rsLogin != true) {
  //           return false;
  //         }
  //       }
  //     } else {
  //       await EasyLoading.dismiss();
  //       if (!allowEnter) {
  //         Fluttertoast.showToast(
  //             msg: 'Không xác định được tài khoản ký',
  //             gravity: ToastGravity.BOTTOM,
  //             backgroundColor: AppColors.error500);
  //         return false;
  //       }
  //       var rsLogin = await showDialog(
  //         context: context,
  //         barrierDismissible: false,
  //         builder: (BuildContext context) {
  //           return SicLoginPopup();
  //         },
  //       );
  //       if (rsLogin != true) {
  //         return false;
  //       }
  //     }
  //   } else {
  //     if (!allowEnter) {
  //       Fluttertoast.showToast(
  //           msg: 'Không xác định được tài khoản ký',
  //           gravity: ToastGravity.BOTTOM,
  //           backgroundColor: AppColors.error500);
  //       return false;
  //     }
  //     var rsLogin = await showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return SicLoginPopup();
  //       },
  //     );
  //     if (rsLogin != true) {
  //       return false;
  //     }
  //   }
  //   await EasyLoading.dismiss();
  //   //ActivationCode
  //   var otpRs = await showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return SicActivationCodePopup();
  //     },
  //   );
  //   if (otpRs != true) {
  //     return false;
  //   }
  //
  //   if (Platform.isIOS) {
  //     //
  //     final fcmToken = Platform.isIOS
  //         ? await FirebaseMessaging.instance.getAPNSToken()
  //         : await FirebaseMessaging.instance.getToken();
  //     await SignUtil.setFirebaseID("$fcmToken$un");
  //     //pin
  //     var pinRs = await showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return SicPinPopup();
  //       },
  //     );
  //     if (pinRs != true) {
  //       return false;
  //     }
  //   }
  //
  //   //recovery code
  //   var recoveryCodeRs = await showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return SicRecoveryCodePopup();
  //     },
  //   );
  //   if (recoveryCodeRs != true) {
  //     return false;
  //   }
  //   //}
  //   return true;
  // }
}
