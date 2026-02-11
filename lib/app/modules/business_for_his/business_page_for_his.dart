import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pstb/app/modules/business/page/business_list_booking.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';
import '../business/business_store.dart';
import 'business_list_booking_for_his.dart';

class BusinessPageForHis extends StatefulWidget {
  const BusinessPageForHis({
    Key? key,
  }) : super(key: key);

  @override
  State<BusinessPageForHis> createState() => _BusinessPageForHisState();
}

class _BusinessPageForHisState extends State<BusinessPageForHis> {
  final BusinessStore controller = Modular.get<BusinessStore>();

  @override
  void dispose() {
    Modular.dispose<BusinessStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Hồ sơ sức khỏe',
        isBack: true,
      ),
      body: Observer(builder: (context) {
        return Column(
          children: [
            controller.userBusiness.id != null
                ? Expanded(child: BusinessListBookingForHis())
                : Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Chưa có thông tin hồ sơ sức khỏe. Vui lòng quay lại sau!',
                          textAlign: TextAlign.center,
                          style: Styles.content,
                        ),
                      ),
                    ),
                  ),
          ],
        );
      }),
    );
  }
}
