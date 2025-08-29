import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/modules/medical_appointment/pages/doctor_info/models/doctor_attr_group_model.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/styles.dart';

class DoctorAttributeGroupWidget extends StatelessWidget {
  final DoctorAttributeGroupViewModel model;
  final bool? showDotPoint;

  const DoctorAttributeGroupWidget(
      {Key? key, required this.model, this.showDotPoint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Styles.cardShadow.copyWith(
        color: AppColors.background, borderRadius: BorderRadius.circular(8),),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildHeader(),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: _buildList(),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return model.descriptions.isEmpty
        ? const SizedBox()
        : Row(
            children: [
              SvgPicture.asset(model.icon),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(model.title,
                    style: Styles.titleItem.copyWith(
                        color: AppColors.black,)),
              )
            ],
          );
  }

  Widget _buildList() {
    return model.descriptions.isEmpty
        ? const SizedBox()
        : Column(
            children: List.generate(model.descriptions.length, (index) {
            var des = model.descriptions[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: des!.isNotEmpty
                  ? Row(
                      children: [
                        showDotPoint ?? false
                            ? Container(
                                width: 5,
                                height: 5,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              )
                            : const SizedBox(),
                        Flexible(
                            child: Text(
                          des,
                          style: Styles.content,
                        )),
                      ],
                    )
                  : const SizedBox(),
            );
          }));
  }
}
