import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_repo/user_repository.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBlocBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  final UserRepo _userRepo;
  LoginBlocBloc({required UserRepo userRepo})
      : _userRepo = userRepo,
        super(LogInInitial()) {
    on<LogInRequired>((event, emit) async {
      try {
        emit(LogInProcess());
        await _userRepo.signIn(event.email, event.password);
        emit(LogInSuccess());
      } catch (e) {
        log("error is ${e.toString()}");
        emit(LogInFailure(message: e.toString()));
      }
    });

    on<LogOutRequired>((event, emit) async {
      emit(LogOutProcess());
      await _userRepo.logOut();
      emit(LogOutSuccess());
    });
  }
}
