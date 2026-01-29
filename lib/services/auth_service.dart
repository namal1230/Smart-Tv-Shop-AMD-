import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:smart_tv_shop/providers/auth_provider.dart';
import 'package:smart_tv_shop/screens/auth/login_screen.dart';
import 'package:smart_tv_shop/screens/customer/customer_home.dart';
import 'package:smart_tv_shop/screens/owner/owner_dashboard.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  final BuildContext _context;

  AuthService(this._context);

  // Authentication related methods will go here
  static Future<void> signUp(String email, String password) async {
    // Sign up logic
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  // Future<UserCredential> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth.idToken,
  //   );

  //   return await _auth.signInWithCredential(credential);
  // }

  Future<void> initializeUser() async {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        AwesomeDialog(
          context: _context,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          title: "Authentication Error",
          desc: "User is not logged in",
          btnOkOnPress: () {},
        ).show();

        Navigator.pop(_context);
      } else {
        Navigator.push(
          _context,
          MaterialPageRoute(builder: (context) => CustomerHome()),
        );
      }
    });
  }

  static Future<void> signIn(String email, String password, String role,BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(msg: "Login Successful");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => role == "Customer" ? CustomerHome() : OwnerDashboard()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
         AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          title: "Authentication Error",
          desc: "No user found for that email.",
          btnOkOnPress: () {},
        ).show();

      } else if (e.code == 'wrong-password') {
         AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          title: "Authentication Error",
          desc: "Wrong password provided for that user.",
          btnOkOnPress: () {},
        ).show();
      } else{
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          title: "Authentication Error",
          desc: "User is not found.",
          btnOkOnPress: () {},
        ).show();
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    Navigator.pop(_context);
  }

  static Future<void> resetPassword(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(msg: "Password reset email sent");
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message ?? "Error sending password reset email");
    }
  }
}
