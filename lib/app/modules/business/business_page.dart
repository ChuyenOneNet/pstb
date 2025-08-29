import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/business/page/business_list_booking.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';
import 'business_store.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
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
                ? Expanded(child: BusinessListBooking())
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
