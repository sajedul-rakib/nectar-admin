part of 'login_bloc_bloc.dart';

@immutable
abstract class LoginBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LogInInitial extends LoginBlocState {}

class LogInSuccess extends LoginBlocState {}

class LogInProcess extends LoginBlocState {}

class LogInFailure extends LoginBlocState {
  final String? message;
  LogInFailure({this.message});
}

class LogOutProcess extends LoginBlocState {}

class LogOutSuccess extends LoginBlocState {}
