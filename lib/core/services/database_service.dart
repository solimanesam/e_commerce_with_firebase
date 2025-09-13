import 'package:e_commerce_with_firebase/core/models/database_input_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DatabaseService {
  Future addData({required DatabaseInputModel databaseInputModel});
  Future getData({required DatabaseInputModel databaseInputModel});
}

class DatabaseServiceImpl implements DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData({required DatabaseInputModel databaseInputModel}) async {
    if (databaseInputModel.docuementId != null) {
      await firestore
          .collection(databaseInputModel.path)
          .doc(databaseInputModel.docuementId)
          .set(databaseInputModel.data!);
    } else {
      await firestore
          .collection(databaseInputModel.path)
          .add(databaseInputModel.data!);
    }
  }

  @override
  Future<Map<String, dynamic>?> getData(
      {required DatabaseInputModel databaseInputModel}) async {
    final doc = await firestore
        .collection(databaseInputModel.path)
        .doc(databaseInputModel.docuementId)
        .get();

    if (!doc.exists) return null;
    return doc.data();
  }
}
