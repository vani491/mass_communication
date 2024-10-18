import 'package:flutter/material.dart';

import '../widgets/login_form.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [
              Colors.white,
              Color(0xFF99C0D6),  // Light blue gradient color
            ],
          ),
        ),
        child:  Padding(
          padding: const EdgeInsets.all(16.0),
          child: LoginForm(), // Call to the LoginForm widget
        ),
      ),
    );
  }
}
