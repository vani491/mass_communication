import 'package:cloud_firestore/cloud_firestore.dart';

class LoginUser {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> call({
    required String mobileNumber,
    required String password,
  }) async {
    try {
      // 1. Query Firestore to check if the user with the given mobile number and password exists
      final querySnapshot = await _firestore
          .collection('users')
          .where('Mobile Number', isEqualTo: mobileNumber)
          .where('Password', isEqualTo: password)  // Assuming password is stored in Firestore
          .limit(1)
          .get();

      // 2. Check if any user was found with the given credentials
      if (querySnapshot.docs.isEmpty) {
        throw Exception('Invalid mobile number or password');
      }

      // 3. User exists, proceed to home page (handle navigation in UI)
      return;  // If user exists, the caller will handle navigation
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }
}
