import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';


class ApplicationProcessPage extends StatelessWidget {
  void _openDocument(BuildContext context, String title, String url) {
    if (url.endsWith('.pdf')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewPage(title: title, url: url),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewPage(title: title, url: url),
        ),
      );
    }
  }

  Widget _buildCard(BuildContext context, {
    required String title,
    required Color color,
    required List<String> details,
    required String formText,
    required String formUrl,
    required String applyText,
    required String applyUrl,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            ...details.map((detail) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                detail,
                style: TextStyle(fontSize: 16),
              ),
            )),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => _openDocument(context, title, formUrl),
              child: Text(
                formText,
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Text(
              '(or)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            GestureDetector(
              onTap: () => _openDocument(context, title, applyUrl),
              child: Text(
                applyText,
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Application Process',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCard(
              context,
              title: 'Change of Service Name',
              color: Colors.red.shade700,
              details: [
                '1. Application to be given in the MEESEVA Centers.',
                '2. New customer has to sign the revised agreement and test report.',
                '3. Old and new customers have to sign the declaration on stamped paper.',
                '4. There shall not be any arrears to be paid to the TGTRANSCO / DISCOM.',
                '5. There shall not be any theft / malpractice / criminal proceedings pending on this service.',
                '6. Proof of transfer of ownership to be produced.',
              ],
              formText: 'You can download the printed Name Change Application Form here.',
              formUrl: 'http://210.212.223.83:9070/VPV/Utilites/Name_Change_Application.pdf',
              applyText: 'Click here to apply Online',
              applyUrl: 'http://210.212.223.83:7001/J2S/j2s/websiteLoginUsers.action',
            ),
            _buildCard(
              context,
              title: 'Load Reduction / Enhancement',
              color: Colors.green.shade700,
              details: [
                '1. Application to be given at MEESEVA Centers in respect of LT services Cat-I, II, VI & VII.',
                '2. Application to be given to the Circle Office in respect of HT services.',
                '3. New agreement and revised test reports to be signed, after receipt of sanction from competent authority.',
                '4. Additional consumption deposits, line charges and development charges to be paid as per rules.',
                '5. In case of HT services electrical inspector approval to be produced before release of additional load.',
              ],
              formText: '',
              formUrl: '',
              applyText: 'Click here to apply Online',
              applyUrl: 'http://210.212.223.83:7001/J2S/j2s/websiteLoginUsers.action',
            ),
            _buildCard(
              context,
              title: 'Change of Category',
              color: Colors.blue.shade900,
              details: [
                '1. Application to be given in the MEESEVA Center.',
                '2. Revised agreement and test report to be signed.',
                '3. Additional consumption deposit to be paid if it attracts higher tariff.',
                '4. Additional development charges, if any to be paid as per rules.',
              ],
              formText: 'You can download the printed Change Of Category From II to I here.',
              formUrl: 'http://210.212.223.83:9070/VPV/Utilites/Change Of Category From II to I.zip',
              applyText: 'Click here to apply Online',
              applyUrl: 'http://210.212.223.83:7001/J2S/j2s/websiteLoginUsers.action',
            ),
            _buildCard(
              context,
              title: 'Change of Address',
              color: Colors.green.shade700,
              details: [
                '1. Representation to be given in the Concern Section Office.',
                '2. Consent letter for advance payment of shifting charges to be enclosed.',
                '3. Ownership document at new location to be provided.',
                '4. No objection letter from Panchayat / Municipality required.',
                '5. Clear any arrears of electricity charges.',
                '6. Shifting charges include cost estimate and supervision charges.',
              ],
              formText: 'You can download the printed Change of Address Application Form here.',
              formUrl: 'http://210.212.223.83:9070/VPV/Utilites/TransferofServiceConnectioFormNew.pdf',
              applyText: 'Click here to apply Online',
              applyUrl: 'http://210.212.223.83:7001/J2S/j2s/websiteLoginUsers.action',
            ),
          ],
        ),
      ),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  WebViewPage({required this.title, required this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
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
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
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

class PDFViewPage extends StatefulWidget {
  final String title;
  final String url;

  PDFViewPage({required this.title, required this.url});

  @override
  _PDFViewPageState createState() => _PDFViewPageState();
}

class _PDFViewPageState extends State<PDFViewPage> {
  late String _filePath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _downloadAndSavePdf();
  }

  Future<void> _downloadAndSavePdf() async {
    try {
      final url = widget.url;
      final fileName = url.split('/').last;
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      await Dio().download(url, filePath);
      setState(() {
        _filePath = filePath;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading PDF")),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : PDFView(
        filePath: _filePath,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: true,
        onError: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error opening PDF")),
          );
        },
      ),
    );
  }
}
