import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KnowYourBillPage extends StatefulWidget {
  @override
  _KnowYourBillPageState createState() => _KnowYourBillPageState();
}

class _KnowYourBillPageState extends State<KnowYourBillPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://tgnpdcl.com/Menu/KnowYourBill'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Know Your Bill',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
        ),
        backgroundColor: Colors.teal, // Same as other pages
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}


