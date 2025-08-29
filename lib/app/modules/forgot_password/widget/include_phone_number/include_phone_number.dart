import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/forgot_password/widget/include_phone_number/include_phone_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class IncludePhoneNumber extends StatefulWidget {
  final Map<String, dynamic> data;
  const IncludePhoneNumber({Key? key, required this.data}) : super(key: key);
  @override
  _IncludePhoneNumberSate createState() => _IncludePhoneNumberSate();
}

class _IncludePhoneNumberSate
    extends ModularState<IncludePhoneNumber, IncludePhoneStore> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller.changeBuildContext(context);
    controller.changeRouteName(widget.data['routeName']);
    super.initState();
  }

  void onConfirm() {
    controller.onCheckUnique();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () {
          if (EasyLoading.isShow) {
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: CustomAppBar(
              icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.grayLight,
            size: Constants.iconBackSize,
          )),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              width: widthConvert(context, 375),
              padding:
                  EdgeInsets.symmetric(horizontal: widthConvert(context, 16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    l10n(context)!.include_phone_number_title,
                    style: Styles.heading2.copyWith(color: AppColors.primary),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: heightConvert(context, 20)),
                      child: Image.asset(
                        ImageEnum.logo_otp,
                        width: widthConvert(context, 160),
                        height: heightConvert(context, 160),
                        fit: BoxFit.contain,
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: widthConvert(context, 20)),
                      child: Text(
                        l10n(context)!.include_phone_number_sub_title,
                        style: Styles.subtitleLarge,
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widthConvert(context, 20),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Observer(
                        builder: (context) => AppInput(
                          validationError: controller.validatePhoneNumber,
                          errorText: controller.phoneValidResponse,
                          hintText: "Số điện thoại",
                          iconLeft: IconEnums.phone,
                          iconRight: IconEnums.close,
                          onChangeValue: controller.changePhoneNumber,
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: widthConvert(context, 20)),
                    child: AppButton(
                      title: l10n(context)!.confirm.toString().toUpperCase(),
                      onPressed: () => {
                        if (_formKey.currentState!.validate()) {onConfirm()}
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
