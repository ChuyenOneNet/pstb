import 'package:flutter/material.dart';
import 'package:pstb/app/modules/profile/pages/new_edit_profile_page/widgets/edit_profile_gender.dart';
import 'package:pstb/utils/styles.dart';
import '../../../../../../utils/colors.dart';
import '../../edit_profile_page/edit_profile_store.dart';

class GenderUserProfile extends StatelessWidget {
  final bool isMan;

  const GenderUserProfile({Key? key, required this.isMan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.wc, color: Colors.black.withOpacity(0.4)),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                icons.length,
                (index) => Expanded(
                  child: Row(
                    children: [
                      Radio<Gender>(
                          value: Gender.values[index],
                          groupValue: isMan ? Gender.m : Gender.f,
                          onChanged: (_) {}),
                      Icon(
                        icons[index],
                        color: Colors.black.withOpacity(0.4),
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
          ),
        ],
      ),
    );
  }
}
