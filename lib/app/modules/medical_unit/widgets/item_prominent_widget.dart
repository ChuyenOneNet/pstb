import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/medical_unit/selection_hospital_store.dart';
import 'package:pstb/utils/routes.dart';
import '../../../../utils/images.dart';
import '../../../../utils/styles.dart';
import '../../../app_store.dart';
import '../../../models/medical_unit/hospital_unit_model.dart';

class ItemProminent extends StatelessWidget {
  const ItemProminent({Key? key, required this.item, required this.store})
      : super(key: key);

  final HospitalModel item;
  final SelectionHospitalStore store;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final AppStore _appStore = Modular.get<AppStore>();
        await _appStore.getLandingUnit(item.id!);
        Modular.to.pushNamed(AppRoutes.detailHospitalPage, arguments: {
          "hospitalModel": item,
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: item.image ?? '',
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Center(child: CircularProgressIndicator())),
                    ),
                    errorWidget: (context, url, error) => SizedBox(
                      width: 80,
                      height: 80,
                      child: Center(
                        child: Image.asset(ImageEnum.hospitalDefault),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.shortName ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: Styles.titleItem,
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
