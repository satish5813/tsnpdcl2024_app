import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PowerConsumptionGuidelinePage extends StatefulWidget {
  @override
  _PowerConsumptionGuidelinePageState createState() => _PowerConsumptionGuidelinePageState();
}

class _PowerConsumptionGuidelinePageState extends State<PowerConsumptionGuidelinePage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            _controller.runJavaScript(
                "document.querySelector('meta[name=\"viewport\"]').setAttribute('content', 'width=device-width, initial-scale=1.0');"
            );
          },
        ),
      )
      ..setBackgroundColor(Colors.transparent)
      ..setUserAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36")
      ..loadRequest(Uri.parse('http://210.212.223.87:8181/NPDCL2019WebApi/pcg.jsp'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Power Consumption Guideline',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Center(child: CircularProgressIndicator()), // Show loading indicator while loading
        ],
      ),
    );
  }
}

