part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthInit extends AuthenticationEvent {}
class LogIn extends AuthenticationEvent {}
class LogOut extends AuthenticationEvent {}

