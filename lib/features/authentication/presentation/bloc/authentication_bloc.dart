import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_auth0_clean/features/authentication/domain/entities/credentials_entity.dart';
import 'package:flutter_web_auth0_clean/features/authentication/domain/usecases/login_usecase.dart';
import 'package:flutter_web_auth0_clean/features/authentication/domain/usecases/logout_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LogInUseCase logInUseCase;
  final LogOutUseCase logOutUseCase;
  AuthenticationBloc({required this.logInUseCase, required this.logOutUseCase})
      : super(AuthInitialState()) {
        
    on<LogIn>((event, emit) async {
      final failureOrCredentials = await logInUseCase();
      emit(failureOrCredentials.fold((exception) {
        return const LoginFailed(message: "Login error");
      }, (credentials) => LoggedIn(credentialsEntity: credentials)));
    });

    on<LogOut>((event, emit) async {
      final failureOrLogOut = await logOutUseCase();
      emit(failureOrLogOut.fold((exception) {
        return const LoginFailed(message: "Logout error");
      }, (credentials) => LoggedOut()));
    });

    on<AuthInit>((event, emit) async {
      // Do nothing
    });
  }
}
