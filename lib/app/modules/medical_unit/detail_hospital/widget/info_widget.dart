import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/images.dart';
import '../../../../../utils/styles.dart';
import '../detail_hospital_store.dart';

class InfoWidget extends StatelessWidget {
  final DetailHospitalStore store;
  const InfoWidget({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                store.detailHospital.image ?? '',
                errorBuilder: (_, __, ___) {
                  return Center(
                    child: Image.asset(ImageEnum.hospitalDefault),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xfff6f6f6),
              ),
              padding: const EdgeInsets.symmetric(vertical: 24),
              // height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Column(
                          children: const [
                            Icon(Icons.remove_red_eye_outlined,
                                color: Colors.grey),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Column(
                          children: [
                            Text('Lượt Khám',
                                style: Styles.content,),
                            Text(
                                '${store.detailHospital.numberExamination}',
                                style: Styles.content),
                          ],
                        )
                      ],
                    ),
                  ),
                  IntrinsicHeight(
                    child: InkWell(
                      onTap: () {
                        showGeneralDialog(
                          barrierLabel: "Label",
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionDuration:
                          const Duration(milliseconds: 700),
                          context: context,
                          pageBuilder: (context, anim1, anim2) {
                            return Container();
                            // return globalController.userLogin.value
                            //     ? const VoteDialogPage()
                            //     : requireLoginWidget();
                          },
                          transitionBuilder: (context, anim1, anim2, child) {
                            return SlideTransition(
                              position: Tween(
                                  begin: const Offset(0, 1),
                                  end: const Offset(0, 0))
                                  .animate(anim1),
                              child: child,
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Column(
                            children: const [
                              Icon(Icons.star_outline, color: Colors.grey),
                            ],
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                            },
                            child: Column(
                              children: [
                                Text('Đánh giá',
                                    style: Styles.content),
                                Text(
                                    '${store.detailHospital.rating}',
                                    style: Styles.content),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class NetWorkImageApp extends StatelessWidget {
  final String urlImage;

  const NetWorkImageApp({Key? key, required this.urlImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: urlImage,
      fit: BoxFit.cover,
      placeholder: (context, url) => const Center(
        child:
            SizedBox(width: 30, height: 30, child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => const SizedBox(),
    );
  }
}
