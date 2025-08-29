import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_store.dart';
import 'package:pstb/repository/notifications/new_notifications_model.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';

class BuildItemNotification extends StatelessWidget {
  BuildItemNotification({
    Key? key,
    required this.listNotification,
    required this.index,
  }) : super(key: key);
  final BottomNavStore _navStore = Modular.get<BottomNavStore>();

  final List<NotificationModel> listNotification;
  final int index;

  @override
  Widget build(BuildContext context) {
    var type = listNotification[index].type;

    return TouchableOpacity(
      child: Container(
        width: widthConvert(context, 375),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color:
              type == "prescription" ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  //TODO: icon
                  type == "booking"
                      ? Container(
                          width: widthConvert(context, 40),
                          height: widthConvert(context, 40),
                          padding: EdgeInsets.all(widthConvert(context, 10)),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                              color: AppColors.accent50,
                              borderRadius: BorderRadius.circular(40)),
                          child: SvgPicture.asset(
                            IconEnums.medicalNote2,
                            color: AppColors.infor900,
                          ),
                        )
                      : const SizedBox(),
                  Expanded(
                    child: Text(
                      // TODO: title
                      listNotification[index].content.toString(),
                      style: Styles.heading5.copyWith(
                          // TODO: icon
                          color: type != "news"
                              ? type == "prescription"
                                  ? AppColors.greenText
                                  : AppColors.infor900
                              : AppColors.neutral900),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Text(
                  DateTimeFormatPattern.timeFromNow(
                    context,
                    listNotification[index].created!,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        if (listNotification[index].type == 'booking') {
          _navStore.updateCurrentIndex(2);
        } else if (listNotification[index].type == 'news') {
          Modular.to.pushNamed(
            AppRoutes.newDetail,
            arguments: listNotification[index].documentId,
          );
        } else if (listNotification[index].type == 'prescription') {
          Modular.to.pushNamed(AppRoutes.prescriptionModule);
        }
      },
    );
  }
}
