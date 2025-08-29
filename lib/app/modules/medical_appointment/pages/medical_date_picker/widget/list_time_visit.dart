import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/utils/main.dart';

import '../model/TimeObject.dart';
import 'item_list_time.dart';

class BuildListTimeVisit extends StatelessWidget {
  const BuildListTimeVisit({
    Key? key,
    required this.listAM,
    required this.listPM,
    this.listTimeGetSample = false,
    required this.onTap,
    this.idTimePicked,
  }) : super(key: key);

  final bool? listTimeGetSample;
  final List<TimeObject> listAM;
  final List<TimeObject> listPM;
  final int? idTimePicked;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          listAM.isEmpty
              ? const SizedBox()
              : Wrap(
                  // direction: Axis.horizontal,
                  children: List.generate(
                    listAM.length,
                    (index) {
                      //TODO first item
                      if (index == 0) {
                        return Column(
                          children: [
                            BuildTimeItem(
                              list: listAM,
                              index: index,
                              idTimePicked: idTimePicked,
                              onTap: onTap,
                            ),
                          ],
                        );
                      }
                      //TODO last item
                      else if (index == listAM.length - 1 && listPM.isEmpty) {
                        return Column(
                          children: [
                            BuildTimeItem(
                              list: listAM,
                              index: index,
                              idTimePicked: idTimePicked,
                              onTap: onTap,
                              specialLastItem: true,
                            ),
                          ],
                        );
                      }
                      //TODO nomal item
                      else {
                        return BuildTimeItem(
                          list: listAM,
                          index: index,
                          idTimePicked: idTimePicked,
                          onTap: onTap,
                        );
                      }
                    },
                  ),
                ),
          //List PM//
          listPM.isEmpty
              ? const SizedBox()
              : Wrap(
                  // direction: Axis.horizontal,
                  children: List.generate(
                    listPM.length,
                    (index) {
                      //TODO first item
                      if (index == 0) {
                        return Column(
                          children: [
                            BuildTimeItem(
                              list: listPM,
                              index: index,
                              idTimePicked: idTimePicked,
                              onTap: onTap,
                            ),
                          ],
                        );
                      }
                      //TODO last item
                      else if (index == listPM.length - 1) {
                        return Column(
                          children: [
                            BuildTimeItem(
                              list: listPM,
                              index: index,
                              idTimePicked: idTimePicked,
                              onTap: onTap,
                              specialLastItem: true,
                            ),
                          ],
                        );
                      }
                      //TODO nomal item
                      else {
                        return Column(
                          children: [
                            BuildTimeItem(
                              list: listPM,
                              index: index,
                              idTimePicked: idTimePicked,
                              onTap: onTap,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
