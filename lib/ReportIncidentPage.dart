import 'package:flutter/material.dart';

class ReportIncidentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report An Incident'),
        backgroundColor: Colors.teal, // Matching the header color from the image
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt, color: Colors.green), // Icon for Report an Incident
            title: Text(
              'Report an Incident',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              // Navigate to Report Incident Form
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportIncidentFormPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.save_alt, color: Colors.orange), // Icon for Saved For Later
            title: Text(
              'Saved For Later',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              // Navigate to Saved For Later Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedForLaterPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.history, color: Colors.red), // Icon for Reported Incidents
            title: Text(
              'Reported Incidents',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              // Navigate to Reported Incidents Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportedIncidentsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Sample Page for 'Report an Incident' action
class ReportIncidentFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report an Incident'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text('This is the form page to report an incident.'),
      ),
    );
  }
}

// Sample Page for 'Saved For Later' action
class SavedForLaterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved For Later'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text('This is the page for Saved For Later incidents.'),
      ),
    );
  }
}

// Sample Page for 'Reported Incidents' action
class ReportedIncidentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reported Incidents'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text('This is the page for reported incidents history.'),
      ),
    );
  }
}

