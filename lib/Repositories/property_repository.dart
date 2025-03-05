import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/property_model.dart';

class PropertyRepository {
  final FirebaseFirestore firestore;

  PropertyRepository({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<PropertyModel>> fetchProperties() async {
    try {
      final querySnapshot =
          await firestore.collection('Listings').orderBy('price').get();

      return querySnapshot.docs.map((doc) {
        return PropertyModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }
}
