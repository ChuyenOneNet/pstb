import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/medical_unit/search_hospital/widget/hospital_item_search.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/routes.dart';
import '../../../../utils/styles.dart';
import '../../../app_store.dart';
import '../../../user_app_store.dart';
import '../selection_hospital_store.dart';
import 'autocomplete_basic_hospital.dart';

class SearchHospitalPage extends StatelessWidget {
  SearchHospitalPage({Key? key}) : super(key: key);

  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  final SelectionHospitalStore selectionHospitalStore = Modular.get<SelectionHospitalStore>();
  final AppStore appStore = Modular.get<AppStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Modular.to.pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    AutocompleteBasicHospital(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Tìm kiếm gần nhất',
                    style: Styles.titleItem,
                  ),
                ),
              ),
              Observer(builder: (context) {
                return _userAppStore.hospital.name == null ||
                    _userAppStore.hospital.name == ''
                    ? SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Bạn chưa tìm kiếm gần đây.',
                      style: Styles.content,
                    ),
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: InkWell(
                    onTap: () {
                      Modular.to.pushNamed(AppRoutes.detailHospitalPage, arguments: {
                        "hospitalModel": _userAppStore.hospital,
                      });
                    },
                    child: HospitalItemSearch(hospitalModel: _userAppStore.hospital),
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Gợi ý cho bạn',
                    style: Styles.titleItem,
                  ),
                ),
              ),
              if (selectionHospitalStore.listHospital.length >=2)
                Observer(
                  builder: (context) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            final hospital =
                            selectionHospitalStore.listHospital[index];
                            return InkWell(
                              onTap: () {
                                Modular.to.pushNamed(AppRoutes.detailHospitalPage, arguments: {
                                  "hospitalModel": hospital,
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: HospitalItemSearch(hospitalModel: hospital),
                              ),
                            );
                          },
                          itemCount: 2,
                          physics: const ClampingScrollPhysics(),
                        ),
                      ),
                    );
                  }
              ) else const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
