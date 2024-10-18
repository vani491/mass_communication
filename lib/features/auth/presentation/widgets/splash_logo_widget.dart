import 'package:flutter/material.dart';

class SplashLogoWidget extends StatelessWidget {
  const SplashLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Concentric Circle 1
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue[50],  // Light blue color
                shape: BoxShape.circle,
              ),
            ),
            // Concentric Circle 2
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.blue[100],  // Slightly darker blue
                shape: BoxShape.circle,
              ),
            ),
            // Concentric Circle 3
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blue[300],  // Darker blue
                shape: BoxShape.circle,
              ),
            ),
            // App Logo (Middle)
            Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                color: Colors.blue,  // Main blue color
                shape: BoxShape.circle,
              ),
              child:  Center(
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    color: Colors.blue,  // Main blue color for the background of the circle
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',  // Path to your logo file
                      height: 40,  // Adjust the height of the logo to fit in the circle
                      width: 40,   // Adjust the width of the logo
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20), // Space between the logo and text
        // "Mass Communication" Text
        Text(
          'SMART CONNECT',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue[900],  // Darker blue text color
            shadows: [
              Shadow(
                offset: const Offset(2.0, 2.0),  // Position of the shadow (x, y)
                blurRadius: 3.0,  // Softness of the shadow
                color: Colors.grey.withOpacity(0.5),  // Shadow color with some opacity
              ),
            ],
          ),
        ),

      ],
    );
  }
}
