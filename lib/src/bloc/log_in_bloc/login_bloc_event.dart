part of 'login_bloc_bloc.dart';

@immutable
abstract class LoginBlocEvent extends Equatable {
  const LoginBlocEvent();
  @override
  List<Object> get props => [];
}

class LogInRequired extends LoginBlocEvent {
  final String email;
  final String password;

  const LogInRequired({required this.email, required this.password});
}

class LogOutRequired extends LoginBlocEvent {
  const LogOutRequired();
}
