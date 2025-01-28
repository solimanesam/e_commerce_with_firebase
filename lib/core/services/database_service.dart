import 'package:e_commerce_with_firebase/core/models/database_input_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DatabaseService {
  Future addUser({required DatabaseInputModel databaseInputModel});
}

class DatabaseServiceImpl implements DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future addUser({required DatabaseInputModel databaseInputModel}) async {
    if (databaseInputModel.docuementId != null) {
      firestore
          .collection(databaseInputModel.path)
          .doc(databaseInputModel.docuementId)
          .set(databaseInputModel.data!);
    } else {
      await firestore
          .collection(databaseInputModel.path)
          .add(databaseInputModel.data!);
    }
  }
}
