//Handles Firebase registration and Firestore
//The repository is where Firebase Authentication and Firestore interaction is managed.

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class AddEventRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add an event in firestore
  Future<void> addEventToFirestore(Map<String, dynamic> eventData) async {
    try {
      //  Store additional user information (name, mobileNumber) in Firestore
      await _firestore.collection('events').add(eventData);

    } catch (e) {
      // Handle other errors (Firestore, network, etc.)
      throw PlatformException(
          code: 'ADD EVENT FAILED', message: 'Failed to add event.');
    }
  }
}
