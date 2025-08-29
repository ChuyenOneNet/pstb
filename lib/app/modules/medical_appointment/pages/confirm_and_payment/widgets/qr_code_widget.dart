import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/utils/main.dart';

class QrCodeWidget extends StatelessWidget {
  const QrCodeWidget(
      {Key? key, this.methodPayment, this.typePayment, this.imageQr})
      : super(key: key);
  final String? methodPayment;
  final String? typePayment;
  final Uint8List? imageQr;
  @override
  Widget build(BuildContext context) {
    if (imageQr != null && imageQr!.isNotEmpty) {
      return Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          IconEnums.qrCode1,
                          color: AppColors.black,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Mã Qr',
                          style: Styles.titleItem.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
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
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Image.memory(
                      imageQr!,
                      errorBuilder: (_, __, ___) {
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
              )
            ],
          ));
    } else {
      return const SizedBox();
    }
  }
}
