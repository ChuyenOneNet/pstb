import 'package:flutter/material.dart';
import 'package:pstb/app/models/registration_model.dart';
import 'package:pstb/app/modules/specific_patient/list_specific/widget/item_specific_widget.dart';
import 'package:pstb/widgets/stateless/divider_custom_widget.dart';

class ListRegistrationByStatusWidget extends StatelessWidget {
  const ListRegistrationByStatusWidget({
    Key? key,
    required this.controller,
    required this.listRegistration,
  }) : super(key: key);

  final ScrollController controller;
  final List<RegistrationModel>? listRegistration;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller,
      child: ListView.separated(
          controller: controller,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 16.0),
          itemBuilder: (_, index) {
            return ItemSpecificWidget(
              registration: listRegistration![index],
            );
          },
          separatorBuilder: (_, index) {
            return const DividerCustomWidget();
          },
          itemCount: listRegistration?.length ?? 0),
    );
  }
}
