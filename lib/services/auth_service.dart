import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  static CollectionReference users = FirebaseFirestore.instance.collection(
    'users',
  );
  static final _auth = FirebaseAuth.instance;
  final BuildContext _context;
  static final String? uid = _auth.currentUser?.uid;

  // final

  AuthService(this._context);

  // Authentication related methods will go here
  static Future<void> signUp(
    String email,
    String password,
    String role,
    String name,
    String contact,
    String address,
  ) async {
    // Sign up logic
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await saveUserData(credential.user?.uid, name, role, contact, address,email);
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
        // _uid = user.uid;
        Navigator.push(
          _context,
          MaterialPageRoute(builder: (context) => CustomerHome()),
        );
      }
    });
  }

  static Future<void> signIn(
    String email,
    String password,
    String role,
    BuildContext context,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      QuerySnapshot data = await users
          .where('uid', isEqualTo: _auth.currentUser?.uid)
          .get();
      print("User data: ${data.docs.first.data()}");

      Map<String, dynamic> userData =
          data.docs.first.data() as Map<String, dynamic>;

      if (userData['role'] == "Customer") {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.success,
          title: "Login Successful",
          desc: "You have been successfully logged in.",
          btnOkOnPress: () {},
        ).show();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CustomerHome(),
          ),
        );
      } else if (userData['role'] == "Owner") {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.success,
          title: "Login Successful",
          desc: "You have been successfully logged in as an Owner.",
          btnOkOnPress: () {},
        ).show();
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OwnerDashboard(),
          ),
        );
      } else {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          title: "Authentication Error",
          desc: "Invalid user role.",
          btnOkOnPress: () {},
        ).show();
      }
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
      } else {
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
      Fluttertoast.showToast(
        msg: e.message ?? "Error sending password reset email",
      );
    }
  }

  static Future<void> saveUserData(
    String? uid,
    String name,
    String role,
    String contact,
    String address,
    String email,
  ) async {
    if (uid != null) {
      await users.doc(uid).set({
        'uid': uid,
        'name': name,
        'role': role,
        'contact': contact,
        'address': address,
        'email': email,
      });
    } else {
      print("Error: User ID is null. Cannot save user data.");
    }
  }
}
