import 'package:dartz/dartz.dart';
import 'package:flutter_web_auth0_clean/core/error/failures.dart';
import 'package:flutter_web_auth0_clean/features/authentication/domain/repositories/authentication_repository.dart';

class LogOutUseCase {
  final AuthenticationRepository repository;

  LogOutUseCase(this.repository);

  Future<Either<Failure, Unit>> call() async {
    return await repository.logOut();
  }
}