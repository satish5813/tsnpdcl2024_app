import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EnterDetailsPage extends StatefulWidget {
  @override
  _EnterDetailsPageState createState() => _EnterDetailsPageState();
}

class _EnterDetailsPageState extends State<EnterDetailsPage> {
  String? selectedAccount;
  List<String> accounts = ['Account 1', 'Account 2', 'Account 3']; // Example account list
  final TextEditingController uscnoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Details'),
        backgroundColor: Colors.brown,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Add back button functionality
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'USCNO.',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: uscnoController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Select Account:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                DropdownButton<String>(
                  value: selectedAccount,
                  hint: Text('Choose'),
                  items: accounts.map((String account) {
                    return DropdownMenuItem<String>(
                      value: account,
                      child: Text(account),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedAccount = newValue;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to WebView and pass the USC number
                  String uscNo = uscnoController.text;
                  String url = "http://210.212.223.83:9000/EBS/Consumer%20Management/OnlinePayment.jsp?UscNo=" + uscNo;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WebViewPage(url: url)),
                  );
                },
                child: Text('GET HISTORY'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String url;

  WebViewPage({required this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Initialize the controller
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false; // Hide loading indicator when the page finishes loading
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web History'),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _controller.reload(); // Reload the current page
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(), // Loading spinner
            ),
        ],
      ),
    );
  }
}
