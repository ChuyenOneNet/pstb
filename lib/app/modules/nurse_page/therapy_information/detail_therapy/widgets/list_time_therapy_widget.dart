import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/detail_therapy_store.dart';
import 'package:pstb/utils/main.dart';

class ListTimeTherapyWidget extends StatelessWidget {
  ListTimeTherapyWidget({Key? key}) : super(key: key);
  final _store = Modular.get<DetailTherapyStore>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        itemBuilder: (_, index) {
          final dateTimeSubtract =
              DateTime.now().subtract(Duration(days: index));
          return InkWell(
            onTap: () {
              _store.onChangeIndex(index);
            },
            child: Observer(builder: (context) {
              return Container(
                width: 90,
                decoration: BoxDecoration(
                  color: _store.currentIndex == index
                      ? AppColors.primary
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.lightSilver.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 25,
                        offset: const Offset(1, 2)),
                  ],
                ),
                margin: const EdgeInsets.only(right: 4),
                child: Observer(builder: (context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateTimeFormatPattern.weekDayConvert(
                            context, dateTimeSubtract),
                        style: Styles.heading4.copyWith(
                            color: _store.currentIndex == index
                                ? AppColors.background
                                : AppColors.black),
                      ),
                      Text(
                        "${dateTimeSubtract.day}/${dateTimeSubtract.month}",
                        style: Styles.heading4.copyWith(
                            color: _store.currentIndex == index
                                ? AppColors.background
                                : AppColors.black),
                      ),
                    ],
                  );
                }),
              );
            }),
          );
        },
        itemCount: 5,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
