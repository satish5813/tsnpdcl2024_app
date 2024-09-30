import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KnowMyOfficerActivity extends StatefulWidget {
  @override
  _KnowMyOfficerActivityState createState() => _KnowMyOfficerActivityState();
}

class _KnowMyOfficerActivityState extends State<KnowMyOfficerActivity> {
  final TextEditingController _controller = TextEditingController();
  List<OfficerDetails> _officerDetails = [];

  Future<void> _getDetails() async {
    final String uscno = _controller.text;

    if (uscno.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a number')),
      );
      return;
    }

    final response = await http.get(
      Uri.parse('https://api.example.com/getDetails?uscno=$uscno'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _officerDetails = data.map((item) => OfficerDetails.fromJson(item)).toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load details')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF008080),
        title: Center(child: Text('Know My Officer',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter USCNO',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: _getDetails,
                child: Text('Get Details'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:Color(0xFF008080) ,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: _officerDetails.length,
                itemBuilder: (context, index) {
                  final detail = _officerDetails[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          detail.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Icon(Icons.phone, color: Colors.green),
                            SizedBox(width: 10),
                            Text(detail.phone),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OfficerDetails {
  final String name;
  final String phone;

  OfficerDetails({required this.name, required this.phone});

  factory OfficerDetails.fromJson(Map<String, dynamic> json) {
    return OfficerDetails(
      name: json['name'],
      phone: json['phone'],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: KnowMyOfficerActivity(),
  ));
}
