import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class AddServiceActivity extends StatefulWidget {
  final User user;

  AddServiceActivity({required this.user});

  @override
  _AddServiceActivityState createState() => _AddServiceActivityState();
}

class _AddServiceActivityState extends State<AddServiceActivity> {
  final List<Option> circleOptions = [
    Option('000', 'SELECT'),
    Option('401', 'KHAMMAM'),
    Option('402', 'WARANGAL URBAN'),
    Option('407', 'WARANGAL RURAL'),
    Option('403', 'KARIMNAGAR'),
    Option('405', 'ADILABAD'),
    Option('404', 'NIZAMABAD'),
    Option('406', 'BHADRADRI KOTHAGUDEM'),
    Option('408', 'JANGAON'),
    Option('409', 'BHOOPALAPALLY'),
    Option('410', 'MAHABUBABAD'),
    Option('411', 'JAGITYAL'),
    Option('412', 'PEDDAPALLY'),
    Option('413', 'KAMAREDDY'),
    Option('414', 'NIRMAL'),
    Option('415', 'ASIFABAD'),
    Option('416', 'MANCHERIAL'),
  ];

  String? selectedCircle;
  String? selectedEro;
  List<Option> eroOptions = [];
  bool isLoading = false;
  final TextEditingController uscController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Service'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Circle Spinner
            DropdownButton<String>(
              hint: Text('Select Circle'),
              value: selectedCircle,
              items: circleOptions.map((Option option) {
                return DropdownMenuItem<String>(
                  value: option.id,
                  child: Text(option.name),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedCircle = newValue;
                  getErosOfCircle(newValue!);
                });
              },
            ),

            // ERO Spinner
            if (eroOptions.isNotEmpty)
              DropdownButton<String>(
                hint: Text('Select ERO'),
                value: selectedEro,
                items: eroOptions.map((Option option) {
                  return DropdownMenuItem<String>(
                    value: option.id,
                    child: Text(option.name),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedEro = newValue;
                  });
                },
              ),

            // USCNO Input
            TextField(
              controller: uscController,
              decoration: InputDecoration(labelText: 'USCNO'),
              keyboardType: TextInputType.number,
            ),

            // Nickname Input
            TextField(
              controller: nickNameController,
              decoration: InputDecoration(labelText: 'Nick Name (Optional)'),
            ),

            SizedBox(height: 20),

            // Add Service Button
            ElevatedButton(
              onPressed: () {
                if (uscController.text.length < 8) {
                  showAlert('Please enter a valid USCNO');
                } else {
                  validateServiceNumber();
                }
              },
              child: Text('Add Service'),
            ),

            // Loading Indicator
            if (isLoading) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  // Validate Service Number
  Future<void> validateServiceNumber() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Retrieve token from Firebase
      String? token = await widget.user.getIdToken(true);
      print("userdata${uscController.text}");
      print("userdata${(uscController.text.runtimeType)}");
      if (token != null) {
        Map<String, dynamic> body = {
          "app": "in.tsnpdcl.tsnpdcl",
          "ero": "-",
          "sc": uscController.text,
          "forSelfBilling": false,
          "token": token,

        };

        final response = await http.post(
          Uri.parse('http://210.212.223.88:5656/NPDCL2024SpringWebApi/rest/api/validateService'),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'},
        );
        print("response${response.body}");
        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          if (responseBody['isSuccess']) {
            final checkResponse = CheckResponseWrapper.fromJson(responseBody['data']);
            showConfirmationPopup(context, checkResponse);
          } else {
            showAlert(responseBody['msg']);
          }
        } else {
          showAlert('Failed to validate service number');
        }
      }
    } catch (e) {
      showAlert('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Get EROs based on Circle ID
  Future<void> getErosOfCircle(String circleId) async {
    setState(() {
      isLoading = true;
    });

    try {
      String? token = await widget.user.getIdToken(true);

      if (token != null) {
        Map<String, dynamic> body = {
          'token': token,
          'cid': circleId,
        };

        final response = await http.post(
          Uri.parse('http://210.212.223.88:5656/NPDCL2024SpringWebApi/rest/api/getEros'),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          setState(() {
            eroOptions = (responseBody['data'] as List)
                .map((e) => Option.fromJson(e))
                .toList();
          });
        } else {
          showAlert('Failed to load EROs');
        }
      }
    } catch (e) {
      showAlert('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Show Confirmation Popup
  void showConfirmationPopup(BuildContext context, CheckResponseWrapper data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Service Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Consumer Name: ${data.name}'),
              Text('Service No.: ${data.scno}'),
              Text('USCNO: ${data.uscno}'),
              Text('Circle Code: ${data.circle}'),
              Text('ERO Code: ${data.erono}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                addServiceNumber(data);
                Navigator.pop(context);
              },
              child: Text('CONFIRM'),
            ),
          ],
        );
      },
    );
  }

  // Add Service
  Future<void> addServiceNumber(CheckResponseWrapper data) async {
    setState(() {
      isLoading = true;
    });

    try {
      String? token = await widget.user.getIdToken(true);

      if (token != null) {
        Map<String, dynamic> body = {
          'token': token,
          'cid': data.circle.toString(),
          'ero': data.erono.toString(),
          'sc': data.scno.toString(),
          'name': data.name.toString(),
          'usc': data.uscno.toString(),
          'nickName': nickNameController.text,
        };

        final response = await http.post(
          Uri.parse('http://210.212.223.88:5656/NPDCL2024SpringWebApi/rest/api/addServiceToAccount'),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          if (responseBody['isSuccess']) {
            showAlert('Service added successfully');
            Navigator.pop(context);
          } else {
            showAlert(responseBody['msg']);
          }
        } else {
          showAlert('Failed to add service');
        }
      }
    } catch (e) {
      showAlert('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Show Alert
  void showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// Option Model
class Option {
  String id;
  String name;

  Option(this.id, this.name);

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      json['id'],
      json['name'],
    );
  }
}

// CheckResponseWrapper Model
class CheckResponseWrapper {
  String circle;
  String erono;
  String scno;
  String name;
  String uscno;

  CheckResponseWrapper({
    required this.circle,
    required this.erono,
    required this.scno,
    required this.name,
    required this.uscno,
  });

  factory CheckResponseWrapper.fromJson(Map<String, dynamic> json) {
    return CheckResponseWrapper(
      circle: json['circle'],
      erono: json['erono'],
      scno: json['scno'],
      name: json['name'],
      uscno: json['uscno'],
    );
  }
}
