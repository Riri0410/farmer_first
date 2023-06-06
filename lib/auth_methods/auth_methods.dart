import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  signUpUser(
      {required String name,
      required String pancardNumber,
      required String email,
      required String password}) async {
    String res = "Some Error Occured!";
    try {
      if (email.isNotEmpty ||
          name.isNotEmpty ||
          pancardNumber.isNotEmpty ||
          password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'name': name,
          'UID': cred.user!.uid,
          'email': email,
          'pancard': pancardNumber,
          'currentscore': 0,
          'presentcrops': 0,
          'totalbalance': 0,
          'loanstaken': 0,
          'loanspaidback': 0,
          'previouscreditscore': 0,
          'isuser': true,
        });
        res = "Successfully Registered! Proceed to Login";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'Please Enter a Valid Email Address!';
      }
      if (err.code == 'email-already-in-use') {
        res = 'Account Already Exists!';
      }
      if (err.code == 'weak-password') {
        res = 'Weak Password! Use atleast 6 digits';
      }
    } catch (err) {
      res = err.toString();
    }
    print(res);
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Inavlid Credentials!";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Successfully Logged In!";
      } else {}
    } catch (err) {
      res = res.toString();
    }
    return res;
  }
}

Future<String> getdata(String query) async {
  String data;
  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  if (snapshot.exists) {
    Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
    data = userData[query].toString();
  } else {
    data = '';
  }

  return data;
}

Future<int> getIntData(String query) async {
  int data;

  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  if (snapshot.exists) {
    Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
    data = userData[query] as int;
  } else {
    data = 0;
  }

  return data;
}

Future<void> setData(String field, String value) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
      await userRef.update({field: value});
    }
  } catch (e) {
    print('Error updating data: $e');
    throw e;
  }
}
