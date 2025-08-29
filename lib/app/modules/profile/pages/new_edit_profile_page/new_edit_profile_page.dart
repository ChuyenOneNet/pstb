import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/modules/profile/pages/new_edit_profile_page/widgets/header_new_edit_profile.dart';
import 'package:pstb/utils/icons.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';
import '../../../../../utils/colors.dart';
import '../../../../user_app_store.dart';
import '../edit_profile_page/edit_profile_store.dart';
import 'widgets/new_edit_profile_body.dart';

class NewEditProfilePage extends StatefulWidget {
  const NewEditProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NewEditProfilePageState();
  }
}

class NewEditProfilePageState
    extends ModularState<NewEditProfilePage, EditProfileStore> {
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller.onChangeBuildContext(context);
    controller.initialValue(_userAppStore.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          title: 'Chỉnh sửa thông tin',
          isBack: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              controller.onUpdateUser();
            }
          },
          child: SvgPicture.asset(IconEnums.save),
          backgroundColor: AppColors.primary,
        ),
        body: Column(
          children: [
            const HeaderNewEditProfilePage(),
            Expanded(
              child: SingleChildScrollView(
                  child:
                      Form(key: _formKey, child: NewEditProfileBodyWidget())),
            )
          ],
        ),
      ),
    );
  }
}
