part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();
  
  @override
  List<Object> get props => [];
}

final class UserProfileInitial extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final UserEntity user;

  const UserProfileLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class UserProfileLoadFailure extends UserProfileState {
  final String message;

  const UserProfileLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}