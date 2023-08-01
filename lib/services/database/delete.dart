import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataDeleter {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> delete(String taskId) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete();
      debugPrint('Successfully deleted');
    } catch (e) {
      debugPrint(e.toString());
      throw ('Some error occurred');
    }
  }
}
