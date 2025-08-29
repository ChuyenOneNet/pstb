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
import '../../../user_app_store.dart';
import '../group_diseases_page/detail_answer_disease/widgets/card_content_widget.dart';

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
    _scrollController = ScrollController()..addListener(_loadMoreItems);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.removeListener(_loadMoreItems);
    super.dispose();
  }

  Future<void> _loadMoreItems() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await controller.loadMoreQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Câu hỏi của tôi',
          isBack: true,
          actionIcon: const Icon(
            Icons.search,
            color: AppColors.primary,
          ),
          actionFunc: () {
            Modular.to.pushNamed(AppRoutes.searchQuestion);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Modular.to.pushNamed(AppRoutes.setUpQuestion);
          },
          child: const Icon(Icons.add),
          backgroundColor: AppColors.primary,
        ),
        body: Observer(builder: (context) {
          return controller.listMyQuestion.isNotEmpty
              ? ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, index) {
                    final item = controller.listMyQuestion[index];
                    return InkWell(
                      onTap: () {
                        Modular.to
                            .pushNamed(AppRoutes.detailQuestion, arguments: {
                          "questionTitle": item.questionTitle,
                          "requesterName": item.requesterName,
                          "question": item.question,
                          "topicName": item.topicName,
                          "createdTime": item.createdTime,
                          "replierName": item.replierName,
                          "answer": item.answer,
                        });
                      },
                      child: CardContentWidget(
                        key: Key(index.toString()),
                        question: item.question,
                        answer: item.answer,
                        replierName: item.replierName,
                        replierImage: item.replierImage,
                        requesterImage: item.requesterImage,
                        requesterName: item.requesterName,
                        topicName: item.topicName,
                        createdTime: item.createdTime,
                        questionTitle: item.questionTitle,
                      ),
                    );
                  },
                  itemCount: controller.listMyQuestion.length,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/social_media.jpg'),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Bạn không có câu hỏi nào!',
                      textAlign: TextAlign.center,
                      style: Styles.content,
                    ),
                  ],
                );
        }));
  }
}
