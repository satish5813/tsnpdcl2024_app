import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF008080),
        title: Center(
          child: Text('Privacy Policy',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold
          ),),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          color: Colors.teal.shade50,
          elevation: 10,
          child: ListView(
            children: [
              Center(child: _buildSectionTitle('Privacy Policy')),
              SizedBox(height: 8),
              _buildParagraph(
                  'TELANGANA NORTHERN POWER DISTRIBUTION COMPANY LIMITED (TGNPDCL) built the TGNPDCL app as a Free app. This SERVICE is provided by TGNPDCL at no cost and is intended for use as is.'),
              SizedBox(height: 8),
              _buildParagraph(
                  'This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.'),
              SizedBox(height: 8),
              _buildParagraph(
                  'If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.'),
              SizedBox(height: 16),
              _buildSectionTitle('1. Information Collection and Use'),
              _buildSubSectionTitle('1.1. Types of Information Collected'),
              _buildParagraph(
                  'We collect both Personal Information and Non-Personal Information from you. Collectively, these are referred to as "Information".'),
              _buildParagraph(
                  'Personal Information: This refers to data that can be used to uniquely identify or contact you. Personal Information may include, but is not limited to:'),
              _buildBulletList([
                'Name',
                'Mobile Number',
                'Email address',
                'Your Device location',
              ]),
              _buildParagraph(
                  'Non-Personal Information: This refers to data that does not, on its own, permit direct association with any specific individual.'),
              _buildSubSectionTitle('1.2. Methods of Information Collection'),
              _buildParagraph(
                  'We collect your Information through various methods, including but not limited to:'),
              _buildBulletList([
                'When you submit electrical incident reports and other complaints, we collect your device location using GPS technology and images captured by your device camera.',
                'When you provide your Information to us for registering new complaints.',
              ]),
              SizedBox(height: 16),
              _buildSectionTitle('2. Use of Information Collected'),
              _buildParagraph(
                  'We collect your Information for various purposes, including but not limited to:'),
              _buildBulletList([
                'Reviewing the electrical complaints posted by you.',
                'Responding to your inquiries and complaints.',
              ]),
              SizedBox(height: 16),
              _buildSectionTitle('3. Permissions Requested'),
              _buildParagraph('The TGNPDCL app requests the following permissions:'),
              _buildBulletList([
                'ACCESS_FINE_LOCATION: To provide location-based services.',
                'INTERNET: To access the internet for data exchange.',
                'ACCESS_NETWORK_STATE: To check network connectivity status.',
                'CAMERA: To capture photos and videos.',
                'READ_EXTERNAL_STORAGE: To read files from your device storage.',
                'WRITE_EXTERNAL_STORAGE: To write files to your device storage.',
                'BLUETOOTH_SCAN: To scan for Bluetooth devices.',
                'BLUETOOTH_CONNECT: To connect to Bluetooth devices.',
                'BLUETOOTH: General Bluetooth permissions.',
                'BLUETOOTH_ADMIN: For managing Bluetooth connections.',
              ]),
              SizedBox(height: 16),
              _buildSectionTitle('4. Security'),
              _buildParagraph(
                  'We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. However, please remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.'),
              SizedBox(height: 16),
              _buildSectionTitle('5. Children\'s Privacy'),
              _buildParagraph(
                  'This app is also suitable for users under 13 years of age. We do not knowingly collect personally identifiable information from children under 13 years of age without verifiable parental consent. In the event that we discover that a child under 13 has provided us with personal information without parental consent, we will immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we can take the necessary actions.'),
              SizedBox(height: 16),
              _buildSectionTitle('6. Changes to This Privacy Policy'),
              _buildParagraph(
                  'We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately after they are posted on this page.'),
              SizedBox(height: 16),
              _buildSectionTitle('7. Contact Us'),
              _buildParagraph(
                  'If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at:'),
              _buildParagraph(
                  'TELANGANA NORTHERN POWER DISTRIBUTION COMPANY LIMITED (TGNPDCL)\nAddress of Corporate Office\nH.No: 2-5-31/2, Corporate Office, Vidyut Bhavan,\nNakkalagutta, Hanamkonda,\nWarangal,\nTelangana 506001'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.teal,
      ),
    );
  }

  Widget _buildSubSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.teal,
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(fontSize: 14,),
    );
  }

  Widget _buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "\u2022 ", // Bullet symbol
              style: TextStyle(fontSize: 14),
            ),
            Expanded(
              child: Text(
                item,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}


