import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/user_preference.dart';

class LoginUser {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> loginUserWithRole({
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

      // 3. User exists, extract the role from the Firestore document
      final userDoc = querySnapshot.docs.first;
      final role = userDoc['Role'] as String;  // Assuming 'role' is stored as a string in Firestore
      final userName = userDoc['User Name'] as String;  // Assuming 'Name' is stored as a string
      final userMobileNumber = userDoc['Mobile Number'] as String;  // Assuming 'MobileNumber' is stored as a string
      final userId = userDoc['Id'] as String;  // Assuming 'MobileNumber' is stored as a string

      // Store extracted details in shared preferences
      await UserPreferences.storeUserData(userName, userMobileNumber, role,userId);

      // 4. Return the role to be used in the UI (or for any other logic)
      return role;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }
}
