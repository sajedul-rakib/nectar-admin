part of 'authentication_bloc.dart';

enum Authenticate { authenticate, unauthenticate, unknown }

class AuthenticationState extends Equatable {
  final User? user;
  final Authenticate status;

  const AuthenticationState._({this.status = Authenticate.unknown, this.user});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticate(User user)
      : this._(status: Authenticate.authenticate, user: user);

  const AuthenticationState.unauthenticate()
      : this._(status: Authenticate.unauthenticate);

  @override
  List<Object?> get props => [status, user];
}
