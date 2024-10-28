import 'package:flutter/material.dart';
import '../../../../reusable_widget/loading_indicator.dart';
import '../../domain/usecases/login_user.dart';

class LoginForm extends StatefulWidget {
  final LoginUser loginUser;
  const LoginForm({super.key, required this.loginUser});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _mobileNumber = '';
  String _password = '';

  bool _isMobileValid = true;
  bool _isPasswordValid = true;

  // Validate fields (mobile number and password) one by one
  bool _validateFields() {
    if (_mobileNumber.isEmpty || _mobileNumber.length != 10) {
      setState(() {
        _isMobileValid = false;
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

  // Reset the form after successful login
  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _mobileNumber = '';
      _password = '';
      _isMobileValid = true;
      _isPasswordValid = true;
    });
  }

  // Show loading indicator
  void _showLoadingIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: LoadingIndicator(message: 'Logging in...'),
        );
      },
    );
  }

  // Show success snackbar
  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Text('Login successful'),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),  // Show for 3 seconds
      ),
    );
  }

// Handle login process
  Future<void> _handleLogin() async {
    _showLoadingIndicator();

    try {
      String role = await widget.loginUser.loginUserWithRole(
        mobileNumber: _mobileNumber,
        password: _password,
      );

      // Dismiss loading indicator only if mounted
      if (mounted) {
        Navigator.of(context).pop();
      }

      // Clear the form
      _resetForm();

      // Show success message only if mounted
      if (mounted) {
        _showSuccessSnackbar();
      }

      // Wait for 3 seconds, then navigate to the home page
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          // Based on the role, navigate to different screens or perform role-based actions
          if (role == 'Organizer') {
            Navigator.pushReplacementNamed(context, '/organizerHome');
          } else {
            Navigator.pushReplacementNamed(context, '/attendeeHome');
          }

        }
      });
    } catch (e) {
      // Dismiss loading indicator only if mounted
      if (mounted) {
        Navigator.of(context).pop();
      }

      // Handle login errors only if mounted
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }


  // Main submit function
  void _submit() async {
    if (_validateFields()) {  // Validate form fields one by one
      _formKey.currentState!.save();  // Save form data
      await _handleLogin();  // Handle login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
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
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: 'Enter your mobile number',
                  border: const OutlineInputBorder(),
                  errorText: _isMobileValid ? null : 'Enter a valid mobile number',
                ),
                onChanged: (value) {
                  setState(() {
                    _mobileNumber = value;
                    // Clear error as soon as the input is valid
                    if (value.length == 10) _isMobileValid = true;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Password Input Field
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: const OutlineInputBorder(),
                  errorText: _isPasswordValid ? null : 'Password must be at least 6 characters',
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                    // Clear error as soon as the input is valid
                    if (value.length >= 6) _isPasswordValid = true;
                  });
                },
              ),
              const SizedBox(height: 30),  // Space between input fields and button

              // Login Button (Only color changed to #04224C)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF04224C),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: _submit,  // Call the submit function
                  child:  Text(
                    'Login'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto'
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),  // Space between the buttons
              // Registration Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF04224C)),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/registration');
                  },
                  child:  Text(
                    'Register'.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF04224C),
                        fontFamily: 'Roboto'
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
