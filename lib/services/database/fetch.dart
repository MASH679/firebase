import 'package:cloud_firestore/cloud_firestore.dart';

class DataFetcher {
  static final _firestore = FirebaseFirestore.instance;

  static Future<List<Map<String, dynamic>>> fetchAllTasks() async {
    try {
      final querySnapshot = await _firestore.collection('tasks').get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print(e.toString());
      throw ('Some error occurred');
    }
  }
}
