import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/community/group_diseases_page/detail_answer_disease/detail_answer_disease_store.dart';
import 'package:pstb/app/modules/community/question_page/question_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'widgets/card_content_widget.dart';

class DetailAnswerDiseasePage extends StatefulWidget {
  const DetailAnswerDiseasePage({Key? key}) : super(key: key);

  @override
  State<DetailAnswerDiseasePage> createState() =>
      _DetailAnswerDiseasePageState();
}

class _DetailAnswerDiseasePageState extends State<DetailAnswerDiseasePage> {
  final _categoryDiseasesStore = Modular.get<DetailAnswerDiseaseStore>();
  final QuestionStore questionStore = Modular.get<QuestionStore>();
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_loadMoreItems);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreItems);
    _categoryDiseasesStore.dispose();
    super.dispose();
  }

  Future<void> _loadMoreItems() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await _categoryDiseasesStore.loadMore();
    }
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            questionStore.categoryDiseaseModel =
                _categoryDiseasesStore.categoryDiseaseModel;
            Modular.to.pushNamed(AppRoutes.setUpQuestion);
          },
          child: const Icon(Icons.add),
          backgroundColor: AppColors.primary,
        ),
        appBar: CustomAppBar(
          title:
              'Hỏi đáp ${_categoryDiseasesStore.categoryDiseaseModel.name!.toLowerCase()}',
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await _categoryDiseasesStore.onRefresh();
          },
          child: Observer(builder: (context) {
            return Column(
              children: [
                Expanded(
                  child: _categoryDiseasesStore.items.isEmpty
                      ? Center(
                          child: Text(l10n(context).had_no_data),
                        )
                      : Observer(builder: (context) {
                          switch (_categoryDiseasesStore.state) {
                            case DetailState.loading:
                              return const AppCircleLoading();
                            case DetailState.success:
                              return ListView.builder(
                                controller: _scrollController,
                                padding: EdgeInsets.zero,
                                itemBuilder: (_, index) {
                                  final item =
                                      _categoryDiseasesStore.items[index];
                                  return InkWell(
                                    onTap: () {
                                      Modular.to.pushNamed(
                                          AppRoutes.detailQuestion,
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
                                itemCount:
                                    _categoryDiseasesStore.lengthLoadMore,
                              );
                            default:
                              return const SizedBox();
                          }
                        }),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
