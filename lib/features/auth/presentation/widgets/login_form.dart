import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _mobileNumber = '';
  String _password = '';

  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Logic for Firebase integration or navigation will go here later
      print("Logging in with mobile: $_mobileNumber, password: $_password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(  // Center the entire form
      child: SingleChildScrollView(  // Use SingleChildScrollView to avoid overflow
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // App Logo at the top
              Image.asset(
                'assets/images/mass_communication_logo.png',  // Replace with your logo path
                height: 100,  // Adjust the height according to your logo
                width: 100,
              ),
              const SizedBox(height: 30),  // Space between logo and input fields

              // Mobile Number Input Field
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: 'Enter your mobile number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  if (value.length != 10) {
                    return 'Mobile number must be 10 digits';
                  }
                  return null;
                },
                onSaved: (value) {
                  _mobileNumber = value ?? '';
                },
              ),
              const SizedBox(height: 20),

              // Password Input Field
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value ?? '';
                },
              ),
              const SizedBox(height: 30),  // Space between input fields and button

              // Login Button (Only color changed to #04224C)
              SizedBox(
                width: double.infinity,  // Makes the button width match the input fields
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF04224C),  // Custom button color as #04224C
                    padding: const EdgeInsets.symmetric(vertical: 15),  // Remove horizontal padding to match width
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: _login,
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,  // Set text color to white
                      fontWeight: FontWeight.bold,  // Make the text bold
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),  // Space between the buttons
              // Registration Button
              SizedBox(
                width: double.infinity,  // Makes the button width match the input fields
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF04224C)),  // Stroke color same as login button
                    padding: const EdgeInsets.symmetric(vertical: 15),  // Set vertical padding
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    // Registration button logic here
                    Navigator.of(context).pushNamed('/registration');
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Color(0xFF04224C),  // Text color same as stroke color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
