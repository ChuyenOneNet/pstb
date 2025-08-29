import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/utils/format_util.dart';
import 'package:pstb/utils/main.dart';
import '../../../app/modules/medical_appointment/pages/medical_package/medical_package_store.dart';

class PackageName extends StatelessWidget {
  final MedicalPackageStore controller = Modular.get<MedicalPackageStore>();

  PackageName(
      {Key? key,
      this.name = '',
      this.description = '',
      this.price = '',
      this.sale,
      required this.onClickDetailBtn})
      : super(key: key);
  final String name;
  final String description;
  final int? sale;
  final String? price;
  final Function onClickDetailBtn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Styles.titleItem),
            const SizedBox(
              height: 4,
            ),
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Styles.content,
            ),
            const SizedBox(
              height: 4,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 24,
                              height: 24,
                              child: SvgPicture.asset(
                                // IconEnums.iconPrice,
                                IconEnums.iconPriceMedical,
                                color: AppColors.primary,
                              )),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: price != null && price!.isNotEmpty
                                ? Text(
                                    price! + " vnđ",
                                    style: Styles.content,
                                  )
                                : Text(
                                    " 0 vnđ",
                                    style: Styles.content,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 24,
                              height: 24,
                              child: SvgPicture.asset(
                                IconEnums.iconGift,
                                // IconEnums.iconVoucher,
                                color: Colors.amber,
                              )),
                          Expanded(
                            child: sale != null
                                ? Text(
                                    " ${FormatUtil.formatMoney(sale)} vnđ",
                                    softWrap: true,
                                    style: Styles.content,
                                  )
                                : Text(
                                    " 0 vnđ",
                                    style: Styles.content,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
