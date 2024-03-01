import 'package:flutter_web_auth0_clean/app/injection_container.dart';
import 'package:flutter_web_auth0_clean/features/authentication/domain/entities/user_entity.dart';
import 'package:hive/hive.dart';

abstract class UserProfileRemoteDataSource {
  Future<UserEntity> getUserProfile();
}

class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  @override
  Future<UserEntity> getUserProfile() async {
    final Map<String, dynamic>? map = locator<Box>().get('userMap');
    final UserEntity userEntity = UserEntity.fromMap(map!);
    return userEntity;
  }
}
