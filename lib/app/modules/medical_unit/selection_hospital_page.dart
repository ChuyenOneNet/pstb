import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/medical_unit/selection_hospital_store.dart';
import 'package:pstb/app/modules/medical_unit/widgets/item_hospital_widget.dart';
import 'package:pstb/app/modules/medical_unit/widgets/unit_prominent_widget.dart';
import 'package:pstb/utils/main.dart';
import '../../../utils/colors.dart';
import '../../../utils/helper.dart';
import '../../../utils/routes.dart';
import '../../../widgets/stateless/app_bar.dart';
import '../auth_guard/auth_guard_page.dart';

class SelectionHospitalPage extends StatefulWidget {
  const SelectionHospitalPage({Key? key}) : super(key: key);

  @override
  State<SelectionHospitalPage> createState() => _SelectionHospitalPageState();
}

class _SelectionHospitalPageState extends State<SelectionHospitalPage> {
  final SelectionHospitalStore selectionHospitalStore =
      Modular.get<SelectionHospitalStore>();

  @override
  void initState() {
    // TODO: implement initState
    getHospital();
    getUnitProminents();
    selectionHospitalStore.changeNews(0);
    super.initState();
  }

  Future<void> getHospital() async {
    // await selectionHospitalStore.initState();
    await selectionHospitalStore.getHospitals(true);
    await selectionHospitalStore.checkUnitChoose();
  }

  Future<void> getUnitProminents() async {
    await selectionHospitalStore.getUnitProminent();
    await selectionHospitalStore.checkUnitChoose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Observer(builder: (context) {
          return RefreshIndicator(
            onRefresh: () async {
              await selectionHospitalStore.getHospitals(true);
              await selectionHospitalStore.checkUnitChoose();
              await selectionHospitalStore.getUnitProminent();
            },
            child: selectionHospitalStore.listHospital.isNotEmpty
                // them SingleChildCrollView vao column
                ? Column(
                    children: [
                      // const UnitProminentWidget(),
                      // const SizedBox(height: 15,),
                      Text(
                        'Danh sách cơ sở y tế',
                        style: Styles.titleItem,
                      ),
                      // bo expanded và mo comment cua gridview.builder
                      Expanded(
                        child: GridView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          // shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: widthConvert(context, 16),
                              vertical: heightConvert(context, 24)),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 0.9),
                          itemCount: selectionHospitalStore.listHospital.length,
                          itemBuilder: (_, index) {
                            final hospital =
                                selectionHospitalStore.listHospital[index];
                            return ItemHospitalWidget(
                              hospitalModel: hospital,
                              store: selectionHospitalStore,
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      'Không có dữ liệu!',
                      style: Styles.content,
                    ),
                  ),
          );
        }),
      ),
    );
  }
}
