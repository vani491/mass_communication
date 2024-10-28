//The form widget for user registration
import 'package:flutter/material.dart';

import '../../../../reusable_widget/loading_indicator.dart';
import '../../domain/usecases/register_user.dart';

class RegistrationForm extends StatefulWidget {
  final RegisterUser registerUser;

  const RegistrationForm({super.key, required this.registerUser});

  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _mobileNumber = '';
  String _email = '';
  String _password = '';
  String _selectedRole = 'Attendee';

  bool _isNameValid = true;
  bool _isMobileValid = true;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;

  // Method to handle role selection
  void _handleRoleChange(String? value) {
    setState(() {
      _selectedRole = value!;
    });
  }

  // Method to validate all fields
  bool _validateFields() {
    if (_name.isEmpty) {
      setState(() {
        _isNameValid = false;
      });
      return false;
    }

    if (_mobileNumber.isEmpty || _mobileNumber.length != 10) {
      setState(() {
        _isMobileValid = false;
      });
      return false;
    }

    if (_email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_email)) {
      setState(() {
        _isEmailValid = false;
      });
      return false;
    }

    if (_password.isEmpty || _password.length < 6) {
      setState(() {
        _isPasswordValid = false;
      });
      return false;
    }

    return true;
  }

  // Method to reset the form and fields
  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _name = '';
      _mobileNumber = '';
      _email = '';
      _password = '';
      _isNameValid = true;
      _isMobileValid = true;
      _isEmailValid = true;
      _isPasswordValid = true;
    });
  }

  // Method to handle user registration
  Future<void> _handleRegistration() async {
    // Show loading indicator
    _showLoadingIndicator();

    try {
      await widget.registerUser.call(
        name: _name,
        mobileNumber: _mobileNumber,
        email: _email,
        password: _password,
        role: _selectedRole,
      );

      // Dismiss loading indicator only if mounted
      if (mounted) {
        Navigator.of(context).pop();
      }

      // Clear the form and reset all fields
      _resetForm();

      // Show success snackbar with green background and icon, only if mounted
      if (mounted) {
        _showSuccessSnackbar();
      }
    } catch (e) {
      // Dismiss loading indicator only if mounted
      if (mounted) {
        Navigator.of(context).pop();
      }

      // Handle registration errors only if mounted
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  // Method to show loading indicator
  void _showLoadingIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: LoadingIndicator(message: 'Registering...'),
        );
      },
    );
  }

  // Method to show success snackbar
  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10), // Spacing between icon and text
            Text('User registered successfully'),
          ],
        ),
        backgroundColor: Colors.green, // Green background color for success
        behavior:
            SnackBarBehavior.floating, // Optional: Make the snackbar floating
      ),
    );
  }

  // Main submit method
  void _submit() async {
    if (_validateFields()) {
      _formKey.currentState!.save();
      await _handleRegistration();
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
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _name = value;
                  if (!_isNameValid) {
                    _resetErrorState(
                        'name'); // Reset error state outside build method
                  }
                },
                onSaved: (value) {
                  _name = value ?? '';
                },
              ),
              const SizedBox(height: 20),

              // Mobile Number Field
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  errorText: _isMobileValid
                      ? null
                      : 'Please enter a valid mobile number',
                  border: const OutlineInputBorder(),
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
              const SizedBox(height: 20),

              // Email Field
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: _isEmailValid
                      ? null
                      : 'Please enter a valid email address',
                  border: const OutlineInputBorder(),
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
              const SizedBox(height: 20),

              // Password Field
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: _isPasswordValid
                      ? null
                      : 'Password must be at least 6 characters',
                  border: const OutlineInputBorder(),
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
              const SizedBox(height: 10),

              // Role Selection Section in the RegistrationForm
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text('Register as:',
                    style: TextStyle(fontWeight: FontWeight.bold,  fontFamily: 'Roboto'),
                   ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // Evenly distribute the radio buttons
                children: [
                  // Custom Container for Attendee
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRole = 'Attendee';
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<String>(
                            value: 'Attendee',
                            groupValue: _selectedRole,
                            onChanged: _handleRoleChange,
                          ),
                          const Text(
                            'Attendee',
                            style: TextStyle(
                                fontFamily: 'Roboto' // Make the text bold
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Add some space between the two options
                  const SizedBox(width: 20),

                  // Custom Container for Organizer
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRole = 'Organizer';
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<String>(
                            value: 'Organizer',
                            groupValue: _selectedRole,
                            onChanged: _handleRoleChange,
                          ),
                          const Text(
                            'Organizer',
                            style: TextStyle(
                                fontFamily: 'Roboto' // Make the text bold
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF04224C),
                  // Custom button color
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: Text(
                  'Register'.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Set text color to white
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto' // Make the text bold
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
