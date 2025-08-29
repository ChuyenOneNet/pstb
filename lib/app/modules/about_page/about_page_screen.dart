import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/about_page/about_page_store.dart';
import 'package:pstb/app/modules/web_view/web_view.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class AboutPageScreen extends StatefulWidget {
  const AboutPageScreen({Key? key}) : super(key: key);

  @override
  _AboutPageScreenState createState() => _AboutPageScreenState();
}

class _AboutPageScreenState
    extends ModularState<AboutPageScreen, AboutPageStore> {
  final _newDetailController = Modular.get<AboutPageStore>()..getNewsDetail();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      switch (_newDetailController.statusWidget) {
        case StatusWidget.htmlView:
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: CustomAppBar(
              isBack: true,
              title: _newDetailController.isLoading
                  ? ''
                  : _newDetailController.news.title,
            ),
            body: _newDetailController.isLoading
                ? const SizedBox.shrink()
                : SingleChildScrollView(
                    child: Html(
                      data: controller.news.description ?? '',
                    ),
                  ),
          );
        case StatusWidget.webView:
          return WebViewApp(
            url: _newDetailController.url,
          );
      }
    });
  }
}
