 //Handles Firebase registration and Firestore
 //The repository is where Firebase Authentication and Firestore interaction is managed.

 import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
 import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:flutter/services.dart';

 class AuthRepositoryImpl {
   final FirebaseAuth _auth = FirebaseAuth.instance;
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   // Register user with email & password, then store additional data in Firestore
   Future<void> registerUser({
     required String name,
     required String mobileNumber,
     required String email,
     required String password,
     required String role,
     required String token,
   }) async {
     try {
       // 1. Register user with email & password using Firebase Auth
       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
         email: email,
         password: password,
       );

       // 2. Get the newly created user's UID
       String uid = userCredential.user!.uid;

       // 3. Store additional user information (name, mobileNumber) in Firestore
       await _firestore.collection('users').doc(uid).set({
         'userName': name,
         'mobileNumber': mobileNumber,
         'email': email,
         'userId': uid,
         'createdAt': FieldValue.serverTimestamp(),
         'password' : password,
         'role': role,
         'token': token

       });
     } on FirebaseAuthException catch (e) {
       // Handle Firebase Auth errors (e.g., email already in use)
       throw PlatformException(code: e.code, message: e.message);
     } catch (e) {
       // Handle other errors (Firestore, network, etc.)
       throw PlatformException(code: 'REGISTRATION_FAILED', message: 'Failed to register user.');
     }
   }
 }
