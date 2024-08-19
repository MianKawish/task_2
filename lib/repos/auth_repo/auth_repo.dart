import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_2/utils/utils.dart';

class AuthRepo {
  final _auth = FirebaseAuth.instance;
  final userRef = FirebaseFirestore.instance.collection("users");

  void updateUserData(String firstName, String lastName) async {
    try {
      if (_auth.currentUser != null) {
        await userRef
            .doc(_auth.currentUser!.uid)
            .update({'firstName': firstName, "lastName": lastName});
      }
    } catch (e) {
      Utils.flutterToast(e.toString());
    }
  }

  Future<List<String>> getUserData() async {
    List<String> userDataList = [];

    try {
      final DocumentSnapshot userData =
          await userRef.doc(_auth.currentUser!.uid).get();

      userDataList.add(userData['firstName']);
      userDataList.add(userData['lastName']);
      userDataList.add(userData['email']);
      return userDataList;
    } catch (e) {
      Utils.flutterToast(e.toString());
      return ["", "", ""];
    }
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  bool isUserLoggedIn() {
    final user = _auth.currentUser;

    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<User?> registerUser(
      String email, String password, String firstName, String lastName) async {
    try {
      final creds = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await userRef.doc(creds.user!.uid).set({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "uid": creds.user!.uid
      });

      return creds.user;
    } catch (e) {
      return null;
    }
  }

  loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return null;
    }
  }
}
