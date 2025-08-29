import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/doctor_info/models/doctor_attr_group_model.dart';
import 'package:pstb/app/modules/medical_appointment/pages/doctor_info/widgets/doctor_attrs_group.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package/medical_package_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package_detail/models/medical_model.dart';
import 'package:pstb/utils/format_util.dart';
import 'package:pstb/utils/hex_color.dart';
import 'package:pstb/widgets/stateless/new_package_items/package_name.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/divider_custom_widget.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import '../../../../user_app_store.dart';
import 'doctor_info_store.dart';
import 'widgets/canvar_header.dart';

class DoctorInfoPage extends StatefulWidget {
  final int id;

  const DoctorInfoPage({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DoctorInfoPageState();
  }
}

class DoctorInfoPageState
    extends ModularState<DoctorInfoPage, DoctorInfoStore> {
  final MedicalAppointmentStore _medicalAppointmentStore =
      Modular.get<MedicalAppointmentStore>();
  final MedicalPackageStore medicalPackageStore =
      Modular.get<MedicalPackageStore>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();

  final Map<int, String> _iconByType = {
    1: IconEnums.doctorCertificate,
    2: IconEnums.doctorExp,
  };

  final Map<int, String> _titleByType = {
    1: 'Học vấn',
    2: 'Kinh nghiệm',
  };

  @override
  void initState() {
    getDetailDoctor();
    controller.setDoctor(_medicalAppointmentStore.doctorDetail!);
    _medicalAppointmentStore.setConsultation(false);
    medicalPackageStore.setOtherPackage(false);
    super.initState();
  }

  Future<void> getDetailDoctor() async {
    await controller.onGetDoctor(widget.id.toString());
    await controller.getMedicalService(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Observer(builder: (context) {
      return Scaffold(
          appBar: CustomAppBar(
            title: 'Thông tin chi tiết',
            isBack: true,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildDoctorInfo(size),
                  _buildButtonContinue(),
                ],
              ),
            ),
          ));
    });
  }

  // TODO giới thiệu
  Widget _buildDoctorIntro() {
    var des = controller.doctorData.description;
    if (des == null || des == "") {
      return const SizedBox();
    }
    var model =
        DoctorAttributeGroupViewModel(IconEnums.doctorIntro, 'Giới thiệu');
    model.addDescription(controller.doctorData.description ?? '');
    return DoctorAttributeGroupWidget(model: model);
  }

  //TODO học vấn
  Widget _buildDoctorAttrs() {
    var attrs = controller.doctorData.attrs;
    if (attrs == null) {
      return const SizedBox();
    }
    var groupAttrs = <int, DoctorAttributeGroupViewModel>{};
    for (var element in attrs) {
      if (element.type == null) continue;
      if (element.description == null || element.description == '')
        return const SizedBox();
      if (!groupAttrs.containsKey(element.type)) {
        groupAttrs[element.type!] = DoctorAttributeGroupViewModel(
            _iconByType[element.type]!, _titleByType[element.type]!);
      }
      groupAttrs[element.type]!.addDescription(element.description ?? '');
    }
    var groupModels = groupAttrs.entries.map((entry) => entry.value).toList();
    return Column(
        children: List.generate(groupModels.length, (index) {
      return DoctorAttributeGroupWidget(
          model: groupModels[index], showDotPoint: true);
    }));
  }

  //TODO medical service
  Widget _buildMedicalService() {
    if (controller.packagesList.isEmpty) return const SizedBox();
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: Styles.cardShadow.copyWith(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: HexColor('1565C0'),
                      borderRadius: BorderRadius.circular(4.0)),
                  child: SvgPicture.asset(
                    IconEnums.medicalFolder1,
                    color: AppColors.background,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('Gói dịch vu',
                    style: Styles.titleItem.copyWith(
                      color: AppColors.black,
                    )),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView.builder(
                // controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: controller.packagesList.length,
                itemBuilder: (_, index) {
                  return itemService(controller.packagesList[index]);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDoctorInfo(Size size) {
    final maxHeightImage = heightConvert(context, 220);
    final doctorData = controller.doctorData;
    return Column(
      children: [
        doctorData.image != null
            ? SafeArea(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  child: CachedNetworkImage(
                    imageUrl: doctorData.image ?? '',
                    memCacheWidth: 150,
                    memCacheHeight: 150,
                    placeholder: (context, url) {
                      return const CircularProgressIndicator();
                    },
                    errorWidget: (context, url, error) => Image.asset(
                      ImageEnum.avatarDefault,
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
              )
            : SizedBox(
                height: maxHeightImage,
              ),
        _buildBasicInfo(size, doctorData.name, doctorData.position),
        _buildDoctorIntro(),
        const SizedBox(
          height: 16.0,
        ),
        _buildDoctorAttrs(),
        const SizedBox(
          height: 16.0,
        ),
        _buildMedicalService()
      ],
    );
  }

  Widget _buildBasicInfo(Size size, String? doctorName, String? position) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: Styles.cardShadow.copyWith(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'BS.${doctorName?.toUpperCase() ?? ''}',
              style: Styles.titleItem,
            ),
          ),
          const Divider(color: AppColors.lightSilver),
          Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    position?.toUpperCase() ?? '',
                    style: Styles.content,
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget buildShape() {
    return ClipPath(
      clipper: CustomShapeClass(),
      child: Container(
        color: AppColors.neutral250,
      ),
    );
  }

  Widget _buildButtonContinue() {
    return _userAppStore.visibleSelectDoctor == true
        ? Row(
            children: [
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                  child: AppButton(
                    labelStyle:
                        Styles.heading4.copyWith(color: AppColors.background),
                    title: 'Tiếp tục',
                    onPressed: () {
                      Modular.to.pushNamed(AppRoutes.medicalTimeVisitDoctor,
                          arguments: {"doctorId": widget.id, "booking": null});
                    },
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          )
        : const SizedBox();
  }

  Widget itemService(PackageModel data) {
    return InkWell(
      onTap: () async {
        _medicalAppointmentStore.setPackageDetail(data);
        _medicalAppointmentStore.addPackageToShowed(data);
        bool examAtHome = data.examAtHome ?? false;
        bool testAtHome = data.testAtHome ?? false;
        _medicalAppointmentStore.setExamAtHome(examAtHome);
        _medicalAppointmentStore.setTestAtHome(testAtHome);
        medicalPackageStore.navigateTo(AppRoutes.medicalPackageDetail);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: AspectRatio(
                aspectRatio: 1.2,
                child: PackagePicture(
                  imageUri: data.image,
                  iconUri: data.icon,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: PackageName(
                name: data.name ?? "",
                description:
                    data.description ?? l10n(context)!.medical_description,
                sale: data.disCount,
                price: FormatUtil.formatMoney(data.price),
                onClickDetailBtn: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
