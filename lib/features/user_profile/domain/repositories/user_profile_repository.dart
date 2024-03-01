import 'package:dartz/dartz.dart';
import 'package:flutter_web_auth0_clean/core/error/failures.dart';
import 'package:flutter_web_auth0_clean/features/authentication/domain/entities/user_entity.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, UserEntity>> getUserProfile();
}