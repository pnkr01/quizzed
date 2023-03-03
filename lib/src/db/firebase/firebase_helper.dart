import 'package:cloud_firestore/cloud_firestore.dart';

class MyFirebase {
  static var ref = FirebaseFirestore.instance;
  static var storeCollection = FirebaseFirestore.instance.collection('store');
}
