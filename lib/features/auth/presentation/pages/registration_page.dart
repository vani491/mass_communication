//UI page for user registration
import 'package:flutter/material.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/register_user.dart';
import '../widgets/registration_form.dart';


class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {

    // Instantiate AuthRepositoryImpl and RegisterUser
    final authRepository = AuthRepositoryImpl();
    final registerUser = RegisterUser(authRepository);

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
          child:RegistrationForm(registerUser: registerUser), // Call to the LoginForm widget
        ),
      ),
    );
  }
}
