import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repo/src/models/my_user.dart';

abstract class UserRepo {
  Stream<User?> get user;
  //log in method
  Future<void> signIn(String email, String password);

  //log out
  Future<void> logOut();

  //reset password
  Future<void> resetPassword(String email);

  //get user data
  Future<MyUser> getUserData(String userId);
}
