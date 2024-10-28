import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final NotchBottomBarController? controller;

  const NotificationPage({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF04224C),  // Set custom background color
          title: const Row(
            children: [
              Icon(Icons.notification_important, size: 28, color: Colors.white),  // Set icon color to white
              SizedBox(width: 10),  // Add some space between icon and title
              Text('Notification', style: TextStyle(color: Colors.white)),  // Set text color to white
            ],
          ),
        ),
        body:Container(
          color: Colors.white,
          child: Center(
            /// adding GestureDetector
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                controller?.jumpTo(2);
              },
              child: const Text('Notification Page'),
            ),
          ),
        )
    );
  }
}

