import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/app_input.dart';

class DescriptionPaperWidget extends StatefulWidget {
  const DescriptionPaperWidget({
    Key? key,
    this.onChanged,
    this.onPickImage,
    this.imagePicker,
    this.onPhotoView,
    this.onDeletePhoto,
    required this.controller,
    required this.nameEditingController,
  }) : super(key: key);
  final Function(String)? onChanged;
  final Function()? onPickImage;
  final String? imagePicker;
  final Function()? onPhotoView;
  final Function()? onDeletePhoto;
  final TextEditingController nameEditingController;
  final TextEditingController controller;

  @override
  State<DescriptionPaperWidget> createState() => _DescriptionPaperWidgetState();
}

class _DescriptionPaperWidgetState extends State<DescriptionPaperWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: (widget.imagePicker != null &&
                        widget.imagePicker!.isNotEmpty)
                    ? Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: InkWell(
                              onTap: widget.onPhotoView,
                              child: Image.file(
                                File(widget.imagePicker!),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: widget.onDeletePhoto,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent.withOpacity(0.3),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(12)),
                                ),
                                height: 24,
                                width: 24,
                                child: const Center(
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ],
                      )
                    : InkWell(
                        onTap: widget.onPickImage,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.lightSilver,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const CircleAvatar(
                                  backgroundColor: AppColors.primary,
                                  child: Icon(
                                    Icons.attach_file,
                                    color: AppColors.background,
                                  )),
                              Text(
                                'Tài liệu',
                                style: Styles.subtitleSmallest,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 2,
                child: AppInput(
                  styleField: Styles.subtitleSmallest,
                  controller: widget.nameEditingController,
                  contentPadding: const EdgeInsets.all(16),
                  maxLine: 2,
                  isDisable: true,
                  hintText: 'Tên giấy tờ*',
                  fillColor: AppColors.surfaceLight,
                  hintStyle: Styles.subtitleSmallest.copyWith(
                    color: AppColors.lightSilver,
                  ),
                ),
              ),
            ],
          ),
          AppInput(
            controller: widget.controller,
            styleField: Styles.subtitleSmallest,
            contentPadding: const EdgeInsets.all(16),
            maxLine: 10,
            hintText: l10n(context).description_paper + '*',
            hintStyle: Styles.subtitleSmallest.copyWith(
              color: AppColors.lightSilver,
            ),
            fillColor: AppColors.surfaceLight,
            onChangeValue: widget.onChanged,
            // iconRight: IconEnums.camera,
            colorRightIcon: AppColors.primary,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Không được để trống';
              }
              return null;
            },
            sizeIconRight: 24,
            onTapIconRight: widget.onPickImage,
          ),
        ],
      ),
    );
  }
}
