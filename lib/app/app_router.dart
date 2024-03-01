import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_auth0_clean/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter_web_auth0_clean/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter_web_auth0_clean/features/user_profile/presentation/pages/user_profile_page.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          path: '/',
          name: 'user_profile',
          builder: (context, state) {
            return const UserProfilePage();
          },
        ),
      ],
      redirect: _guard);

  static String? _guard(BuildContext context, GoRouterState state) {
    final bool loggingIn = state.matchedLocation == '/login';
    if (context.read<AuthenticationBloc>().state is! LoggedIn) {
      return '/login';
    }
    // If the user is logged in but still on the login page, send them to
    // the profile page
    if (loggingIn) {
      return '/';
    }
    return null;
  }
}
