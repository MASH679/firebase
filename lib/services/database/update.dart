import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataUpdater {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> update(String taskId, String updatedTask) async {
    try {
      await _firestore.collection('tasks').doc(taskId).update({
        'task': updatedTask,
      });
      debugPrint('Successfully updated');
    } catch (e) {
      debugPrint(e.toString());
      throw ('Some error occurred');
    }
  }
}
