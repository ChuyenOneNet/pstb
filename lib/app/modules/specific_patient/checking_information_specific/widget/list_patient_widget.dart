import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/specific_patient/checking_information_specific/checking_specific_patient_store.dart';
import 'package:pstb/app/modules/specific_patient/checking_information_specific/widget/item_patient_widget.dart';
import 'package:pstb/app/modules/specific_patient/list_specific/list_specific_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/divider_custom_widget.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class ListPatientWidget extends StatelessWidget {
  const ListPatientWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final _controller = Modular.get<CheckingSpecificPatientStore>();
      if (_controller.listRegistration == null) {
        return Center(child: Text(_controller.errorMessage ?? ''));
      }
      if (_controller.listRegistration!.isEmpty) {
        return const Center(child: Text('Dữ liệu trống'));
      }
      final dates =
          randomDatesDescendingOrder(_controller.listRegistration!.length);
      return RefreshIndicator(
        onRefresh: _controller.initState,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            final indication = _controller.listRegistration![index];
            return ItemPatientWidget(
              date: dates[index],
              patient: indication.patientQrModel,
              department: indication.departmentModel,
              onTap: () async {
                final specificController = Modular.get<ListSpecificStore>();
                EasyLoading.show();
                await specificController.initState(
                    id: indication.id ?? '',
                    patientQrModel: indication.patientQrModel,
                    departmentModel: indication.departmentModel);
                EasyLoading.dismiss();
                Modular.to.pushNamed(AppRoutes.listSpecific);
                if (specificController.errorMessage != null) {
                  EasyLoading.dismiss();
                  AppSnackBar.show(context, AppSnackBarType.Error,
                      specificController.errorMessage);
                }
              },
            );
          },
          // separatorBuilder: (_, index) {
          //   return const DividerCustomWidget();
          // },
          itemCount: _controller.listRegistration!.length,
        ),
      );
    });
  }

  List<DateTime> randomDatesDescendingOrder(int count) {
    final random = Random();
    final start = DateTime(2022, 1, 1);
    final end = DateTime(2022, 12, 31);
    final range = end.difference(start).inDays;

    final List<DateTime> dates = List.generate(count, (index) {
      final randomDays = random.nextInt(range);
      return start.add(Duration(days: randomDays));
    });

    dates.sort((a, b) => b.compareTo(a));

    return dates;
  }
}
