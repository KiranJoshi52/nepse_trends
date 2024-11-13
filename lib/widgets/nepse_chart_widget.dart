import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NepseChartWidget extends StatefulWidget {
  const NepseChartWidget({Key? key}) : super(key: key);

  @override
  _NepseChartWidgetState createState() => _NepseChartWidgetState();
}

class _NepseChartWidgetState extends State<NepseChartWidget> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://nepsealpha.com/trading/chart"));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
