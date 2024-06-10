import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repo/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepo userRepo;
  late final StreamSubscription<User?> _userSubscription;

  AuthenticationBloc({
    required UserRepo userRepo,
  })  : userRepo = userRepo,
        super(const AuthenticationState.unknown()) {
    _userSubscription = userRepo.user.listen((authUser) {
      add(AuthenticationUserChanged(user: authUser));
    });
    on<AuthenticationUserChanged>((event, emit) {
      if (event.user != null) {
        log(event.user!.email.toString());
        emit(AuthenticationState.authenticate(event.user!));
      } else {
        emit(const AuthenticationState.unauthenticate());
      }
    });
    @override
    Future<void> close() async {
      _userSubscription.cancel();
    }
  }
}
