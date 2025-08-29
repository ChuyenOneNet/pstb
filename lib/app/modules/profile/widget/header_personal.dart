import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/age_utils.dart';
import 'package:pstb/utils/gender_utils.dart';
import 'package:pstb/utils/main.dart';

class HeaderPersonalWidget extends StatelessWidget {
  const HeaderPersonalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final _userStore = Modular.get<UserAppStore>();
      return Row(
        children: [
          CircleAvatar(
            maxRadius: 36,
            backgroundColor: AppColors.primary,
            backgroundImage: (_userStore.user.avatar != null &&
                    _userStore.user.avatar!.isNotEmpty)
                ? NetworkImage(_userStore.user.avatar!)
                : null,
            child: (_userStore.user.avatar == null ||
                    _userStore.user.avatar!.isEmpty)
                ? const Icon(Icons.person, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _userStore.user.fullName ?? '',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium // Use headlineMedium instead of headline5
                    ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        IconEnums.iconGenderInformation,
                        color: Colors.black.withOpacity(0.4),
                      ),
                      const SizedBox(width: 4),
                      Text(GenderUtils.parseGenderString(
                          _userStore.user.gender ?? '')),
                    ],
                  ),
                  const SizedBox(width: 8),
                  if (_userStore.user.age != null)
                    Observer(builder: (context) {
                      final birthday =
                          DateFormat('dd/M/y').parse(_userStore.user.dob ?? '');
                      return Row(
                        children: [
                          SvgPicture.asset(
                            IconEnums.iconCalendarInformation,
                            color: Colors.black.withOpacity(0.4),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${AgeUtils(birthday).calculatedAge().toString()} ${AgeUtils(birthday).typeAge()}',
                          ),
                        ],
                      );
                    }),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SvgPicture.asset(
                    IconEnums.iconCallingInformation,
                    color: Colors.black.withOpacity(0.4),
                  ),
                  const SizedBox(width: 4),
                  Text(_userStore.user.phone ?? ''),
                ],
              ),
            ],
          ),
        ],
      );
    });
  }
}
