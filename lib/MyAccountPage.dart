import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  bool hasLinkedServices = false;

  @override
  void initState() {
    super.initState();

    // Show the snackbar if there are no linked services
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!hasLinkedServices) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You didn't have any linked services with this account."),
            duration: Duration(seconds: 3),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account',
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.teal, // Same color as in your design
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.sync),
            onPressed: () {
              // Refresh functionality
            },
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.add),
            onPressed: () {
              // Add service functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/profile_pic.jpg'), // Replace with the actual image path
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Satish T',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('satish5813@gmail.com'),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Sign out functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: Text('SIGN OUT'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Saved Service Connections',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            if (!hasLinkedServices)
              Column(
                children: [
                  Image.asset(
                    'assests/empty_draw.png', // Replace with the actual image path
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "You don't have any Service connections linked with this account. Please click 'Add Service' or click 'Pay Instantly'.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

