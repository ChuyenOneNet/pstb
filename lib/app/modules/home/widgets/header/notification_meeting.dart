import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/helper.dart';
import 'package:pstb/utils/icons.dart';
import 'package:pstb/utils/l10n.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

import '../../home_store.dart';

class NotificationMeeting extends StatelessWidget {
  final HomeStore _homeStore = Modular.get<HomeStore>();
  NotificationMeeting({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthConvert(context, 375),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Observer(builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widthConvert(context, 16),
            vertical: heightConvert(context, 12),
          ),
          child: _homeStore.bookings.isEmpty
              ? Text(
                  l10n(context)!.home_meetingstack_no_meeting!,
                  style: Styles.descriptionNoti,
                )
              : Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(right: widthConvert(context, 12)),
                      child: const CircleWithIcon(
                        boxSize: 48,
                        iconSize: 48,
                        icon: IconEnums.homeFill,
                      ),
                    ),
                    Flexible(
                      child: Observer(
                        builder: (_) {
                          return RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: l10n(context)!
                                      .home_meetingstack_dontfoget,
                                  style: Styles.descriptionNoti,
                                ),
                                TextSpan(
                                  text: _homeStore.firstTimeBooking,
                                  style: Styles.descriptionNoti
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
        );
      }),
    );
  }
}
