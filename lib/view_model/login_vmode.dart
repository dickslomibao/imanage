import 'package:imanage/services/firebase_authetication.dart';
import 'package:imanage/services/firebase_user_firestore.dart';

class LoginViewModel {
  Future<String> login(username, password) async {
    final userData = await userFirestore.getUserDataForLogin(username);
    if (userData.docs.isEmpty) {
      return "Invalid username and password.";
    }
    return await authServices.loginWithEmailAndPasword(
        email: userData.docs[0]['email'], password: password);
  }
}

LoginViewModel loginViewModel = LoginViewModel();
