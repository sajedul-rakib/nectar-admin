import 'package:admin_panel/app.dart';
import 'package:admin_panel/bloc_observer.dart';
import 'package:admin_panel/firebase_options.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:product_repo/product_repository.dart';
import 'package:user_repo/user_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = AppBlocObserber();
  runApp(MainApp(
    userRepo: FirebaseUserRepo(),
    productRepo: FirebaseProductRepo(),
  ));
}
