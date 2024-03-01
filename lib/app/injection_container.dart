import 'package:flutter_web_auth0_clean/features/authentication/data/datasources/authentication_remote_datasource.dart';
import 'package:flutter_web_auth0_clean/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_web_auth0_clean/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:flutter_web_auth0_clean/features/authentication/domain/usecases/login_usecase.dart';
import 'package:flutter_web_auth0_clean/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:flutter_web_auth0_clean/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter_web_auth0_clean/features/user_profile/data/datasources/user_profile_remote_datasource.dart';
import 'package:flutter_web_auth0_clean/features/user_profile/data/repositories/user_profile_repository_impl.dart';
import 'package:flutter_web_auth0_clean/features/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:flutter_web_auth0_clean/features/user_profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:flutter_web_auth0_clean/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  Hive.init('.');
  await Hive.openBox('hiveBox');

  locator.registerFactory<Box>(() {
    return Hive.box('hiveBox');
  });

// Blocs
  locator.registerFactory(() =>
      AuthenticationBloc(logInUseCase: locator(), logOutUseCase: locator()));
  locator
      .registerFactory(() => UserProfileBloc(getUserProfileUseCase: locator()));

// Usecases
  locator.registerLazySingleton(() => LogInUseCase(locator()));
  locator.registerLazySingleton(() => LogOutUseCase(locator()));
  locator.registerLazySingleton(
      () => GetUserProfileUseCase(repository: locator()));

// Repository
  locator.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(authenticationRemoteDataSource: locator()));
  locator.registerLazySingleton<UserProfileRepository>(
      () => UserProfileRepositoryImpl(userProfileRemoteDataSource: locator()));

// Datasources
  locator.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl());
  locator.registerLazySingleton<UserProfileRemoteDataSource>(
      () => UserProfileRemoteDataSourceImpl());
}
