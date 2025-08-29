import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/home/widgets/section_title.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/select_doctor/models/doctor_model.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/hex_color.dart';
import 'package:pstb/utils/main.dart';

class ProminentDoctorWidget extends StatefulWidget {
  const ProminentDoctorWidget({Key? key}) : super(key: key);

  @override
  State<ProminentDoctorWidget> createState() => _ProminentDoctorWidgetState();
}

class _ProminentDoctorWidgetState extends State<ProminentDoctorWidget> {
  final HomeStore store = Modular.get<HomeStore>();
  final MedicalAppointmentStore _medicalAppointmentStore =
      Modular.get<MedicalAppointmentStore>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (store.listProminentDoctor.isNotEmpty) {
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
              child: SectionTitle(
                fontWeight: FontWeight.w900,
                title: 'Bác sĩ nổi bật',
                // color: AppColors.background,
              ),
            ),
            Container(
                padding: const EdgeInsets.only(bottom: 16.0),
                width: MediaQuery.of(context).size.width,
                height: 140,
                child: CardSwiper(
                  cardBuilder: (context, index, item, additionalParam) {
                    final item = store.listProminentDoctor[index];
                    return InkWell(
                      onTap: () {
                        _medicalAppointmentStore.chooseDoctor(item);
                        if (item.id == null) return;
                        Modular.to.pushNamed(AppRoutes.doctorInfo,
                            arguments: item.id!);
                        print('doctorId ${item.id}');
                        _userAppStore.setVisibleSelectDoctor(false);
                      },
                      child: itemProminetDoctor(
                          item), // Ensure this returns a valid widget
                    );
                  },
                  cardsCount: store.listProminentDoctor.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  scale: 0.9,
                )),
          ],
        );
      } else {
        return const SizedBox();
      }
    });
  }

  Widget itemProminetDoctor(DoctorPagingItem item) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
            colors: [
              HexColor('0061ff'),
              HexColor('0061ff'),
              HexColor('60efff'),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 0.5, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(item.image ?? ""),
            maxRadius: 32,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'PGS.TS',
              //   style: Styles.titleItem.copyWith(color: Colors.white),
              // ),
              Text(
                item.name ?? 'Phạm Thị Bích Đào',
                style: Styles.titleItem.copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                item.position ?? 'Chuyên khoa Tai Mũi Họng',
                style: Styles.content.copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
