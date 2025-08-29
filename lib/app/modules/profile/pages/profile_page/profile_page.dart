import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/app/app_store.dart';
import 'package:pstb/app/modules/profile/pages/profile_page/widgets/header_profile.dart';
import 'package:pstb/app/modules/profile/pages/profile_page/widgets/new_profile_body.dart';
import 'package:pstb/app/modules/profile/profile_store.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';

class MainProfile extends StatefulWidget {
  MainProfile({Key? key}) : super(key: key);

  @override
  State<MainProfile> createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  final AppStore controller = Modular.get<AppStore>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  final _profileController = Modular.get<ProfileStore>();

  @override
  void initState() {
    // TODO: implement initState
    _profileController.avatar = _userAppStore.user.avatar;
    _profileController.onChangeBuildContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(title: 'Thông tin cá nhân'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Modular.to.pushNamed(AppRoutes.newEditProfilePage),
        child: SvgPicture.asset(IconEnums.iconEdit,
            fit: BoxFit.cover, color: Colors.white),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 16),
          HeaderProfilePage(),
          const SizedBox(height: 16),
          NewProfileBodyWidget()
        ],
      ),
    );
  }
}
