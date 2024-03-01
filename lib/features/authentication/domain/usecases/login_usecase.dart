import 'package:dartz/dartz.dart';
import 'package:flutter_web_auth0_clean/core/error/failures.dart';
import 'package:flutter_web_auth0_clean/features/authentication/domain/entities/credentials_entity.dart';
import 'package:flutter_web_auth0_clean/features/authentication/domain/repositories/authentication_repository.dart';

class LogInUseCase {
  final AuthenticationRepository repository;

  LogInUseCase(this.repository);

  Future<Either<Failure, CredentialsEntity>> call() async {
    return await repository.logIn();
  }
}