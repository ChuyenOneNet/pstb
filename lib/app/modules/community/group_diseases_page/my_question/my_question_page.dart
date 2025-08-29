import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/modules/community/community_page_store.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';

import '../../../../../utils/canvas.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/routes.dart';
import '../../../../../utils/styles.dart';
import '../../../../user_app_store.dart';
import '../detail_answer_disease/widgets/card_content_widget.dart';

class MyQuestionPage extends StatefulWidget {
  MyQuestionPage({Key? key}) : super(key: key);

  @override
  State<MyQuestionPage> createState() => _MyQuestionPageState();
}

class _MyQuestionPageState extends State<MyQuestionPage> {
  final CommunityPageStore controller = Modular.get<CommunityPageStore>();
  final _userAppStore = Modular.get<UserAppStore>();
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    // controller.getListQuestion(_userAppStore.user.id ?? "");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Danh sách câu hỏi',
          isBack: true,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Modular.to.pushNamed(AppRoutes.setUpQuestion);
          },
          label: const Text('Đặt câu hỏi'),
          // icon: const Icon(Icons.send),
          backgroundColor: AppColors.primary,
        ),
        body: controller.listMyQuestion.isNotEmpty
            ? ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                itemBuilder: (_, index) {
                  final item = controller.listMyQuestion[index];
                  return CardContentWidget(
                    key: Key(index.toString()),
                    question: item.question,
                    answer: item.answer,
                    replierName: item.replierName,
                    replierImage: item.replierImage,
                    requesterImage: item.requesterImage,
                    requesterName: item.requesterName,
                  );
                },
                itemCount: controller.listMyQuestion.length,
              )
            : Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SvgPicture.asset(CanvasEnum.community),
                  // const SizedBox(
                  //   height: 8.0,
                  // ),
                  Center(
                    child: Text(
                      'Bạn không có câu hỏi nào!',
                      textAlign: TextAlign.center,
                      style: Styles.content,
                    ),
                  ),
                ],
              ));
  }
}
