import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/utils/main.dart';
import '../models/new_medical_package_details_model.dart';

class PackageMedicalDetails extends StatefulWidget {
  final NewMedicalPackageDetailModel packageDetailModel;

  // final int packageId;

  const PackageMedicalDetails({Key? key, required this.packageDetailModel})
      : super(key: key);

  @override
  State<PackageMedicalDetails> createState() => _PackageMedicalDetailsState();
}

class _PackageMedicalDetailsState extends State<PackageMedicalDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.packageDetailModel.disCount != null &&
            widget.packageDetailModel.disCount! > 0
        ? _buildWithDiscount()
        : _buildWithNoDiscount();
  }

  Padding _buildWithDiscount() {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.packageDetailModel.description == null ||
                  widget.packageDetailModel.description!.isEmpty)
              ? const SizedBox()
              : Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Text(
                    widget.packageDetailModel.description ?? '',
                    style: Styles.content,
                  ),
                ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Text(
              'Chi tiết gói',
              textAlign: TextAlign.start,
              style: Styles.titleItem,
            ),
          ),
          widget.packageDetailModel.services!.isNotEmpty
              ? Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.packageDetailModel.services!
                        .map((e) => Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.black,
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      height: 4,
                                      width: 4,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      e.name,
                                      style: Styles.content,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                )
              : const SizedBox(),
          Column(
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Text(
                  'Lưu ý',
                  textAlign: TextAlign.start,
                  style: Styles.titleItem,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(2)),
                        height: 4,
                        width: 4,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Nhịn đói trước khi lấy mẫu ít nhất là 6-8 tiếng, chỉ được uống nước lọc',
                        style: Styles.content,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(2)),
                        height: 4,
                        width: 4,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Không ăn sáng, không uống nước ngọt, nước hoa quả, sữa, rượu... để đảm bảo kết quả chính xác',
                        style: Styles.content,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(2)),
                        height: 4,
                        width: 4,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Với trường hợp đã chuẩn bị sẵn, trước khi siêu âm ổ bụng, bệnh nhân nên nhịn ăn ít nhất 6-8 giờ. Nên siêu âm vào buổi sáng.',
                        style: Styles.content,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Text(
              'Hướng dẫn sử dụng dịch vụ',
              textAlign: TextAlign.start,
              style: Styles.titleItem,
            ),
          ),
          InkWell(
            onTap: () {
              Fluttertoast.showToast(msg: 'Chức năng đang phát triển');
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Text(
                'Xem tại đây!',
                textAlign: TextAlign.start,
                style: Styles.content.copyWith(
                    decoration: TextDecoration.underline,
                    color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildWithNoDiscount() {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.packageDetailModel.description == null ||
                  widget.packageDetailModel.description!.isEmpty)
              ? const SizedBox()
              : Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Text(
                    widget.packageDetailModel.description ?? '',
                    style: Styles.content,
                  ),
                ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Text(
              'Chi tiết gói',
              textAlign: TextAlign.start,
              style: Styles.titleItem,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.packageDetailModel.services!
                  .map((e) => Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.black,
                                    borderRadius: BorderRadius.circular(2)),
                                height: 4,
                                width: 4,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                e.name,
                                style: Styles.content,
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          Column(
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Text(
                  'Lưu ý',
                  textAlign: TextAlign.start,
                  style: Styles.titleItem,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(2)),
                        height: 4,
                        width: 4,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Nhịn đói trước khi lấy mẫu ít nhất là 6-8 tiếng, chỉ được uống nước lọc',
                        style: Styles.content,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(2)),
                        height: 4,
                        width: 4,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Không ăn sáng, không uống nước ngọt, nước hoa quả, sữa, rượu... để đảm bảo kết quả chính xác',
                        style: Styles.content,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(2)),
                        height: 4,
                        width: 4,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Với trường hợp đã chuẩn bị sẵn, trước khi siêu âm ổ bụng, bệnh nhân nên nhịn ăn ít nhất 6-8 giờ. Nên siêu âm vào buổi sáng.',
                        style: Styles.content,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Text(
              'Hướng dẫn sử dụng dịch vụ',
              textAlign: TextAlign.start,
              style: Styles.titleItem,
            ),
          ),
          InkWell(
            onTap: () {
              Fluttertoast.showToast(msg: 'Chức năng đang phát triển');
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Text(
                'Xem tại đây!',
                textAlign: TextAlign.start,
                style: Styles.content.copyWith(
                    decoration: TextDecoration.underline,
                    color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
