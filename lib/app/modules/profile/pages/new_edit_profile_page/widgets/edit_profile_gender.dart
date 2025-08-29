import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/main.dart';
import '../../edit_profile_page/edit_profile_store.dart';

final List<IconData> icons = [Icons.man, Icons.woman];
final List<String> titleGenders = ['Nam', 'Nữ'];

class EditGenderUserProfile extends StatefulWidget {
  const EditGenderUserProfile({Key? key}) : super(key: key);

  @override
  State<EditGenderUserProfile> createState() => _EditGenderUserProfileState();
}

class _EditGenderUserProfileState extends State<EditGenderUserProfile> {
  final EditProfileStore _controller = Modular.get<EditProfileStore>();
  final _userController = Modular.get<UserAppStore>();

  @override
  void initState() {
    _controller.gender =
        _userController.user.gender == 'f' ? Gender.f : Gender.m;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.wc, color: Colors.black.withOpacity(0.4)),
          const SizedBox(width: 8),
          Expanded(
            child: Observer(builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  icons.length,
                  (index) => Expanded(
                    child: InkWell(
                      onTap: () {
                        _controller.onSelectGender(Gender.values[index]);
                      },
                      child: Row(
                        children: [
                          Radio<Gender>(
                              value: Gender.values[index],
                              groupValue: _controller.gender,
                              onChanged: (gender) {
                                _controller.onSelectGender(gender);
                              }),
                          Icon(
                            icons[index],
                            color: AppColors.gray500,
                          ),
                          Text(
                            titleGenders[index],
                            style: Styles.content,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
