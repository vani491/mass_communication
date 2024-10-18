//The form widget for user registration
import 'package:flutter/material.dart';

import '../../domain/usecases/register_user.dart';


class RegistrationForm extends StatefulWidget {

  final RegisterUser registerUser;

  RegistrationForm({required this.registerUser});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _mobileNumber = '';
  String _email = '';
  String _password = '';

  bool _isNameValid = true;
  bool _isMobileValid = true;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;

  // Method to validate and submit the form
  void _submit() async {
    // First, validate the Name field
    if (_name.isEmpty) {
      setState(() {
        _isNameValid = false;
      });
      return;  // Stop further validation
    }

    // If Name is valid, validate the Mobile Number field
    if (_mobileNumber.isEmpty || _mobileNumber.length != 10) {
      setState(() {
        _isMobileValid = false;
      });
      return;  // Stop further validation
    }

    // If Mobile Number is valid, validate the Email field
    if (_email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_email)) {
      setState(() {
        _isEmailValid = false;
      });
      return;  // Stop further validation
    }

    // If Email is valid, validate the Password field
    if (_password.isEmpty || _password.length < 6) {
      setState(() {
        _isPasswordValid = false;
      });
      return;  // Stop further validation
    }

    // If all fields are valid, save the form
    _formKey.currentState!.save();
    try {
      await widget.registerUser.call(
        name: _name,
        mobileNumber: _mobileNumber,
        email: _email,
        password: _password,
      );

      // Show success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User registered successfully')));
    } catch (e) {
      // Handle registration errors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }



  // Method to remove the error when typing
  void _resetErrorState(String field) {
    setState(() {
      switch (field) {
        case 'name':
          _isNameValid = true;
          break;
        case 'mobile':
          _isMobileValid = true;
          break;
        case 'email':
          _isEmailValid = true;
          break;
        case 'password':
          _isPasswordValid = true;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // Center the entire form
      child: SingleChildScrollView(
        // Use SingleChildScrollView to avoid overflow
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // Auto-validate when user interacts
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // App Logo at the top
              Image.asset(
                'assets/images/mass_communication_logo.png',
                // Replace with your logo path
                height: 100, // Adjust the height according to your logo
                width: 100,
              ),
              const SizedBox(height: 30),

              // Name Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  errorText: _isNameValid ? null : 'Please enter your name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _name = value;
                  if (!_isNameValid) {
                    _resetErrorState('name');  // Reset error state outside build method
                  }
                },

                onSaved: (value) {
                  _name = value ?? '';
                },
              ),
              SizedBox(height: 20),

              // Mobile Number Field
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  errorText: _isMobileValid
                      ? null
                      : 'Please enter a valid mobile number',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _mobileNumber = value;
                  if (!_isMobileValid) {
                    _resetErrorState('mobile');
                  }
                },

                onSaved: (value) {
                  _mobileNumber = value ?? '';
                },
              ),
              SizedBox(height: 20),

              // Email Field
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: _isEmailValid
                      ? null
                      : 'Please enter a valid email address',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _email = value;
                  if (!_isEmailValid) {
                    _resetErrorState('email');
                  }
                },

                onSaved: (value) {
                  _email = value ?? '';
                },
              ),
              SizedBox(height: 20),

              // Password Field
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: _isPasswordValid
                      ? null
                      : 'Password must be at least 6 characters',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _password = value;
                  if (!_isPasswordValid) {
                    _resetErrorState('password');
                  }
                },

                onSaved: (value) {
                  _password = value ?? '';
                },
              ),
              SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Set text color to white
                    fontWeight: FontWeight.bold, // Make the text bold
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF04224C), // Custom button color
                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
