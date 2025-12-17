import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../constant/color.dart';

class RadWebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  const RadWebViewScreen({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  State<RadWebViewScreen> createState() => _RadWebViewScreenState();
}

class _RadWebViewScreenState extends State<RadWebViewScreen> {
  late final WebViewController _controller;
  int _progress = 0;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    final uri = Uri.tryParse(widget.url);
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (p) => setState(() => _progress = p),
          onWebResourceError: (_) => setState(() => _hasError = true),
        ),
      );

    if (uri != null) {
      _controller.loadRequest(uri);
    } else {
      _hasError = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          if (_progress < 100 && !_hasError)
            LinearProgressIndicator(value: _progress / 100),
          Expanded(
            child: _hasError
                ? Center(
                    child: Text(
                      'Không thể tải kết quả.\nVui lòng kiểm tra đường dẫn hoặc mạng nội bộ.',
                      textAlign: TextAlign.center,
                    ),
                  )
                : WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }
}
