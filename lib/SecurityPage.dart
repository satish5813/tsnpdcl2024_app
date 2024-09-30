import 'package:flutter/material.dart';

class SecurityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Safty Tips',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          color: Colors.teal.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Electrical Safety Tips',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16),
                _buildSafetyTip(
                  '1. Replace or repair damaged or loose electrical cords. Avoid running extension cords across doorways or under carpets.',
                ),
                _buildSafetyTip(
                  '2. In homes with small children, make sure your home has tamper-resistant (TR) receptacles.',
                ),
                _buildSafetyTip(
                  '3. Consider having additional circuits or outlets added by a qualified electrician so you do not have to use extension cords.',
                ),
                _buildSafetyTip(
                  "4. Follow the manufacturer's instructions for plugging an appliance into a receptacle outlet.",
                ),
                _buildSafetyTip(
                  '5. Avoid overloading outlets. Plug only one high-wattage appliance into each receptacle outlet at a time.',
                ),
                _buildSafetyTip(
                  '6. If outlets or switches feel warm, frequent problems with blowing fuses or tripping circuits, or flickering or dimming lights, call a qualified electrician.',
                ),
                _buildSafetyTip(
                  '7. Place lamps on level surfaces, away from things that can burn and use bulbs that match the lamp\'s recommended wattage.',
                ),
                _buildSafetyTip(
                  '8. Make sure your home has ground fault circuit interrupters (GFCIs) in the kitchen bathroom(s), laundry, basement, and outdoor areas.',
                ),
                _buildSafetyTip(
                  '9. Arc-fault circuit interrupters (AFCIs) should be installed in your home to protect electrical outlets.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSafetyTip(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        tip,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

