import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/community/question_page/question_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

import '../../../user_app_store.dart';
import '../community_page_store.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends ModularState<QuestionPage, QuestionStore> {
  final _key = GlobalKey<FormState>();
  final _userAppStore = Modular.get<UserAppStore>();
  final communityPageStore = Modular.get<CommunityPageStore>();

  @override
  void initState() {
    controller.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (controller.state == QuestionState.error) {
        AppSnackBar.show(context, AppSnackBarType.Error, 'Lỗi dữ liệu');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: l10n(context).set_up_question,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (!_key.currentState!.validate()) {
              return;
            }
            await controller.createQuestion();
            if (!controller.isActiveButton) {
              AppSnackBar.show(context, AppSnackBarType.Error,
                  l10n(context).fill_information);
              return;
            }
            // Modular.to.pop();
            if (controller.state == QuestionState.success) {
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: Offset(0.0, 10.0),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          // To make the card compact
                          children: <Widget>[
                            Row(
                              children: [
                                Image.asset('assets/images/accept_icon.png',
                                    height: 60),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  "Gửi câu hỏi thành công",
                                  style: Styles.titleItem,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              "Câu hỏi của bạn sẽ được chuyển tới bác sĩ và trả lời trong thời gian sớm nhât",
                              style: Styles.content,
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              'Lưu ý: Câu hỏi có thể từ chối trả lời vì một số lý do '
                              '(Thiếu thông tin, câu hỏi spam không liên quan đến sức khoẻ).',
                              style: Styles.content,
                            ),
                            const SizedBox(height: 24.0),
                            Row(
                              children: [
                                const Spacer(),
                                Expanded(
                                  child: AppButton(
                                    title: 'Đồng ý',
                                    onPressed: () async {
                                      await communityPageStore
                                          .getListQuestion();
                                      Modular.to.pop();
                                      Modular.to.popAndPushNamed(
                                          AppRoutes.myQuestion);
                                    },
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              });
              return;
            }
            SchedulerBinding.instance.addPostFrameCallback(
              (timeStamp) {
                AppSnackBar.show(
                    context, AppSnackBarType.Error, l10n(context).update_error);
              },
            );
          },
          child: const Icon(Icons.send),
          backgroundColor: AppColors.primary,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chủ đề',
                    style: Styles.titleItem,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Observer(builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          border: Border.all(color: AppColors.lightSilver)),
                      child: DropdownButton<String>(
                          value: controller.categoryDiseaseModel.name,
                          isExpanded: true,
                          underline: const SizedBox.shrink(),
                          items: controller.category
                              .map((element) => element.name ?? '')
                              .toList()
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: Text(
                            l10n(context).get_group,
                            style: Styles.content
                                .copyWith(color: AppColors.grayLight),
                          ),
                          onChanged: controller.onChangedGroup),
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Nội dung',
                    style: Styles.titleItem,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.lightSilver),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Hãy nhập nội dung cần giải đáp';
                        }
                        return null;
                      },
                      maxLines: 15,
                      onChanged: controller.onChangedQuestion,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '- Triệu chứng gặp phải, thời gian bao lâu?' +
                            '\n' +
                            '- Đã thăm khám hoặc điều trị ở đâu?' +
                            '\n' +
                            '- Đã dùng thuôc gì',
                        hintStyle:
                            Styles.content.copyWith(color: AppColors.grayLight),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Ghi chú:',
                    style: Styles.titleItem,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    '+ Vui lòng viết tiếng việt có dấu.',
                    style: Styles.content,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    '+ Hãy mô tả kỹ các triệu chứng của bạn (đã bị trong bao lâu, đã dùng thuốc gì...)',
                    style: Styles.content,
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  // Expanded(
                  //   child: Row(
                  //     children: [
                  //       const Spacer(),
                  //       Expanded(
                  //         child: AppButton(
                  //           title: 'Gửi câu hỏi',
                  //           onPressed: () async {
                  //             if (!_key.currentState!.validate()) {
                  //               return;
                  //             }
                  //             await controller.createQuestion();
                  //             if (!controller.isActiveButton) {
                  //               AppSnackBar.show(context, AppSnackBarType.Error,
                  //                   l10n(context).fill_information);
                  //               return;
                  //             }
                  //             // Modular.to.pop();
                  //             if (controller.state == QuestionState.success) {
                  //               SchedulerBinding.instance
                  //                   .addPostFrameCallback((timeStamp) {
                  //                 showDialog<void>(
                  //                   context: context,
                  //                   builder: (BuildContext context) {
                  //                     return Dialog(
                  //                       shape: RoundedRectangleBorder(
                  //                         borderRadius: BorderRadius.circular(10),
                  //                       ),
                  //                       elevation: 0.0,
                  //                       backgroundColor: Colors.transparent,
                  //                       child: Container(
                  //                         padding: const EdgeInsets.all(16.0),
                  //                         decoration: BoxDecoration(
                  //                           color: Colors.white,
                  //                           shape: BoxShape.rectangle,
                  //                           borderRadius: BorderRadius.circular(10),
                  //                           boxShadow: const [
                  //                             BoxShadow(
                  //                               color: Colors.black26,
                  //                               blurRadius: 10.0,
                  //                               offset: Offset(0.0, 10.0),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         child: Column(
                  //                           mainAxisSize: MainAxisSize.min,
                  //                           // To make the card compact
                  //                           children: <Widget>[
                  //                             Row(
                  //                               children: [
                  //                                 Image.asset('assets/images/accept_icon.png',
                  //                                     height: 60),
                  //                                 const SizedBox(width: 4.0,),
                  //                                 Text(
                  //                                   "Gửi câu hỏi thành công",
                  //                                   style: Styles.titleItem,
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                             const SizedBox(height: 16.0),
                  //                             Text(
                  //                               "Câu hỏi của bạn sẽ được chuyển tới bác sĩ và trả lời trong thời gian sớm nhât",
                  //                               style: Styles.content,
                  //                             ),
                  //                             const SizedBox(height: 16.0),
                  //                             Text(
                  //                               'Lưu ý: Câu hỏi có thể từ chối trả lời vì một số lý do '
                  //                                   '(Thiếu thông tin, câu hỏi spam không liên quan đến sức khoẻ).',
                  //                               style: Styles.content,
                  //                             ),
                  //                             const SizedBox(height: 24.0),
                  //                             Row(
                  //                               children: [
                  //                                 const Spacer(),
                  //                                 Expanded(
                  //                                   child: AppButton(
                  //                                     title: 'Đồng ý',
                  //                                     onPressed: () async {
                  //                                       await communityPageStore.getListQuestion();
                  //                                       Modular.to.pop();
                  //                                       Modular.to.popAndPushNamed(AppRoutes.myQuestion);
                  //                                     },
                  //                                   ),
                  //                                 ),
                  //                                 const Spacer(),
                  //                               ],
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     );
                  //                   },
                  //                 );
                  //               });
                  //               return;
                  //             }
                  //             SchedulerBinding.instance
                  //                 .addPostFrameCallback((timeStamp) {
                  //               AppSnackBar.show(context, AppSnackBarType.Error,
                  //                   l10n(context).update_error);
                  //             },
                  //             );
                  //           },
                  //         ),
                  //       ),
                  //       const Spacer(),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
