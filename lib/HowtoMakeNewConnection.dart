import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HowtoMakeNewConnection extends StatefulWidget {
  @override
  _HowtoMakeNewConnectionState createState() => _HowtoMakeNewConnectionState();
}

class _HowtoMakeNewConnectionState extends State<HowtoMakeNewConnection> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('http://210.212.223.83:9070/VPV/VPVPortal/NewConnection.jsp'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How to Make New Connection',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.teal,
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
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

