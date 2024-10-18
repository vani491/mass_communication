// Use case to trigger user registration

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
  }) async {
    await authRepository.registerUser(
      name: name,
      mobileNumber: mobileNumber,
      email: email,
      password: password,
    );
  }
}
