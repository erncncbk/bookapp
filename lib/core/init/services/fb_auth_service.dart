import 'package:bookapp/core/components/alert/alert_dialog.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:bookapp/core/init/services/storage_service.dart';
import 'package:bookapp/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FBAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AppStateProvider? _appStateProvider = locator<AppStateProvider>();
  StorageService? _storageService = locator<StorageService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _appStateProvider!.setToken(await userCredential.user!.getIdToken());
      await _storageService!
          .setTokenAsync(await userCredential.user!.getIdToken());
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      showAlertDialog(context, e.message!, () {
        Navigator.pop(context);
      });
    }
    return null;
  }

  Future resetPassword(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      return true;
    } on FirebaseAuthException catch (e) {
      showAlertDialog(context, e.message!, () {
        Navigator.pop(context);
      }); // show the snackbar here
    }
  }

  signOut(BuildContext context) async {
    _appStateProvider!.clearToken();
    _storageService!.clearStorageAsync();
    print(_appStateProvider!.getToken.toString());
    return await _auth.signOut().then((value) {
      showAlertDialogNoButton(context, "Session Ended");
    });
  }

  Future<User?> signUp(
      BuildContext context, String name, String email, String password) async {
    try {
      _appStateProvider!.setIsProgressIndicatorVisible(true);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      var fbUid = userCredential.user!.uid;
      _appStateProvider!.setToken(await userCredential.user!.getIdToken());
      await _firestore.collection('users').doc(fbUid).set({
        'email': email,
        'name': name,
        'fbUid': fbUid,
        "status": "Unavailable",
        "imageUrl": "",
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      });
      _appStateProvider!.setIsProgressIndicatorVisible(false);

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      showAlertDialog(context, e.message!, () {
        Navigator.pop(context);
      });
    }
  }
}
