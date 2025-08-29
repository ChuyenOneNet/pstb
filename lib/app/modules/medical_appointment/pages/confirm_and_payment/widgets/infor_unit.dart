import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/icons.dart';
import 'package:pstb/utils/images.dart';
import 'package:pstb/utils/styles.dart';

class InformationUnit extends StatelessWidget {
  InformationUnit({Key? key, this.imageQr, this.status, this.confirm})
      : super(key: key);
  final Uint8List? imageQr;
  final String? status;
  final String? confirm;

  final HomeStore homeStore = Modular.get<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: Styles.cardShadow.copyWith(
          color: AppColors.background, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(
                  homeStore.avatarUnit ?? '',
                  errorBuilder: (_, __, ___) {
                    return Center(
                      child: Image.asset(ImageEnum.hospitalDefault),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 4.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      homeStore.nameUnit ?? 'Bệnh Viện Phụ Sản Thái Bình',
                      style: Styles.titleItem,
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on),
                        Flexible(
                          child: Text(
                            homeStore.addressUnit ??
                                "Số 18 Phú Doãn, Hàng Bông, Hoàn Kiếm, Hà Nội",
                            style: Styles.content
                                .copyWith(color: AppColors.black, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (imageQr != null)
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => Dialog(
                          child: Image.memory(
                            imageQr!,
                            errorBuilder: (_, __, ___) {
                              return const SizedBox();
                            },
                          ),
                        ));
              },
              child: Image.memory(
                imageQr!,
                width: 120,
                height: 120,
                errorBuilder: (_, __, ___) {
                  return const SizedBox();
                },
              ),
            ),
          if (status != null)
            Container(
              width: 120,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: AppColors.primary),
              child: Text(
                status ?? 'Sẵn Sàng',
                style: Styles.content.copyWith(color: AppColors.background),
              ),
            ),
          if (confirm != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(4.0),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: AppColors.greenText,
                        borderRadius: BorderRadius.circular(15)),
                    child: SvgPicture.asset(
                      IconEnums.check,
                      color: Colors.white,
                    )),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  confirm ?? '',
                  style: Styles.content.copyWith(color: AppColors.primary),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
