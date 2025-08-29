import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/home/widgets/category/detail_package_group/detail_package_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package/medical_package_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package_detail/models/medical_model.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import '../../../../../../utils/format_util.dart';
import '../../../../../../widgets/stateless/new_package_items/package_name.dart';
import '../../../../../../widgets/stateless/new_package_items/package_picture.dart';
import '../../../medical_appointment_store.dart';

class OtherPackage extends StatefulWidget {
  const OtherPackage({Key? key,}) : super(key: key);

  @override
  State<OtherPackage> createState() => _OtherPackageState();
}

class _OtherPackageState extends State<OtherPackage> {
  final MedicalAppointmentStore _appointmentStore =
      Modular.get<MedicalAppointmentStore>();
  final MedicalPackageStore controller = Modular.get<MedicalPackageStore>();
  final DetailPackageStore detailPackageStore = Modular.get<DetailPackageStore>();

  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    // _appointmentStore.setConsultation(false);
    // _appointmentStore.getPackages();
    // _scrollController.addListener(() {
    //   // print(_scrollController.offset);
    //   // print(_scrollController.position.maxScrollExtent);
    //   if (_scrollController.offset >=
    //       _scrollController.position.maxScrollExtent - 100) {
    //     if (_appointmentStore.loadingPackage) return;
    //     _appointmentStore.getPackages();
    //   }
    // });
    _scrollController = ScrollController()..addListener(_loadMoreItems);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.removeListener(_loadMoreItems);
    super.dispose();
  }

  Future<void> _loadMoreItems() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await controller.loadMoreOtherPackage();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Observer(builder: (_) {
      if (controller.otherPackage) {
        if (controller.packageGroup) {
          return otherPackage(detailPackageStore.otherListPackage);
        } else {
          return otherPackage(controller.otherPackagesList);
        }
      } else {
        return const SizedBox();
      }
    });
  }

  Widget otherPackage(List<PackageModel> listPackage) {
    Size size = MediaQuery.of(context).size;
    return listPackage.isNotEmpty ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, left: 16),
          child: Text(
            'Dịch vụ khác',
            style: Styles.titleItem,
          ),
        ),
        SizedBox(
            height: 130,
            child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: listPackage.length,
                itemBuilder: (context, index) {
                  PackageModel item = listPackage[index];
                  return TouchableOpacity(
                    onTap: () {
                      _appointmentStore.addPackageToShowed(item);
                      _appointmentStore.setPackageDetail(item);
                      Modular.to.popAndPushNamed(
                        AppRoutes.medicalPackageDetail,
                      );
                    },
                    child: Container(
                      margin:
                      const EdgeInsets.only(bottom: 4, left: 8, top: 4),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.lightSilver)
                          ),
                      width: size.width - 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 1,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: PackagePicture(
                                memCacheWidth: 444,
                                memCacheHeight: 376,
                                imageUri: item.image ?? '',
                                width: heightConvert(context, 130),
                                // height: heightConvert(context, 110),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: PackageName(
                              name: item.name ?? "",
                              description: item.description ??
                                  l10n(context)!.medical_description,
                              sale: item.disCount,
                              price: FormatUtil.formatMoney(item.price),
                              onClickDetailBtn: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                })),
      ],
    ) : const SizedBox();
  }
}
