import 'package:cloud_firestore/cloud_firestore.dart';

import '../pages/Models/user_model.dart';

class DatabaseHelper {
  static const String collectionUser = 'User';
  static const String collectionMyConnections = 'MyConnections';
  static const String collectionProduct = 'Product';
  static const String collectionNotification = 'Notifications';
  static const String collectionConnections = 'Connections';
  static const String collectionCategory = 'Category';
  static const String collectionUniversity = 'University';
  static const String collectionHall = 'Hall';

  static final FirebaseFirestore _db = FirebaseFirestore.instance;



  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllHall() =>
      _db.collection(collectionHall).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUniversity() =>
      _db.collection(collectionUniversity).snapshots();



  static Stream<QuerySnapshot<Map<String, dynamic>>> getNotifications(
      {required String uid}) =>
      _db.collection(collectionNotification).snapshots();



  static Future<void> addUser(UserModel userModel) {
    return _db.collection(collectionUser)
        .doc(userModel.uid).set(userModel.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllConnections() =>
      _db.collection(collectionMyConnections).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getConnectionsCount({required String status}) =>
      _db.collection(collectionMyConnections).where('status', isEqualTo: status ).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserById(String uid) =>
      _db.collection(collectionUser).doc(uid).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getSingleUserData(
      {required String uid}) =>
      _db.collection(collectionUser).where('uid', isEqualTo: uid).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getSingleProduct(
      {required String productId}) =>
      _db.collection(collectionProduct).where('productId', isEqualTo: productId).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCurrentUserData(
      {required String uid}) =>
      _db.collection(collectionUser).where('uid', isEqualTo: uid).snapshots();

  static Future<void> updateUser(String uid, Map<String, dynamic> map) async {
    return await _db.collection(collectionUser)
        .doc(uid)
        .update(map);
  }


  static Future<void> updateNotification(String nid, Map<String, dynamic> map) async {
    return await _db.collection(collectionNotification)
        .doc(nid)
        .update(map);
  }

  static Future<void> updateProduct(String productId, Map<String, dynamic> map) async {
    return await _db.collection(collectionProduct)
        .doc(productId)
        .update(map);
  }

  static Future<void> updateCategory(Map<String, dynamic> map) async {
    return await _db.collection(collectionCategory)
        .doc('wJfAhNM2nHOixfPv46pW')
        .update(map);
  }

  static Future<void> updateConnection(
      {required String cId,required Map<String, dynamic> map}) async {
    return await _db.collection(collectionMyConnections)
        .doc(cId)
        .update(map);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllSuggestions(
      {required String queryAttribute, required dynamic value, required dynamic floor}) =>
      _db.collection(collectionUser).where(queryAttribute, isEqualTo: value).where('floor', isEqualTo: floor).snapshots();


  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() =>
      _db.collection(collectionUser).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCategory() =>
      _db.collection(collectionCategory).snapshots();


  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProduct() =>
      _db.collection(collectionProduct).snapshots();
}