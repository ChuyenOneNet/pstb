import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/community/community_page_store.dart';
import 'package:pstb/app/modules/community/group_diseases_page/detail_answer_disease/widgets/card_content_widget.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/routes.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';
import 'package:pstb/widgets/stateless/button_back.dart';

class ResultSearchQuestionPage extends StatefulWidget {
  const ResultSearchQuestionPage({Key? key}) : super(key: key);

  @override
  State<ResultSearchQuestionPage> createState() =>
      _ResultSearchQuestionPageState();
}

class _ResultSearchQuestionPageState extends State<ResultSearchQuestionPage> {
  final CommunityPageStore controller = Modular.get<CommunityPageStore>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_loadMoreItems);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreItems);
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _loadMoreItems() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await controller.loadMoreSearchQuestion(controller.keyword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Text(
                'Kết quả tìm kiếm câu hỏi: ${controller.keyword}',
                style: Styles.titleItem,
              ),
              const Divider(
                color: Colors.black,
              ),
              Expanded(
                child: Observer(builder: (context) {
                  return controller.listSearchQuestion.isNotEmpty
                      ? ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.zero,
                          itemBuilder: (_, index) {
                            final item = controller.listSearchQuestion[index];
                            return InkWell(
                              onTap: () {
                                _userAppStore.item = item;
                                Modular.to.pushNamed(AppRoutes.detailQuestion,
                                    arguments: {
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
                          itemCount: controller.listSearchQuestion.length,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/social_media.jpg'),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              'Không tìm thấy câu hỏi nào!',
                              textAlign: TextAlign.center,
                              style: Styles.content,
                            ),
                          ],
                        );
                }),
              ),
            ],
          ),
          const ButtonBackWidget(),
        ],
      ),
    );
  }
}
