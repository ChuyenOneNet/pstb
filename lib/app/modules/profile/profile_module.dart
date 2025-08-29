import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/profile/pages/edit_profile_page/edit_profile_store.dart';
import 'package:pstb/app/modules/profile/pages/new_edit_profile_page/new_edit_profile_page.dart';
import 'package:pstb/app/modules/profile/pages/payment_method/payment_method_page.dart';
import 'package:pstb/app/modules/profile/pages/profile_page/profile_page.dart';
import 'package:pstb/app/modules/profile/pages/setting/profile_setting.dart';
import 'package:pstb/app/modules/profile/pages/steps_foot/steps_foot_page.dart';
import 'package:pstb/app/modules/profile/pages/steps_foot/steps_foot_store.dart';
import 'package:pstb/app/modules/profile/profile_home_page.dart';
import 'package:pstb/app/modules/profile/profile_store.dart';
import 'package:pstb/utils/routes.dart';

class ProfileModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProfileStore()),
    Bind.lazySingleton((i) => EditProfileStore()),
    Bind.lazySingleton((i) => StepsFootStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const ProfileHomePage(),
    ),
    ChildRoute(
      AppRoutes.profilePage,
      child: (_, args) => MainProfile(),
    ),
    ChildRoute(
      AppRoutes.newEditProfile,
      child: (_, args) => const NewEditProfilePage(),
    ),
    ChildRoute(
      AppRoutes.paymentMethodPage,
      child: (_, args) => const PaymentMethodPage(),
    ),
    ChildRoute(
      AppRoutes.profileSettingPage,
      child: (_, args) => const ProfileSetting(),
    ),
    ChildRoute(
      AppRoutes.profileStepsFoodPage,
      child: (_, args) => const StepsFootPage(),
    ),
  ];

  ProfileModule({Key? key}) : super(key: key);

  @override
  Widget get view => const ProfileHomePage();
}
