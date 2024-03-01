import 'package:dartz/dartz.dart';
import 'package:flutter_web_auth0_clean/core/error/failures.dart';
import 'package:flutter_web_auth0_clean/features/authentication/domain/entities/credentials_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, CredentialsEntity>> logIn();
  Future<Either<Failure, Unit>> logOut();
}
