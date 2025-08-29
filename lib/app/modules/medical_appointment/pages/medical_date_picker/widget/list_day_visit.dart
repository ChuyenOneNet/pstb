import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';

import '../medical_store.dart';

class BuildListDayVisit extends StatefulWidget {
  const BuildListDayVisit({
    Key? key,
    required this.onClickDayVisit,
    required this.listDayPickerLength,
  }) : super(key: key);

  final Function(int) onClickDayVisit;
  final int listDayPickerLength;

  @override
  State<BuildListDayVisit> createState() => _BuildListDayVisitState();
}

class _BuildListDayVisitState extends State<BuildListDayVisit> {
  final ScrollController _scrollController = ScrollController();
  final MedicalStore controller = Modular.get<MedicalStore>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 60) {
        controller.addDayVisitDoctor();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView.builder(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: controller.listDayVisitDoctor.length,
        itemBuilder: (context, index) {
          return TouchableOpacity(
            onTap: () {
              widget.onClickDayVisit(index);
            },
            child: Observer(builder: (context) {
              return DateTimeFormatPattern.weekDayConvert(
                        context,
                        controller.listDayVisitDoctor[index],
                      ) !=
                      l10n(context)!.sun
                  ? Container(
                      decoration: BoxDecoration(
                        color: controller.idDayPicked == index
                            ? AppColors.primary
                            : AppColors.background,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadowBaseShadow,
                            spreadRadius: 4,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                        border: Border.all(color: AppColors.lightSilver),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateTimeFormatPattern.weekDayConvert(
                              context,
                              controller.listDayVisitDoctor[index],
                            ),
                            style: Styles.content.copyWith(
                              color: controller.idDayPicked == index
                                  ? AppColors.background
                                  : AppColors.black,
                            ),
                          ),
                          Text(
                            DateFormat(DateTimeFormatPattern.formatddMM)
                                .format(controller.listDayVisitDoctor[index]),
                            style: Styles.content.copyWith(
                              color: controller.idDayPicked == index
                                  ? AppColors.background
                                  : AppColors.black,
                            ),
                          ),
                          Container(
                            height: 2,
                            width: widthConvert(context, 100),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: controller.idDayPicked == index
                                  ? AppColors.primary
                                  : AppColors.background,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox();
            }),
          );
        },
      ),
    );
  }
}

class BuildListDaySample extends StatefulWidget {
  const BuildListDaySample({
    Key? key,
    required this.onClickDayVisit,
    required this.listDayPickerLength,
  }) : super(key: key);

  final Function(int) onClickDayVisit;
  final int listDayPickerLength;

  @override
  State<BuildListDaySample> createState() => _BuildListDaySampleState();
}

class _BuildListDaySampleState extends State<BuildListDaySample> {
  final ScrollController _scrollController = ScrollController();
  final MedicalStore controller = Modular.get<MedicalStore>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 60) {
        controller.addDayGetSample();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: controller.listDayGetSample.length,
      itemBuilder: (context, index) {
        if (DateTimeFormatPattern.weekDayConvert(
              context,
              controller.listDayGetSample[index],
            ) !=
            l10n(context)!.sun) {
          return TouchableOpacity(
            onTap: () {
              widget.onClickDayVisit(index);
            },
            child: Observer(builder: (context) {
              return Container(
                decoration: BoxDecoration(
                  color: controller.idSampleDayPicked == index
                      ? AppColors.primary
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowBaseShadow,
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: AppColors.lightSilver),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          DateTimeFormatPattern.weekDayConvert(
                            context,
                            controller.listDayGetSample[index],
                          ),
                          style: Styles.heading4.copyWith(
                            color: controller.idSampleDayPicked == index
                                ? AppColors.background
                                : AppColors.black,
                          ),
                        ),
                        Text(
                          DateFormat(DateTimeFormatPattern.formatddMM)
                              .format(controller.listDayGetSample[index]),
                          style: Styles.content.copyWith(
                            color: controller.idSampleDayPicked == index
                                ? AppColors.background
                                : AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 2,
                      width: widthConvert(context, 100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: controller.idSampleDayPicked == index
                            ? AppColors.primary
                            : AppColors.background,
                      ),
                    )
                  ],
                ),
              );
            }),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
