import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_auth0_clean/core/error/exceptions.dart';
import 'package:flutter_web_auth0_clean/features/authentication/data/models/credentials_model.dart';
import 'package:flutter_web_auth0_clean/features/authentication/data/models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<CredentialsModel> logIn();
  Future<void> logOut();
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  late Auth0Web auth0Web;

  AuthenticationRemoteDataSourceImpl() {
    auth0Web =
        Auth0Web(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
    // Install required callback
    auth0Web.onLoad().then((credentials) {
      // Do nothing
    });
  }

  @override
  Future<CredentialsModel> logIn() async {
    try {
      final credentials = await auth0Web.loginWithPopup();

      final userModel =
          UserModel(
            email: credentials.user.email, 
            name: credentials.user.name,
            isEmailVerified: credentials.user.isEmailVerified,
            pictureUrl: credentials.user.pictureUrl.toString(),
            updatedAt: credentials.user.updatedAt,
            nickname: credentials.user.nickname           
            );

      final credentialsModel = CredentialsModel(
          idToken: credentials.idToken,
          accessToken: credentials.accessToken,
          userModel: userModel);
      return credentialsModel;

    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await auth0Web.logout();
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
