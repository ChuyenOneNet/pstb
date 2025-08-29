import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/modules/notification/widget/hotline_phone_widget.dart';
import 'package:pstb/utils/main.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../../services/api_base_helper.dart';
import '../../../../app_store.dart';
import '../../../../models/notification_model.dart';

import 'notifi_detail_store.dart';

class NotificationDetailsPage extends StatefulWidget {
  NotificationItemModel? notification;

  NotificationDetailsPage({Key? key, this.notification}) : super(key: key);

  @override
  State<NotificationDetailsPage> createState() =>
      _NotificationDetailsPageState();
}

class _NotificationDetailsPageState extends State<NotificationDetailsPage> {
  final NotificationDetailsStore _notificationDetailsStore =
      NotificationDetailsStore();
  final AppStore _appStore = Modular.get<AppStore>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationDetailsStore.loadDetails(
        _appStore.remoteMessage, widget.notification);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Modular.to.pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: SvgPicture.asset(
                IconEnums.yellowArrow,
                color: AppColors.background,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text('Chỉnh sửa thông tin',
              style: Styles.heading4.copyWith(color: AppColors.background)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // const NewTopAppWidget(
            //     titleAppbar: "Xem kết quả", isShowBackButton: true),
            _notificationDetailsStore.getLoadingState
                ? const SizedBox()
                : Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: SvgPicture.asset(
                                            IconEnums.calendar)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        _notificationDetailsStore.getDate,
                                        style: Styles.subtitleSmallest,
                                      ),
                                    )
                                  ],
                                ),
                                Center(
                                  child: Text(
                                    _notificationDetailsStore.getTitle,
                                    style: Styles.heading4
                                        .copyWith(color: AppColors.black),
                                  ),
                                ),
                                if (_notificationDetailsStore.getUrl != "")
                                  Expanded(child: Observer(builder: (context) {
                                    return SfPdfViewer.network(
                                      _notificationDetailsStore.getUrl,
                                      headers: headers,
                                      enableDoubleTapZooming: true,
                                    );
                                  })),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                'Vui lòng gọi đến số hotline nếu bạn cần thêm thông tin hoặc cần giải đáp thắc mắc',
                                textAlign: TextAlign.center,
                                style: Styles.subtitleSmallest,
                              ),
                              HotlinePhoneWidget()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          ],
        ),
      );
    });
  }
}
