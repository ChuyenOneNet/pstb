import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/community/group_diseases_page/detail_answer_disease/widgets/card_content_widget.dart';
import 'package:pstb/utils/routes.dart';
import 'package:pstb/widgets/stateless/custom_autocomplete_basic.dart';
import '../../../../utils/styles.dart';
import '../../../app_store.dart';
import '../../../user_app_store.dart';
import '../community_page_store.dart';

class SearchQuestionPage extends StatelessWidget {
  SearchQuestionPage({Key? key}) : super(key: key);
  final CommunityPageStore communityPageStore =
      Modular.get<CommunityPageStore>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  final AppStore appStore = Modular.get<AppStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Modular.to.pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomAutocompleteBasic(
                      store: communityPageStore,
                      keywordSearch: communityPageStore.keywordSearch,
                      onSubmitted: (value) async {
                        await communityPageStore.getSearchQuestion(value);
                        communityPageStore.keyword = value;
                        Modular.to
                            .popAndPushNamed(AppRoutes.resultSearchQuestion);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Tìm kiếm gần nhất',
                    style: Styles.titleItem,
                  ),
                ),
              ),
              Observer(builder: (context) {
                final item = _userAppStore.item;
                return _userAppStore.item.questionTitle == null ||
                        _userAppStore.item.questionTitle == ''
                    ? SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Bạn chưa tìm kiếm gần đây.',
                            style: Styles.content,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: InkWell(
                          onTap: () {},
                          child: CardContentWidget(
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
                        ),
                      );
              }),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Gợi ý cho bạn',
                    style: Styles.titleItem,
                  ),
                ),
              ),
              if (communityPageStore.listMyQuestion.length >= 2)
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      final item = communityPageStore.listMyQuestion[index];
                      return InkWell(
                        onTap: () {
                          // Modular.to.pushNamed(AppRoutes.detailHospitalPage, arguments: {
                          //   "hospitalModel": hospital,
                          // });
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
                    itemCount: 2,
                    physics: const ClampingScrollPhysics(),
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
