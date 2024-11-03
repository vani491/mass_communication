
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../core/user_preference.dart';

class ProfilePage extends StatelessWidget {
  final NotchBottomBarController? controller;

  const ProfilePage({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userName = UserPreferences.getUserName() ?? "Username";
    String mobileNumber = UserPreferences.getMobileNumber() ?? "Mobile Number";
    String email =  "er94ShivaniSIngh@gmail.com";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF04224C),  // Set custom background color
        title: const Row(
          children: [
            Icon(Icons.person, size: 28, color: Colors.white),  // Set icon color to white
            SizedBox(width: 10),  // Add some space between icon and title
            Text('Profile', style: TextStyle(color: Colors.white, fontFamily: 'Roboto',)),  // Set text color to white
          ],
        ),
        actions: [
          IconButton(
            icon: Row(
              children: [
                Icon(Icons.logout, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                const Text("Logout", style: TextStyle(color: Colors.grey)),
              ],
            ),
            onPressed: () {
              // Add logout logic here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.pink.shade400,
                child: const Icon(Icons.person, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                userName,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  fontFamily: 'Roboto',),
              ),
              Text(
                email,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600,  fontFamily: 'Roboto',),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfoCard("Registered Event", "14", Colors.purple),
                  _buildInfoCard("Total Event", "60", Colors.blue),
                  _buildInfoCard("Unregistered Event", "46", Colors.teal),
                ],
              ),
              const SizedBox(height: 32),
              _buildListTile("Mobile Number", mobileNumber, Colors.red.shade100, Icons.phone),
              const SizedBox(height: 10),
              _buildListTile("Gender", "Female", Colors.green.shade100, Icons.female),
              const SizedBox(height: 10),
              _buildListTile("Address", "South west Colony, New Delhi ", Colors.orange.shade100, Icons.location_city),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, Color color) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            fontFamily: 'Roboto',
          ),
        ),
      ],
    );
  }

  Widget _buildListTile(String title, String subtitle, Color color, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto',)),
        subtitle: Text(subtitle, style:const TextStyle( fontFamily: 'Roboto',),),
      ),
    );
  }
}
