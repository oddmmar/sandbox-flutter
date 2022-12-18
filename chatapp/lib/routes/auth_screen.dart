import 'package:chatapp/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const routeName = '/auth-screen';
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  Future<void> _submitAuthForm(
      {required String email,
      required String password,
      required String username,
      required bool isLoginMode,
      required BuildContext context}) async {
    UserCredential userCredential;
    try {
      if (isLoginMode) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({'username': username, 'email': email});
      }
    } on PlatformException catch (error) {
      var msg = 'An error occurred. Please check credentials.';
      if (error.message != null) msg = error.message!;
      Scaffold.of(context).showBottomSheet(
        (context) => SnackBar(content: Text(msg)),
      );
    } catch (error) {
      // for any other errors
      // Scaffold.of(context).showBottomSheet(
      //   (context) => SnackBar(content: Text(error.toString())),
      // );
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(submitForm: _submitAuthForm),
    );
  }
}
