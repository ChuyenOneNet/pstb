import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/news/page/new_detail/new_detail_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/button_back.dart';

import 'widgets/category_widget.dart';

class NewDetailPage extends StatefulWidget {
  final dynamic id;

  const NewDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _NewDetailPageState createState() => _NewDetailPageState();
}

class _NewDetailPageState extends ModularState<NewDetailPage, NewsDetailStore> {
  @override
  void initState() {
    controller.initialScreen(
      newId: widget.id,
      screenContext: context,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: controller.loading
              ? Center(
                  child: Text(
                    'Đang tải dữ liệu...',
                    style: Styles.subtitleSmallest,
                  ),
                )
              : Stack(
                  children: [
                    SingleChildScrollView(
                      controller: controller.scrollController,
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: (controller.news.id == '17' ||
                                    controller.news.id == '18')
                                ? Image.asset(
                                    controller.news.image,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    controller.news.image,
                                    fit: BoxFit.fitWidth,
                                  ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          CategoryWidget(),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              controller.news.title ?? '',
                              style: Styles.titleItem,
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Html(
                                data: controller.news.description ?? '',
                                style: {
                                  "body": Style(
                                    fontFamily: 'Inter',
                                    fontSize: FontSize(14.0),
                                    color: AppColors.black,
                                  ),
                                },
                              ))
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 48.0),
                      child: ButtonBackWidget(),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
