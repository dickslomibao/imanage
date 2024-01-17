import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:imanage/models/user_model.dart';
import 'package:imanage/services/firebase_user_firestore.dart';

class AuthServices {
  final auth = FirebaseAuth.instance;

  Future<String> createEmailAndPassword(UserModel user) async {
    String error = "";
    try {
      await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      await userFirestore.createUser(user.toFireStore());
      await updateUserDisplayName("${user.firstname} ${user.lastname}");
      await updateUserPhotoUrl(user.username);
      error = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        error = "Email is already used.";
      } else {
        error = e.code;
      }
    }
    return error;
  }

  Future<String> loginWithEmailAndPasword({
    required String email,
    required String password,
  }) async {
    String error = "";
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      error = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error = "Invalid username and password.";
      } else if (e.code == 'wrong-password') {
        error = "Password is incorrect.";
      } else {
        error = e.code;
      }
    }
    return error;
  }

  Future<void> updateUserDisplayName(String data) async {
    await auth.currentUser!.updateDisplayName(data);
  }

  Future<void> updateUserPhotoUrl(String data) async {
    await auth.currentUser!.updatePhotoURL(
        "https://api.multiavatar.com/$data.png?apikey=hCSoNROm6B3gp7");
  }

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
  }

  bool userProvideIsGoogle() {
    return auth.currentUser!.providerData[0].providerId == 'google.com';
  }

  String userUid() {
    return auth.currentUser!.uid;
  }

  Stream<User?> authChanges() {
    return auth.authStateChanges();
  }
}

AuthServices authServices = AuthServices();
