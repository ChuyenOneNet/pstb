import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/models/medical_unit/user_review_model.dart';
import 'package:pstb/app/modules/medical_unit/detail_hospital/detail_hospital_store.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/images.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/widgets/stateless/button_back.dart';

import '../../../../utils/constants.dart';

class AllReviewUnit extends StatefulWidget {
  AllReviewUnit({Key? key}) : super(key: key);

  @override
  State<AllReviewUnit> createState() => _AllReviewUnitState();
}

class _AllReviewUnitState extends State<AllReviewUnit>
    with TickerProviderStateMixin {
  final DetailHospitalStore detailHospitalStore =
      Modular.get<DetailHospitalStore>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_loadMoreReview);
    // TODO: implement initState
    super.initState();
  }

  Future<void> _loadMoreReview() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print('hai');
      await detailHospitalStore
          .loadMoreItem(detailHospitalStore.detailHospital.id!);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreReview);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.network(
                            detailHospitalStore.detailHospital.image ?? '',
                            errorBuilder: (_, __, ___) {
                              return Center(
                                child: Image.asset(ImageEnum.hospitalDefault),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                detailHospitalStore.detailHospital.name ??
                                    'Bệnh Viện Phụ Sản Thái Bình',
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
                                      detailHospitalStore
                                              .detailHospital.address ??
                                          "Số 18 Phú Doãn, Hàng Bông, Hoàn Kiếm, Hà Nội",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Styles.content.copyWith(
                                          color: AppColors.black, fontSize: 11),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  if (detailHospitalStore.listReviewHospital.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            detailHospitalStore.listReviewHospital.length,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return itemReview(
                              detailHospitalStore.listReviewHospital[index]);
                        },
                      ),
                    )
                  else
                    Center(
                      child: Text(
                        'Không có nhận xét nào.',
                        style: Styles.content,
                      ),
                    ),
                ],
              ),
            ),
            const ButtonBackWidget(),
          ],
        ),
      ),
    );
  }

  Widget itemReview(UserReviewModel reviewModel) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightSilver),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  reviewModel.fullName ?? 'UserName',
                  style: Styles.titleItem,
                ),
                reviewModel.reviewedTime == null
                    ? Text(
                        '27/03/2023',
                        style: Styles.content,
                      )
                    : Text(
                        DateFormat(DateTimeFormatPattern.dobddMMyyyy)
                            .format(reviewModel.reviewedTime!.toLocal()),
                        style: Styles.content,
                      )
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                RatingBarIndicator(
                  rating: reviewModel.rate == null
                      ? 5
                      : double.parse(reviewModel.rate.toString()),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Text(
                  reviewModel.review ?? 'Bệnh viện rất tốt',
                  style: Styles.content,
                ),
              ],
            )
          ],
        ));
  }
}
