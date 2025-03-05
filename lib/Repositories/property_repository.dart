import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/property_model.dart';

class PropertyRepository {
  final FirebaseFirestore firestore;

  PropertyRepository({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<PropertyModel>> fetchProperties() async {
    try {
      final querySnapshot = await firestore.collection('Listings').get();
      print('Repository: Retrieved ${querySnapshot.docs.length} documents');
      return querySnapshot.docs.map((doc) {
        return PropertyModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Repository: Error - $e');
      rethrow;
    }
  }
}
