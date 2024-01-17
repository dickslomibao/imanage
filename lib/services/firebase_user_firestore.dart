import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imanage/models/user_model.dart';
import 'package:imanage/services/firebase_authetication.dart';

class UserFirestore {
  final firestore = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(final map) async {
    await firestore.doc(authServices.userUid()).set(map);
  }

  Future<bool> usernameIsUsed(String data, {String except = "forreg"}) async {
    if (except == 'forreg') {
      QuerySnapshot<Map<String, dynamic>> result =
          await firestore.where('username', isEqualTo: data).get();
      return result.docs.isNotEmpty;
    } else {
      QuerySnapshot<Map<String, dynamic>> result = await firestore
          .where('username', isNotEqualTo: except)
          .where('username', isEqualTo: data)
          .get();
      return result.docs.isNotEmpty;
    }
  }

  Future<void> updateUserData(UserModel data) async {
    await firestore
        .doc(authServices.userUid())
        .update(data.toFireStoreUpdate());
    await authServices
        .updateUserDisplayName("${data.firstname} ${data.lastname}");
  }

  Future<bool> emailisUsed(String data, String except) async {
    QuerySnapshot<Map<String, dynamic>> result = await firestore
        .where('email', isNotEqualTo: except)
        .where('email', isEqualTo: data)
        .get();
    return result.docs.isNotEmpty;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserDataForLogin(
      String data) async {
    return await firestore.where('username', isEqualTo: data).get();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserDataForUpdate() {
    return firestore.doc(authServices.userUid()).snapshots();
  }
}

UserFirestore userFirestore = UserFirestore();
