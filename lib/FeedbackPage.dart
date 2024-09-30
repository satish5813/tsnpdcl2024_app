import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('http://210.212.223.87:8181/NPDCL2019WebApi/feedback.jsp'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Feedback',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
        backgroundColor: Colors.teal, // Consistent color theme
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.refresh),
            onPressed: () {
              _controller.reload();
            },
          ),
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

