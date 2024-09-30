import 'package:TGNPDCL/ConsumerGrievancePage.dart';
import 'package:TGNPDCL/EnterDetailsPage.dart';
import 'package:TGNPDCL/LinkAadharPage.dart';
import 'package:TGNPDCL/ReportIncidentPage.dart';
import 'package:flutter/material.dart';
import 'package:TGNPDCL/ApplicationProcessPage.dart';
import 'package:TGNPDCL/DomesticBillCalculator.dart';
import 'package:TGNPDCL/EnergySavingPage.dart';
import 'package:TGNPDCL/FeedbackPage.dart';
import 'package:TGNPDCL/HowtoMakeNewConnection.dart';
import 'package:TGNPDCL/KnowMyOfficerActivity.dart';
import 'package:TGNPDCL/KnowYourBillPage.dart';
import 'package:TGNPDCL/MyAccountPage.dart';
import 'package:TGNPDCL/PowerConsumptionGuidelinePage.dart';
import 'package:TGNPDCL/SecurityPage.dart';
import 'package:TGNPDCL/contactus.dart';
import 'package:TGNPDCL/privacypolicy.dart';
import 'package:TGNPDCL/tarriddetails.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import the Firebase User class
import 'package:TGNPDCL/AddServiceActivity.dart'; // Import your AddServiceActivity screen

class Home extends StatefulWidget {
  final User user;

  Home({required this.user});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool hasService = false;
  double billDueAmount = 0.0;
  String serviceNo = '';
  String consumerName = '';
  String dueDate = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF008080), // Background color matching the header
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16.0),
                ),
              ),
              child: hasService ? _buildServiceCard() : _buildAddServiceButton(),
            ),
          ),
          Expanded(
            child: _buildGridMenu(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Color(0xFF008080), // Same as the app bar color
      child: Column(
        children: [
          SizedBox(height: 45),
          Text(
            "TGNPDCL",
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 2,
              fontSize: 25,
            ),
          ),
          CircleAvatar(
            radius: 40.0,
            backgroundImage: widget.user.photoURL != null
                ? NetworkImage(widget.user.photoURL!)
                : AssetImage('assets/cg.png') as ImageProvider,
          ),
          SizedBox(height: 10),
          Text(
            widget.user.displayName ?? 'No Name',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.user.email ?? 'No Email',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  // Button to Add Service when no services are added
  Widget _buildAddServiceButton() {
    return Column(
      children: [
        Text(
          "It appears that you haven't added any service connections to this account. Click here to add them now.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () async {
            // Navigate to AddServiceActivity to add a new service and pass the user object
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddServiceActivity(user: widget.user), // Pass the user object here
              ),
            );

            // Handle the result returned from AddServiceActivity
            if (result != null && result['serviceAdded'] == true) {
              // If service was successfully added, update the state
              setState(() {
                hasService = true;
                serviceNo = result['serviceNo'];
                consumerName = result['consumerName'];
                billDueAmount = result['billDueAmount'];
                dueDate = result['dueDate'];
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF00A2E8), // Button color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Text(
              'ADD SERVICE',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  // Display the service card once the service is added
  Widget _buildServiceCard() {
    return Card(
      color: billDueAmount > 0 ? Colors.red : Colors.teal,
      elevation: 4,
      child: ListTile(
        title: Text(
          '$serviceNo',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          consumerName,
          style: TextStyle(color: Colors.white70),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₹$billDueAmount',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              dueDate,
              style: TextStyle(color: Colors.white70),
            ),
            if (billDueAmount > 0)
              TextButton(
                onPressed: () {
                  // Handle pay bill action
                },
                child: Text(
                  'PAY',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Menu grid for other options
  Widget _buildGridMenu(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _buildGridItem(context, 'REPORT AN INCIDENT', 'assests/rai.png', ReportIncidentPage()),
        _buildGridItems(context, 'CONSUMER GRIEVANCES', 'assests/cg.png', null, () => _showConsumerGrievancesBottomSheet(context)),
        _buildGridItem(context, 'SELF READING', 'assests/sr.png', null),
        _buildGridItem(context, 'PAY BILL', 'assests/pay.png', null),
        _buildGridItem(context, 'BILL HISTORY', 'assests/bill.png', EnterDetailsPage()),
        _buildGridItem(context, 'ONLINE PAYMENT HISTORY', 'assests/op.png', EnterDetailsPage()),
        _buildGridItem(context, 'LINK AADHAR & MOBILE', 'assests/linkadar.png', LinkAadharPage()),
        _buildGridItem(context, 'DOMESTIC BILL CALCULATOR', 'assests/calc.png', DomesticBillCalculator()),
        _buildGridItem(context, 'HOW TO TAKE NEW CONNECTION', 'assests/electric_meter.png', HowtoMakeNewConnection()),
        _buildGridItem(context, 'HOW TO CHANGE (NAME,LOAD,CATEGORY,ADDRESS)', 'assests/edit.png', ApplicationProcessPage()),
        _buildGridItem(context, 'POWER CONSUMPTION GUIDELINE', 'assests/book.png', PowerConsumptionGuidelinePage()),
        _buildGridItem(context, 'TARIFF DETAILS', 'assests/taxation.png', TarridDetails()),
        _buildGridItem(context, 'ENERGY SAVING TIPS', 'assests/EST.png', EnergySavingPage()),
        _buildGridItem(context, 'SAFETY TIPS', 'assests/SAFTEY.png', SecurityPage()),
        _buildGridItem(context, 'FEEDBACK', 'assests/feedback.png', FeedbackPage()),
        _buildGridItem(context, 'MY ACCOUNT', 'assests/man.png', MyAccountPage()),
        _buildGridItem(context, 'KNOW YOUR BILL', 'assests/know_your_bill.png', KnowYourBillPage()),
        _buildGridItem(context, 'KNOW YOUR OFFICE', 'assests/chief_executive_officer.png', KnowMyOfficerActivity()),
        _buildGridItem(context, 'CONTACT US', 'assests/complain.png', ContactUsPage()),
        _buildGridItem(context, 'PRIVACY POLICY', 'assests/privacy.png', PrivacyPolicy()), // Navigation to PrivacyPolicy
        _buildGridItem(context, 'LOG OUT', 'assests/logout.png', null),
      ],
    );
  }
  Widget _buildGridItems(BuildContext context, String title, String iconPath, Widget? page, [VoidCallback? onTap]) {
    return Card(
      color: Colors.teal.shade50,
      shadowColor: Colors.indigo,
      elevation: 12,
      child: InkWell(
        onTap: onTap ??
                () {
              if (page != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              }
            },
        child: Column(
          children: [
            SizedBox(height: 8),
            Image.asset(
              iconPath,
              width: 50,
              height: 50,
            ),
            SizedBox(height: 8.5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Function to build each menu item in the grid
  Widget _buildGridItem(BuildContext context, String title, String iconPath, Widget? page) {
    return Card(
      color: Colors.teal.shade50,
      shadowColor: Colors.indigo,
      elevation: 6,
      child: InkWell(
        onTap: () {
          if (page != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Column(
          children: [
            SizedBox(height: 8),
            Image.asset(iconPath, width: 50, height: 50),
            SizedBox(height: 8.5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.indigo, fontSize: 10.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
void _showConsumerGrievancesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5), // Slight transparency on the screen behind the bottom sheet
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Makes the bottom sheet itself transparent
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85), // To create a semi-transparent background
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjusts to the minimum size required
            children: [
              Text(
                'CONSUMER GRIEVANCES',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2, // 2 columns
                shrinkWrap: true, // Makes GridView fit within the bottom sheet
                physics: NeverScrollableScrollPhysics(), // Disable scrolling
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _buildBottomGridItem(context, Icons.add_circle, 'NEW COMPLAINT'),
                  _buildBottomGridItem(context, Icons.check_circle, 'COMPLAINT STATUS'),
                  _buildBottomGridItem(context, Icons.refresh, 'REOPEN COMPLAINT'),
                  _buildBottomGridItem(context, Icons.cancel, 'CANCEL'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomGridItem(BuildContext context, IconData iconData, String label) {
    return Card(
      color: Colors.teal.shade200, // Card background color as per your request
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Handle tap on each grid item
          Navigator.pop(context); // Close the bottom sheet after tapping
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 40,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
