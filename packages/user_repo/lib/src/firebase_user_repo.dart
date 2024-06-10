import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repo/src/entities/user_entities.dart';
import 'package:user_repo/src/models/my_user.dart';
import 'package:user_repo/src/user_repo.dart';

class FirebaseUserRepo implements UserRepo {
  FirebaseUserRepo({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final _userCollection = FirebaseFirestore.instance.collection("admin");
  final FirebaseAuth _firebaseAuth;

  @override
  // TODO: implement user
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((authUser) {
      return authUser;
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> getUserData(String userId) async {
    try {
      return _userCollection.doc(userId).get().then((userData) {
        return MyUser.fromEntity(MyUserEntities.fromDocument(userData.data()!));
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
