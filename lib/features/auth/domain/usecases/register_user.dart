// Use case to trigger user registration

import 'dart:async';

import '../../data/repositories/auth_repository_impl.dart';

class RegisterUser {
  final AuthRepositoryImpl authRepository;

  RegisterUser(this.authRepository);

  // Call this method when registering a new user
  Future<void> call({
    required String name,
    required String mobileNumber,
    required String email,
    required String password,
    required String role,
    required String token,
  }) async {
    await authRepository.registerUser(
      name: name,
      mobileNumber: mobileNumber,
      email: email,
      password: password,
      role:role,
      token:token,
    );
  }
}
