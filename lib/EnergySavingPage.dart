import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EnergySavingPage extends StatefulWidget {
  @override
  _EnergySavingPageState createState() => _EnergySavingPageState();
}

class _EnergySavingPageState extends State<EnergySavingPage> {
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
          },
        ),
      )
      ..loadRequest(Uri.parse('http://210.212.223.87:8181/NPDCL2019WebApi/energy.html'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Energy Saving',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
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

