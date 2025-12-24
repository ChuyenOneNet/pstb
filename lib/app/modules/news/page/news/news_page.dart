// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:pstb/app/modules/home/widgets/section_health_new/item_new.dart';
// import 'package:pstb/app/modules/news/page/news/news_store.dart';
// import 'package:pstb/app/modules/news/page/news/widgets/item_new_category.dart';
// import 'package:pstb/utils/main.dart';
// import 'package:pstb/widgets/stateless/custom_tabbar.dart';
// import 'package:pstb/widgets/stateless/stateless_widget.dart';
// import '../../../home/home_store.dart';
//
// class NewsPage extends StatefulWidget {
//   const NewsPage({Key? key}) : super(key: key);
//
//   @override
//   NewsPageState createState() => NewsPageState();
// }
//
// class NewsPageState extends ModularState<NewsPage, NewsStore>
//     with TickerProviderStateMixin {
//   final ScrollController _scrollController = ScrollController();
//   final _homeStore = Modular.get<HomeStore>();
//   late TabController _tabController;
//   late final List<Tab> _tab = const [
//     Tab(
//       text: 'Tổng hợp',
//     ),
//     Tab(
//       text: 'Sức khoẻ',
//     ),
//     Tab(
//       text: 'Covid',
//     ),
//   ];
//
//   @override
//   void initState() {
//     _homeStore.slideNo = 0;
//     controller.onRefresh();
//     _scrollController.addListener(_loadMoreNews);
//     _tabController = TabController(length: 3, vsync: this);
//     _tabController.animateTo(0);
//     _tabController.addListener(() {
//       // if (_tabController.index == 0) {
//       //   return;
//       // }
//       // controller.clearList();
//       // controller.showLoading();
//       // controller.getNewsWithTag(_tabController.index.toString());
//     });
//     super.initState();
//   }
//
//   Future<void> _loadMoreNews() async {
//     if (_scrollController.position.pixels ==
//         _scrollController.position.maxScrollExtent) {
//       await controller.loadMoreItem();
//     }
//   }
//
//   @override
//   void dispose() {
//     _scrollController.removeListener(_loadMoreNews);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: CustomAppBar(
//         title: l10n(context)!.new_new_health!,
//         actionIcon: const Icon(
//           Icons.search,
//           color: AppColors.primary,
//         ),
//         actionFunc: () {
//           Modular.to.pushNamed(AppRoutes.newSearch, arguments: false);
//         },
//       ),
//       body: Observer(
//         builder: (context) {
//           if (controller.loadingNew) {
//             return Container(
//               alignment: Alignment.topCenter,
//               child: const AppCircleLoading(),
//             );
//           }
//           if (controller.newsListWillShow.isEmpty && !controller.loadingNew) {
//             return Center(
//               child: Text(
//                 controller.searchText != ''
//                     ? l10n(context)!.search_no_result
//                     : l10n(context)!.had_no_data,
//                 textAlign: TextAlign.center,
//                 style: Styles.content.copyWith(color: AppColors.neutral700),
//               ),
//             );
//           }
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Xu hướng',
//                   style: Styles.titleItem,
//                 ),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 CarouselSlider(
//                   options: CarouselOptions(
//                     autoPlayInterval: const Duration(seconds: 10),
//                     aspectRatio: 16 / 9,
//                     autoPlay: _homeStore.homeSlider.length > 1,
//                     reverse: false,
//                     viewportFraction: 0.9,
//                     enlargeCenterPage: false,
//                     enlargeStrategy: CenterPageEnlargeStrategy.height,
//                     enableInfiniteScroll: _homeStore.homeSlider.length > 1,
//                     onPageChanged: (index, reason) {
//                       _homeStore.changeNews(index);
//                     },
//                   ),
//                   items: List.generate(controller.newsListWillShow.length,
//                       (index) {
//                     final _healthNew = controller.newsListWillShow[index];
//                     return ItemNew(
//                       count: _healthNew.count,
//                       created: _healthNew.created,
//                       image: _healthNew.id == '17'
//                           ? ImageEnum.viemRuotThua
//                           : _healthNew.id == '18'
//                               ? ImageEnum.phuChan
//                               : _healthNew.image,
//                       title: _healthNew.title,
//                       isFixImage:
//                           _healthNew.id == '17' || _healthNew.id == '18',
//                       onPress: () => {
//                         Modular.to.pushNamed(
//                           AppRoutes.newDetail,
//                           arguments: _healthNew.id,
//                         )
//                       },
//                     );
//                   }),
//                 ),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 Observer(builder: (context) {
//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(
//                       controller.newsListWillShow.length,
//                       (index) {
//                         return Container(
//                           width: 12.0,
//                           height: 4.0,
//                           margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.rectangle,
//                             color: index == _homeStore.slideNo
//                                 ? AppColors.primary
//                                 : AppColors.accent100,
//                             borderRadius: BorderRadius.circular(2),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }),
//                 const SizedBox(
//                   height: 8.0,
//                 ),
//                 TabbarWithNoContainer(
//                   tabController: _tabController,
//                   tabs: _tab,
//                   onTap: (index) {},
//                 ),
//                 const SizedBox(
//                   height: 8.0,
//                 ),
//                 Expanded(
//                   child: TabBarView(
//                     controller: _tabController,
//                     children: [
//                       Observer(builder: (context) {
//                         return controller.loadingTags
//                             ? const SizedBox()
//                             : controller.newsList.isNotEmpty
//                                 ? ListView.builder(
//                                     itemCount: controller.newsList.length,
//                                     shrinkWrap: true,
//                                     physics: const ClampingScrollPhysics(),
//                                     itemBuilder:
//                                         (BuildContext context, int index) {
//                                       final itemNew =
//                                           controller.newsList[index];
//                                       return InkWell(
//                                           onTap: () {
//                                             Modular.to.pushNamed(
//                                               AppRoutes.newDetail,
//                                               arguments: itemNew.id,
//                                             );
//                                           },
//                                           child: ItemNewCategory(
//                                               newItem: itemNew));
//                                     })
//                                 : Center(
//                                     child: Text(
//                                       'Không có tin tức nào.',
//                                       style: Styles.content,
//                                     ),
//                                   );
//                       }),
//                       Observer(builder: (context) {
//                         return controller.loadingTags
//                             ? const SizedBox()
//                             : controller.newsListWithTagHealth.isNotEmpty
//                                 ? ListView.builder(
//                                     itemCount:
//                                         controller.newsListWithTagHealth.length,
//                                     shrinkWrap: true,
//                                     physics: const ClampingScrollPhysics(),
//                                     itemBuilder:
//                                         (BuildContext context, int index) {
//                                       final itemNew = controller
//                                           .newsListWithTagHealth[index];
//                                       return InkWell(
//                                           onTap: () {
//                                             Modular.to.pushNamed(
//                                               AppRoutes.newDetail,
//                                               arguments: itemNew.id,
//                                             );
//                                           },
//                                           child: ItemNewCategory(
//                                               newItem: itemNew));
//                                     })
//                                 : Center(
//                                     child: Text(
//                                       'Không có tin tức nào.',
//                                       style: Styles.content,
//                                     ),
//                                   );
//                       }),
//                       Observer(builder: (context) {
//                         return controller.loadingTags
//                             ? const SizedBox()
//                             : controller.newsListWithTagCovid.isNotEmpty
//                                 ? ListView.builder(
//                                     itemCount:
//                                         controller.newsListWithTagCovid.length,
//                                     shrinkWrap: true,
//                                     physics: const ClampingScrollPhysics(),
//                                     itemBuilder:
//                                         (BuildContext context, int index) {
//                                       final itemNew = controller
//                                           .newsListWithTagCovid[index];
//                                       return InkWell(
//                                           onTap: () {
//                                             Modular.to.pushNamed(
//                                               AppRoutes.newDetail,
//                                               arguments: itemNew.id,
//                                             );
//                                           },
//                                           child: ItemNewCategory(
//                                               newItem: itemNew));
//                                     })
//                                 : Center(
//                                     child: Text(
//                                       'Không có tin tức nào.',
//                                       style: Styles.content,
//                                     ),
//                                   );
//                       }),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../constant/color.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  static const String url = 'https://phusanthaibinh.vn/tin-tuc-su-kien/';

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late final WebViewController _controller;

  int _progress = 0;
  String? _errorText;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (p) => setState(() => _progress = p),
          onPageStarted: (_) => setState(() {
            _errorText = null;
            _progress = 0;
          }),
          onPageFinished: (_) => setState(() => _progress = 100),
          onWebResourceError: (err) => setState(() {
            _errorText =
                'Không tải được trang. (${err.errorCode}) ${err.description}';
          }),
        ),
      )
      ..loadRequest(Uri.parse(NewsPage.url));
  }

  Future<bool> _handleWillPop() async {
    final canGoBack = await _controller.canGoBack();
    if (canGoBack) {
      await _controller.goBack();
      return false; // không pop page, chỉ back trong web
    }
    return true; // pop page
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _handleWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.chevron_left,
              size: 36,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Thông tin sức khỏe',
            style: TextStyle(color: AppColors.whiteColor),
          ),
          actions: [
            IconButton(
              tooltip: 'Tải lại',
              onPressed: () => _controller.reload(),
              icon: const Icon(
                Icons.refresh,
                color: AppColors.whiteColor,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(3),
            child: _progress < 100
                ? LinearProgressIndicator(value: _progress / 100)
                : const SizedBox(height: 3),
          ),
        ),
        body: _errorText != null
            ? _ErrorView(
                message: _errorText!,
                onRetry: () => _controller.loadRequest(Uri.parse(NewsPage.url)),
              )
            : WebViewWidget(controller: _controller),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, size: 48),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Thử lại'),
            ),
          ],
        ),
      ),
    );
  }
}
