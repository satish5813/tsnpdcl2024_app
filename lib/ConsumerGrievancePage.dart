import 'package:flutter/material.dart';

class ConsumerGrievancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consumer Grievances'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Show Bottom Sheet when the button is pressed
            _showBottomSheet(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
          ),
          child: Text('Open Consumer Grievances'),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
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
                  _buildGridItem(context, Icons.add_circle, 'NEW COMPLAINT'),
                  _buildGridItem(context, Icons.check_circle, 'COMPLAINT STATUS'),
                  _buildGridItem(context, Icons.refresh, 'REOPEN COMPLAINT'),
                  _buildGridItem(context, Icons.cancel, 'CANCEL'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGridItem(BuildContext context, IconData iconData, String label) {
    return GestureDetector(
      onTap: () {
        // Handle tap on each grid item
        Navigator.pop(context); // Close the bottom sheet after tapping
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade200,
            child: Icon(
              iconData,
              size: 30,
              color: Colors.teal,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

