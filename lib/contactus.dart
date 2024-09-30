import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  final String facebookUrl =
      'https://www.facebook.com/TSNPDCL?mibextid=ZbWKwL';
  final String twitterUrl =
      'https://x.com/TG_NPDCL?t=pILoOgNdWMfGG32P9Yu3YQ&s=09';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Colors.teal, // Different color for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                _buildContactItem(
                  context,
                  icon: Icons.phone,
                  title: 'For Electrical Complaints',
                  contact: '18004250028',
                  contactStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(),
                _buildContactItem(
                  context,
                  icon: Icons.phone,
                  title: '',
                  contact: '1912',
                  contactStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Follow Us',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    _buildSocialIconButton(
                      context,
                      icon: Icons.facebook,
                      label: 'Facebook',
                      color: Colors.blue,
                      url: facebookUrl,
                    ),
                    SizedBox(width: 20),
                    _buildSocialIconButton(
                      context,
                      icon: Icons.alternate_email,
                      label: 'Twitter',
                      color: Colors.black,
                      url: twitterUrl,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(BuildContext context,
      {required IconData icon,
        required String title,
        required String contact,
        required TextStyle contactStyle}) {
    return ListTile(
      leading: Icon(icon, color: Colors.green, size: 30),
      title: title.isNotEmpty
          ? Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      )
          : null,
      subtitle: Text(
        contact,
        style: contactStyle,
      ),
    );
  }

  Widget _buildSocialIconButton(BuildContext context,
      {required IconData icon,
        required String label,
        required Color color,
        required String url}) {
    return InkWell(
      onTap: () => _launchURL(context, url),
      child: Row(
        children: [
          Icon(icon, color: color, size: 30),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }
}

