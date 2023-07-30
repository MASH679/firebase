import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DataWriter {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> create(String task) async {
    final id = const Uuid().v4();
    try {
      await _firestore.collection('tasks').doc(id).set({
        'task': task,
        'isDone': false,
      });
      debugPrint('Successfully added');
    } catch (e) {
      debugPrint(e.toString());
      throw ('Some error occurred');
    }
  }
}
