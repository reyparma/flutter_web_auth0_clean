import 'package:flutter_web_auth0_clean/features/authentication/data/models/user_model.dart';
import 'package:flutter_web_auth0_clean/features/authentication/domain/entities/credentials_entity.dart';

class CredentialsModel extends CredentialsEntity {
  const CredentialsModel(
      {required String idToken,
      required String accessToken,
      required UserModel userModel})
      : super(
            idToken: idToken, accessToken: accessToken, userEntity: userModel);

  factory CredentialsModel.fromJson(Map<String, dynamic> map) {
    return CredentialsModel(
        idToken: map['idToken'],
        accessToken: map['accessToken'],
        userModel: UserModel.fromJson(map['user']));
  }

  factory CredentialsModel.fromEntity(CredentialsEntity entity) {
    return CredentialsModel(
        idToken: entity.idToken,
        accessToken: entity.accessToken,
        userModel: UserModel.fromEntity(entity.userEntity));
  }
}
